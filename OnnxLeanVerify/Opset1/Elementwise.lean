-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
--
-- Opset 1 element-wise operators (26 of 85)
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics

namespace OnnxLeanVerify
namespace Opset1

-- ── Scalar kernels ───────────────────────────────────────────────────────────

def absVal (x : Int) : Int := if x < 0 then -x else x
def negVal (x : Int) : Int := -x
def reluVal (x : Int) : Int := if x < 0 then 0 else x
def leakyReluVal (alpha : Int) (x : Int) : Int := if x < 0 then alpha * x else x
def identityVal (x : α) : α := x
def clipVal (lo hi : Int) (x : Int) : Int := max lo (min hi x)

opaque expVal : Int → Int
opaque logVal : Int → Int
opaque sinVal : Int → Int
opaque sqrtVal : Int → Int
opaque sigmoidVal : Int → Int
opaque tanhVal : Int → Int
opaque ceilVal : Int → Int
opaque floorVal : Int → Int
opaque reciprocalVal : Int → Int

-- ── Scalar proofs ────────────────────────────────────────────────────────────

theorem abs_nonneg (x : Int) : 0 ≤ absVal x := by
  unfold absVal
  split
  · omega
  · omega

theorem neg_neg (x : Int) : negVal (negVal x) = x := by simp [negVal]

theorem relu_nonneg (x : Int) : 0 ≤ reluVal x := by
  unfold reluVal
  split
  · omega
  · omega

theorem relu_le_abs (x : Int) : reluVal x ≤ absVal x := by
  unfold reluVal absVal
  split <;> omega

theorem identity_involutive (x : α) : identityVal (identityVal x) = x := rfl

theorem add_comm_int (x y : Int) : x + y = y + x := by omega
theorem add_assoc_int (x y z : Int) : x + y + z = x + (y + z) := by omega
theorem sub_self_int (x : Int) : x - x = 0 := by omega
theorem add_zero_int (x : Int) : x + 0 = x := by omega

-- ── Tensor lifts ─────────────────────────────────────────────────────────────

def absOp (t : Tensor Int) : Tensor Int := t.map absVal
def negOp (t : Tensor Int) : Tensor Int := t.map negVal
def reluOp (t : Tensor Int) : Tensor Int := t.map reluVal
def leakyReluOp (alpha : Int) (t : Tensor Int) : Tensor Int := t.map (leakyReluVal alpha)
def identityOp (t : Tensor α) : Tensor α := t.map identityVal
def clipOp (lo hi : Int) (t : Tensor Int) : Tensor Int := t.map (clipVal lo hi)
def expOp (t : Tensor Int) : Tensor Int := t.map expVal
def logOp (t : Tensor Int) : Tensor Int := t.map logVal
def sinOp (t : Tensor Int) : Tensor Int := t.map sinVal
def sqrtOp (t : Tensor Int) : Tensor Int := t.map sqrtVal
def sigmoidOp (t : Tensor Int) : Tensor Int := t.map sigmoidVal
def tanhOp (t : Tensor Int) : Tensor Int := t.map tanhVal
def ceilOp (t : Tensor Int) : Tensor Int := t.map ceilVal
def floorOp (t : Tensor Int) : Tensor Int := t.map floorVal
def reciprocalOp (t : Tensor Int) : Tensor Int := t.map reciprocalVal

def addOp (a b : Tensor Int) (h : a.shape = b.shape) : Tensor Int :=
  a.zipWith (· + ·) b h
def subOp (a b : Tensor Int) (h : a.shape = b.shape) : Tensor Int :=
  a.zipWith (· - ·) b h
def mulOp (a b : Tensor Int) (h : a.shape = b.shape) : Tensor Int :=
  a.zipWith (· * ·) b h
def powOp (a b : Tensor Int) (h : a.shape = b.shape) : Tensor Int :=
  a.zipWith (· ^ ·.toNat) b h
def preluOp (a slope : Tensor Int) (h : a.shape = slope.shape) : Tensor Int :=
  a.zipWith (fun x s => if x < 0 then s * x else x) slope h

def andOp (a b : Tensor Bool) (h : a.shape = b.shape) : Tensor Bool :=
  a.zipWith (· && ·) b h
def orOp (a b : Tensor Bool) (h : a.shape = b.shape) : Tensor Bool :=
  a.zipWith (· || ·) b h
def xorOp (a b : Tensor Bool) (h : a.shape = b.shape) : Tensor Bool :=
  a.zipWith (· ^^ ·) b h
def notOp (t : Tensor Bool) : Tensor Bool := t.map (!·)

def equalOp (a b : Tensor Int) (h : a.shape = b.shape) : Tensor Bool :=
  a.zipWith (· == ·) b h
def greaterOp (a b : Tensor Int) (h : a.shape = b.shape) : Tensor Bool :=
  a.zipWith (· > ·) b h
def lessOp (a b : Tensor Int) (h : a.shape = b.shape) : Tensor Bool :=
  a.zipWith (· < ·) b h

-- ── Shape preservation ───────────────────────────────────────────────────────

theorem absOp_shape (t : Tensor Int) : (absOp t).shape = t.shape := rfl
theorem negOp_shape (t : Tensor Int) : (negOp t).shape = t.shape := rfl
theorem reluOp_shape (t : Tensor Int) : (reluOp t).shape = t.shape := rfl
theorem addOp_shape (a b : Tensor Int) (h : a.shape = b.shape) :
    (addOp a b h).shape = a.shape := rfl

-- ── Metadata ─────────────────────────────────────────────────────────────────

def metaAbs : OpMeta := ⟨"Abs", 1, .full, .executable, .native⟩
def metaAdd : OpMeta := ⟨"Add", 1, .full, .executable, .native⟩
def metaAnd : OpMeta := ⟨"And", 1, .full, .executable, .native⟩
def metaCeil : OpMeta := ⟨"Ceil", 1, .conditional "float rounding", .executable, .native⟩
def metaEqual : OpMeta := ⟨"Equal", 1, .full, .executable, .native⟩
def metaExp : OpMeta := ⟨"Exp", 1, .conditional "transcendental; hardware float boundary", .executable, .native⟩
def metaFloor : OpMeta := ⟨"Floor", 1, .conditional "float rounding", .executable, .native⟩
def metaGreater : OpMeta := ⟨"Greater", 1, .full, .executable, .native⟩
def metaIdentity : OpMeta := ⟨"Identity", 1, .full, .executable, .native⟩
def metaLeakyRelu : OpMeta := ⟨"LeakyRelu", 1, .full, .executable, .native⟩
def metaLess : OpMeta := ⟨"Less", 1, .full, .executable, .native⟩
def metaLog : OpMeta := ⟨"Log", 1, .conditional "transcendental; hardware float boundary", .executable, .native⟩
def metaMul : OpMeta := ⟨"Mul", 1, .full, .executable, .native⟩
def metaNeg : OpMeta := ⟨"Neg", 1, .full, .executable, .native⟩
def metaNot : OpMeta := ⟨"Not", 1, .full, .executable, .native⟩
def metaOr : OpMeta := ⟨"Or", 1, .full, .executable, .native⟩
def metaPow : OpMeta := ⟨"Pow", 1, .full, .executable, .native⟩
def metaPRelu : OpMeta := ⟨"PRelu", 1, .full, .executable, .native⟩
def metaReciprocal : OpMeta := ⟨"Reciprocal", 1, .conditional "division by zero; float boundary", .executable, .native⟩
def metaRelu : OpMeta := ⟨"Relu", 1, .full, .executable, .native⟩
def metaSigmoid : OpMeta := ⟨"Sigmoid", 1, .conditional "transcendental; hardware float boundary", .executable, .native⟩
def metaSin : OpMeta := ⟨"Sin", 1, .conditional "transcendental; hardware float boundary", .executable, .native⟩
def metaSqrt : OpMeta := ⟨"Sqrt", 1, .conditional "hardware float boundary", .executable, .native⟩
def metaSub : OpMeta := ⟨"Sub", 1, .full, .executable, .native⟩
def metaTanh : OpMeta := ⟨"Tanh", 1, .conditional "transcendental; hardware float boundary", .executable, .native⟩
def metaXor : OpMeta := ⟨"Xor", 1, .full, .executable, .native⟩

def allElementwiseMeta : List OpMeta := [
  metaAbs, metaAdd, metaAnd, metaCeil, metaEqual, metaExp, metaFloor,
  metaGreater, metaIdentity, metaLeakyRelu, metaLess, metaLog, metaMul,
  metaNeg, metaNot, metaOr, metaPow, metaPRelu, metaReciprocal, metaRelu,
  metaSigmoid, metaSin, metaSqrt, metaSub, metaTanh, metaXor]

end Opset1
end OnnxLeanVerify
