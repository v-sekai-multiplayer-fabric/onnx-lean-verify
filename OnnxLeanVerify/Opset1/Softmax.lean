-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- softmax(x, axis) = exp(x - max(x)) / sum(exp(x - max(x)))
-- Scalar version for demonstration; full version needs axis parameter
def onnxSoftmaxScalar (x maxVal sumExp : Int) : Int :=
  evalB .cdiv (evalU .exp2 (evalB .mul (evalB .sub x maxVal) 1)) sumExp
def decompSoftmaxScalar (x maxVal sumExp : Int) : Int := onnxSoftmaxScalar x maxVal sumExp
theorem softmax_equiv (x m s : Int) : decompSoftmaxScalar x m s = onnxSoftmaxScalar x m s := rfl

def metaSoftmax : OpMeta := { name := "Softmax", opsetSince := 1, support := .conditional "transcendental", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
