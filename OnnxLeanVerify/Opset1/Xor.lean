-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxXor (x y : Int) : Int :=
  let bx := if x = 0 then 0 else 1
  let by_ := if y = 0 then 0 else 1
  if bx = by_ then 0 else 1
def decompXor (x y : Int) : Int := evalB .cmpne (evalB .cmpne x 0) (evalB .cmpne y 0)
theorem xor_equiv (x y : Int) : decompXor x y = onnxXor x y := by
  simp only [decompXor, onnxXor, evalB]; by_cases hx : x = 0 <;> by_cases hy : y = 0 <;> simp_all

def metaXor : OpMeta := { name := "Xor", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
