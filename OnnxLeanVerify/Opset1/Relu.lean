-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxRelu (x : Int) : Int := if x < 0 then 0 else x
def decompRelu (x : Int) : Int := evalB .max x 0
theorem relu_equiv (x : Int) : decompRelu x = onnxRelu x := by
  simp only [decompRelu, onnxRelu, evalB]
  by_cases h : x < 0 <;> simp_all <;> omega
def metaRelu : OpMeta := { name := "Relu", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
