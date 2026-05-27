-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
--
-- Opset 1 reduction operators (10 of 85)
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.Opset1.Elementwise

namespace OnnxLeanVerify
namespace Opset1

def reduceSum (t : Tensor Int) : Int := t.data.foldl (· + ·) 0
def reduceProd (t : Tensor Int) : Int := t.data.foldl (· * ·) 1

def reduceMax (t : Tensor Int) (hne : 0 < t.data.size) : Int :=
  t.data.foldl (fun acc x => if x > acc then x else acc) (t.data[0]'hne)

def reduceMin (t : Tensor Int) (hne : 0 < t.data.size) : Int :=
  t.data.foldl (fun acc x => if x < acc then x else acc) (t.data[0]'hne)

def reduceMean (t : Tensor Int) (_ : 0 < t.data.size) : Int :=
  reduceSum t / t.data.size

def reduceL1 (t : Tensor Int) : Int :=
  t.data.foldl (fun acc x => acc + absVal x) 0

def reduceSumSquare (t : Tensor Int) : Int :=
  t.data.foldl (fun acc x => acc + x * x) 0

def reduceL2Squared (t : Tensor Int) : Int := reduceSumSquare t

opaque reduceL2 : Tensor Int → Int
opaque reduceLogSum : Tensor Int → Int
opaque reduceLogSumExp : Tensor Int → Int

-- ── Proofs ───────────────────────────────────────────────────────────────────

theorem reduceSum_scalar (x : Int) :
    reduceSum (Tensor.scalar x) = x := by
  simp [reduceSum, Tensor.scalar, Array.foldl]

theorem reduceProd_scalar (x : Int) :
    reduceProd (Tensor.scalar x) = x := by
  simp [reduceProd, Tensor.scalar, Array.foldl]

theorem reduceL1_nonneg (t : Tensor Int) : 0 ≤ reduceL1 t := by
  simp only [reduceL1]
  apply Array.foldl_induction (fun _ acc => 0 ≤ acc)
  · omega
  · intro i b hb
    simp only [absVal]
    split <;> omega

-- ── Metadata ─────────────────────────────────────────────────────────────────

def metaReduceL1 : OpMeta := ⟨"ReduceL1", 1, .full, .executable, .native⟩
def metaReduceL2 : OpMeta := ⟨"ReduceL2", 1, .conditional "sqrt; hardware float boundary", .executable, .native⟩
def metaReduceLogSum : OpMeta := ⟨"ReduceLogSum", 1, .conditional "transcendental", .executable, .native⟩
def metaReduceLogSumExp : OpMeta := ⟨"ReduceLogSumExp", 1, .conditional "transcendental", .executable, .native⟩
def metaReduceMax : OpMeta := ⟨"ReduceMax", 1, .full, .executable, .native⟩
def metaReduceMean : OpMeta := ⟨"ReduceMean", 1, .full, .executable, .native⟩
def metaReduceMin : OpMeta := ⟨"ReduceMin", 1, .full, .executable, .native⟩
def metaReduceProd : OpMeta := ⟨"ReduceProd", 1, .full, .executable, .native⟩
def metaReduceSum : OpMeta := ⟨"ReduceSum", 1, .full, .executable, .native⟩
def metaReduceSumSquare : OpMeta := ⟨"ReduceSumSquare", 1, .full, .executable, .native⟩

def allReduceMeta : List OpMeta := [
  metaReduceL1, metaReduceL2, metaReduceLogSum, metaReduceLogSumExp,
  metaReduceMax, metaReduceMean, metaReduceMin, metaReduceProd,
  metaReduceSum, metaReduceSumSquare]

end Opset1
end OnnxLeanVerify
