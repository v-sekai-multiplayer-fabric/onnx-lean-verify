-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxNeg (x : Int) : Int := -x
def decompNeg (x : Int) : Int := evalU .neg x
theorem neg_equiv (x : Int) : decompNeg x = onnxNeg x := by simp [decompNeg, onnxNeg, evalU]
def metaNeg : OpMeta := { name := "Neg", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
