-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxPRelu (x slope : Int) : Int := if x < 0 then slope * x else x
def decompPRelu (x slope : Int) : Int :=
  evalT .where_ (evalB .cmplt x 0) (evalB .mul slope x) x
theorem prelu_equiv (x s : Int) : decompPRelu x s = onnxPRelu x s := by
  simp only [decompPRelu, onnxPRelu, evalT, evalB]; by_cases h : x < 0 <;> simp [h]
def metaPRelu : OpMeta := { name := "PRelu", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
