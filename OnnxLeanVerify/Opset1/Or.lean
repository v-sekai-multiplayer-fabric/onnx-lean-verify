-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxOr (x y : Int) : Int := if x != 0 || y != 0 then 1 else 0
def decompOr (x y : Int) : Int := evalB .max (evalB .cmpne x 0) (evalB .cmpne y 0)
theorem or_equiv (x y : Int) : decompOr x y = onnxOr x y := by
  simp only [decompOr, onnxOr, evalB]; by_cases hx : x = 0 <;> by_cases hy : y = 0 <;> simp_all

def metaOr : OpMeta := { name := "Or", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
