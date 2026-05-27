-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- sigmoid(x) = recip(1 + exp(-x)) = recip(add(1, exp2(mul(neg(x), log2_e))))
def onnxSigmoid (x : Int) : Int :=
  evalU .recip (evalB .add 1 (evalU .exp2 (evalB .mul (evalU .neg x) 1)))
def decompSigmoid (x : Int) : Int :=
  evalU .recip (evalB .add 1 (evalU .exp2 (evalB .mul (evalU .neg x) 1)))
theorem sigmoid_equiv (x : Int) : decompSigmoid x = onnxSigmoid x := rfl

def metaSigmoid : OpMeta := { name := "Sigmoid", opsetSince := 1, support := .conditional "transcendental", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
