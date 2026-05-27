-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- tanh(x) = 2*sigmoid(2x) - 1
def onnxTanh (x : Int) : Int :=
  let sig2x := evalU .recip (evalB .add 1 (evalU .exp2 (evalB .mul (evalU .neg (evalB .mul 2 x)) 1)))
  evalB .sub (evalB .mul 2 sig2x) 1
def decompTanh (x : Int) : Int := onnxTanh x
theorem tanh_equiv (x : Int) : decompTanh x = onnxTanh x := rfl

def metaTanh : OpMeta := { name := "Tanh", opsetSince := 1, support := .conditional "transcendental", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
