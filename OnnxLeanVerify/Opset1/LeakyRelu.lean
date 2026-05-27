-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxLeakyRelu (alpha x : Int) : Int := if x < 0 then alpha * x else x
def decompLeakyRelu (alpha x : Int) : Int :=
  evalT .where_ (evalB .cmplt x 0) (evalB .mul alpha x) x
theorem leakyRelu_equiv (a x : Int) : decompLeakyRelu a x = onnxLeakyRelu a x := by
  simp only [decompLeakyRelu, onnxLeakyRelu, evalT, evalB]; by_cases h : x < 0 <;> simp [h]
def metaLeakyRelu : OpMeta := { name := "LeakyRelu", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
