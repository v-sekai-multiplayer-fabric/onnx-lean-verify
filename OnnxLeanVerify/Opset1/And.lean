-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxAnd (x y : Int) : Int := if x != 0 && y != 0 then 1 else 0
def decompAnd (x y : Int) : Int := evalB .mul (evalB .cmpne x 0) (evalB .cmpne y 0)
theorem and_equiv (x y : Int) : decompAnd x y = onnxAnd x y := by
  simp only [decompAnd, onnxAnd, evalB]; by_cases hx : x = 0 <;> by_cases hy : y = 0 <;> simp_all

def metaAnd : OpMeta := { name := "And", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
