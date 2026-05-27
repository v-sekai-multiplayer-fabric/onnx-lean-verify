-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
--
-- Tinygrad micro-op kernel: all ONNX operators decompose into these primitives.
-- See https://github.com/tinygrad/tinygrad (uop/__init__.py)
import OnnxLeanVerify.Tensor
namespace OnnxLeanVerify

-- ── Micro-op enumerations ────────────────────────────────────────────────────

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

-- ── Scalar evaluators ────────────────────────────────────────────────────────

def evalU : UOp → Int → Int
  | .neg, x => -x
  | .trunc, x => x
  | .recip, _ => sorry
  | .sqrt, _ => sorry
  | .sin, _ => sorry
  | .exp2, _ => sorry
  | .log2, _ => sorry

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
  | .fdiv, _, _ => sorry
  | .pow_, _, _ => sorry
  | .shl, _, _ => sorry
  | .shr, _, _ => sorry
  | .xor_, _, _ => sorry
  | .or_, _, _ => sorry
  | .and_, _, _ => sorry

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
theorem mul_comm_micro (x y : Int) : evalB .mul x y = evalB .mul y x := by
  simp [evalB]; exact Int.mul_comm x y
theorem mul_one_micro (x : Int) : evalB .mul x 1 = x := by simp [evalB]

theorem sub_eq_add_neg (x y : Int) :
    evalB .sub x y = evalB .add x (evalU .neg y) := by simp [evalB, evalU]; omega

theorem max_comm (x y : Int) : evalB .max x y = evalB .max y x := by
  simp only [evalB]; split <;> split <;> omega
theorem max_self (x : Int) : evalB .max x x = x := by simp [evalB]
theorem max_assoc (x y z : Int) :
    evalB .max (evalB .max x y) z = evalB .max x (evalB .max y z) := by
  simp only [evalB]; omega

theorem cmplt_true {x y : Int} (h : x < y) : evalB .cmplt x y = 1 := by simp [evalB, h]
theorem cmplt_false {x y : Int} (h : ¬x < y) : evalB .cmplt x y = 0 := by simp [evalB, h]
theorem cmpeq_refl (x : Int) : evalB .cmpeq x x = 1 := by simp [evalB]
theorem cmpne_refl (x : Int) : evalB .cmpne x x = 0 := by simp [evalB]

theorem where_true {c : Int} (hc : c ≠ 0) (x y : Int) :
    evalT .where_ c x y = x := by simp [evalT, hc]
theorem where_zero (x y : Int) : evalT .where_ 0 x y = y := by simp [evalT]

theorem mulacc_spec (a b c : Int) :
    evalT .mulacc a b c = evalB .add (evalB .mul a b) c := by simp [evalT, evalB]

-- ── Tensor lifts ─────────────────────────────────────────────────────────────

def tensorU (op : UOp) (t : Tensor Int) : Tensor Int := t.map (evalU op)
def tensorB (op : BOp) (a b : Tensor Int) (h : a.shape = b.shape) : Tensor Int :=
  a.zipWith (evalB op) b h

theorem tensorU_shape (op : UOp) (t : Tensor Int) : (tensorU op t).shape = t.shape := rfl
theorem tensorB_shape (op : BOp) (a b : Tensor Int) (h : a.shape = b.shape) :
    (tensorB op a b h).shape = a.shape := rfl

-- ── Micro-op count: 7 + 18 + 2 + 3 + 6 = 36 ────────────────────────────────

theorem microOpTotal : 7 + 18 + 2 + 3 + 6 = 36 := by omega

end OnnxLeanVerify
