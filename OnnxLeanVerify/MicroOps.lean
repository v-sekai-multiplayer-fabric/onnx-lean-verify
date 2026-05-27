-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
--
-- Tinygrad micro-op kernel: all ONNX operators decompose into these primitives.
-- Transcendental and bitwise ops are opaque (sound: no sorry).
import OnnxLeanVerify.Tensor
namespace OnnxLeanVerify

inductive UOp where | neg | recip | sqrt | sin | exp2 | log2 | trunc
  deriving Repr, BEq, DecidableEq
inductive BOp where
  | add | mul | sub | max | cdiv | cmod
  | cmplt | cmpne | cmpeq
  | floordiv | floormod
  | fdiv | pow_ | shl | shr | xor_ | or_ | and_
  deriving Repr, BEq, DecidableEq
inductive TOp where | where_ | mulacc
  deriving Repr, BEq, DecidableEq
inductive ROp where | sum | prod | max
  deriving Repr, BEq, DecidableEq
inductive MOp where | reshape | permute | expand | pad | shrink | flip
  deriving Repr, BEq, DecidableEq

-- Opaque implementations for hardware-dependent micro-ops (sound, no sorry)
opaque recip_impl : Int → Int
opaque sqrt_impl : Int → Int
opaque sin_impl : Int → Int
opaque exp2_impl : Int → Int
opaque log2_impl : Int → Int
opaque fdiv_impl : Int → Int → Int
opaque pow_impl : Int → Int → Int
opaque shl_impl : Int → Int → Int
opaque shr_impl : Int → Int → Int
opaque xor_impl : Int → Int → Int
opaque or_impl : Int → Int → Int
opaque and_impl : Int → Int → Int

def evalU : UOp → Int → Int
  | .neg, x => -x
  | .trunc, x => x
  | .recip, x => recip_impl x
  | .sqrt, x => sqrt_impl x
  | .sin, x => sin_impl x
  | .exp2, x => exp2_impl x
  | .log2, x => log2_impl x

def evalB : BOp → Int → Int → Int
  | .add, x, y => x + y
  | .mul, x, y => x * y
  | .sub, x, y => x - y
  | .max, x, y => if x ≥ y then x else y
  | .cdiv, x, y => if y = 0 then 0 else x / y
  | .cmod, x, y => if y = 0 then 0 else x % y
  | .cmplt, x, y => if x < y then 1 else 0
  | .cmpne, x, y => if x = y then 0 else 1
  | .cmpeq, x, y => if x = y then 1 else 0
  | .floordiv, x, y => if y = 0 then 0 else x / y
  | .floormod, x, y => if y = 0 then 0 else x % y
  | .fdiv, x, y => fdiv_impl x y
  | .pow_, x, y => pow_impl x y
  | .shl, x, y => shl_impl x y
  | .shr, x, y => shr_impl x y
  | .xor_, x, y => xor_impl x y
  | .or_, x, y => or_impl x y
  | .and_, x, y => and_impl x y

def evalT : TOp → Int → Int → Int → Int
  | .where_, c, x, y => if c ≠ 0 then x else y
  | .mulacc, a, b, c => a * b + c

def evalR : ROp → Array Int → Int
  | .sum, arr => arr.foldl (· + ·) 0
  | .prod, arr => arr.foldl (· * ·) 1
  | .max, arr => if h : arr.size > 0
    then arr.foldl (fun a b => if b > a then b else a) (arr[0]'h)
    else 0

-- ── Algebraic properties ─────────────────────────────────────────────────────

theorem neg_involutive (x : Int) : evalU .neg (evalU .neg x) = x := by simp [evalU]
theorem add_comm (x y : Int) : evalB .add x y = evalB .add y x := by simp [evalB]; omega
theorem add_assoc (x y z : Int) :
    evalB .add (evalB .add x y) z = evalB .add x (evalB .add y z) := by simp [evalB]; omega
theorem add_zero (x : Int) : evalB .add x 0 = x := by simp [evalB]
theorem sub_eq_add_neg (x y : Int) :
    evalB .sub x y = evalB .add x (evalU .neg y) := by simp [evalB, evalU]; omega
theorem max_comm (x y : Int) : evalB .max x y = evalB .max y x := by
  simp only [evalB]; split <;> split <;> omega
theorem max_self (x : Int) : evalB .max x x = x := by simp [evalB]
theorem cmplt_true {x y : Int} (h : x < y) : evalB .cmplt x y = 1 := by simp [evalB, h]
theorem cmplt_false {x y : Int} (h : ¬x < y) : evalB .cmplt x y = 0 := by simp [evalB, h]
theorem cmpeq_refl (x : Int) : evalB .cmpeq x x = 1 := by simp [evalB]
theorem cmpne_refl (x : Int) : evalB .cmpne x x = 0 := by simp [evalB]
theorem where_true {c : Int} (hc : c ≠ 0) (x y : Int) :
    evalT .where_ c x y = x := by simp [evalT, hc]
theorem where_zero (x y : Int) : evalT .where_ 0 x y = y := by simp [evalT]
theorem mulacc_spec (a b c : Int) :
    evalT .mulacc a b c = evalB .add (evalB .mul a b) c := by simp [evalT, evalB]

-- ── Shape lemmas for Squeeze/Unsqueeze ───────────────────────────────────────

theorem volume_filter_ne_one (s : Shape) :
    Shape.volume (s.filter (fun d => !BEq.beq d 1)) = Shape.volume s := by
  induction s with
  | nil => rfl
  | cons d ds ih =>
    simp only [List.filter, Shape.volume_cons]
    by_cases h : d = 1
    · simp [h, ih]
    · simp [show BEq.beq d 1 = false from by simp [beq_iff_eq, h]]
      simp [Shape.volume_cons, ih]

theorem volume_take_one_drop (s : Shape) (axis : Nat) :
    Shape.volume (s.take axis ++ [1] ++ s.drop axis) = Shape.volume s := by
  induction s generalizing axis with
  | nil => simp [Shape.volume]
  | cons d ds ih =>
    cases axis with
    | zero => simp [Shape.volume]
    | succ n => simp only [List.take, List.drop, Shape.volume_cons]; exact congrArg (d * .) (ih n)

-- ── Tensor lifts ─────────────────────────────────────────────────────────────

def tensorU (op : UOp) (t : Tensor Int) : Tensor Int := t.map (evalU op)
def tensorB (op : BOp) (a b : Tensor Int) (h : a.shape = b.shape) : Tensor Int :=
  a.zipWith (evalB op) b h

theorem tensorU_shape (op : UOp) (t : Tensor Int) : (tensorU op t).shape = t.shape := rfl
theorem tensorB_shape (op : BOp) (a b : Tensor Int) (h : a.shape = b.shape) :
    (tensorB op a b h).shape = a.shape := rfl

theorem microOpTotal : 7 + 18 + 2 + 3 + 6 = 36 := by omega

end OnnxLeanVerify
