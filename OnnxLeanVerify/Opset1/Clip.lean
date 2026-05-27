-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- Clip(x, lo, hi) = max(lo, -max(-x, -hi))  [min via neg/max]
def onnxClip (x lo hi : Int) : Int := max lo (min x hi)
def decompClip (x lo hi : Int) : Int :=
  evalB .max lo (evalU .neg (evalB .max (evalU .neg x) (evalU .neg hi)))
theorem clip_equiv (x lo hi : Int) : decompClip x lo hi = onnxClip x lo hi := by
  simp only [decompClip, onnxClip, evalB, evalU]; omega
def metaClip : OpMeta := { name := "Clip", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
