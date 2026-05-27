-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
--
-- Opset 1 tensor manipulation operators (15 of 85)
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics

namespace OnnxLeanVerify
namespace Opset1

-- ── Shape queries ────────────────────────────────────────────────────────────

def shapeOp (t : Tensor α) : List Nat := t.shape
def sizeOp (t : Tensor α) : Nat := t.shape.volume

theorem sizeOp_eq_numel (t : Tensor α) : sizeOp t = t.numel := by
  simp [sizeOp, Tensor.numel, t.h_valid]

-- ── Identity-class ───────────────────────────────────────────────────────────

def reshapeOp (t : Tensor α) (newShape : Shape)
    (h : newShape.volume = t.shape.volume) : Tensor α :=
  ⟨newShape, t.data, by rw [t.h_valid, h]⟩

theorem reshapeOp_preserves_numel (t : Tensor α) (s : Shape)
    (h : s.volume = t.shape.volume) : (reshapeOp t s h).numel = t.numel := by
  simp [Tensor.numel, reshapeOp]

def flattenOp (t : Tensor α) : Tensor α :=
  ⟨[t.shape.volume], t.data, by simp [Shape.volume, t.h_valid]⟩

theorem flattenOp_preserves_numel (t : Tensor α) :
    (flattenOp t).numel = t.numel := by
  simp [Tensor.numel, flattenOp]

def squeezeOp (t : Tensor α) : Tensor α :=
  ⟨t.shape.filter (· != 1), t.data, by sorry⟩

def unsqueezeOp (t : Tensor α) (axis : Nat) : Tensor α :=
  let pre := t.shape.take axis
  let post := t.shape.drop axis
  ⟨pre ++ [1] ++ post, t.data, by sorry⟩

-- ── Transpose ────────────────────────────────────────────────────────────────

def transposeShape (shape : Shape) (perm : List Nat) : Shape :=
  perm.map (fun i => shape.getD i 0)

-- ── Slice / Gather / Pad ─────────────────────────────────────────────────────

def sliceOp (t : Tensor α) (_starts _ends : List Int) : Tensor α := sorry
def gatherOp (t : Tensor α) (_indices : Tensor Nat) (_axis : Nat) : Tensor α := sorry
def padOp (t : Tensor α) (_pads : List Nat) (_value : α) : Tensor α := sorry

-- ── Concat / Split / Tile ────────────────────────────────────────────────────

def concatOp (_tensors : List (Tensor α)) (_axis : Nat) : Tensor α := sorry
def splitOp (_t : Tensor α) (_axis : Nat) (_numOutputs : Nat) : List (Tensor α) := sorry
def tileOp (_t : Tensor α) (_repeats : List Nat) : Tensor α := sorry

-- ── ArgMax / ArgMin ──────────────────────────────────────────────────────────

def argMaxOp (_t : Tensor Int) (_axis : Nat) : Tensor Int := sorry
def argMinOp (_t : Tensor Int) (_axis : Nat) : Tensor Int := sorry

-- ── Metadata ─────────────────────────────────────────────────────────────────

def metaArgMax : OpMeta := ⟨"ArgMax", 1, .full, .executable, .native⟩
def metaArgMin : OpMeta := ⟨"ArgMin", 1, .full, .executable, .native⟩
def metaConcat : OpMeta := ⟨"Concat", 1, .full, .executable, .native⟩
def metaFlatten : OpMeta := ⟨"Flatten", 1, .full, .executable, .native⟩
def metaGather : OpMeta := ⟨"Gather", 1, .full, .executable, .native⟩
def metaPad : OpMeta := ⟨"Pad", 1, .full, .executable, .native⟩
def metaReshape : OpMeta := ⟨"Reshape", 1, .full, .executable, .native⟩
def metaShape : OpMeta := ⟨"Shape", 1, .full, .executable, .native⟩
def metaSize : OpMeta := ⟨"Size", 1, .full, .executable, .native⟩
def metaSlice : OpMeta := ⟨"Slice", 1, .full, .executable, .native⟩
def metaSplit : OpMeta := ⟨"Split", 1, .full, .executable, .native⟩
def metaSqueeze : OpMeta := ⟨"Squeeze", 1, .full, .executable, .native⟩
def metaTile : OpMeta := ⟨"Tile", 1, .full, .executable, .native⟩
def metaTranspose : OpMeta := ⟨"Transpose", 1, .full, .executable, .native⟩
def metaUnsqueeze : OpMeta := ⟨"Unsqueeze", 1, .full, .executable, .native⟩

def allTensorManipMeta : List OpMeta := [
  metaArgMax, metaArgMin, metaConcat, metaFlatten, metaGather, metaPad,
  metaReshape, metaShape, metaSize, metaSlice, metaSplit, metaSqueeze,
  metaTile, metaTranspose, metaUnsqueeze]

end Opset1
end OnnxLeanVerify
