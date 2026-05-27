-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- On Int, ceil is identity
def onnxCeil (x : Int) : Int := x
def decompCeil (x : Int) : Int := evalU .trunc x
theorem ceil_equiv (x : Int) : decompCeil x = onnxCeil x := by simp [decompCeil, onnxCeil, evalU]

def metaCeil : OpMeta := { name := "Ceil", opsetSince := 1, support := .conditional "float rounding", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
