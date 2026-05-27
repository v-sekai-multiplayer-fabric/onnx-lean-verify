-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- logsoftmax(x) = x - max(x) - log(sum(exp(x - max(x))))
def onnxLogSoftmaxScalar (x maxVal logSumExp : Int) : Int :=
  evalB .sub (evalB .sub x maxVal) logSumExp
def decompLogSoftmaxScalar (x maxVal logSumExp : Int) : Int := onnxLogSoftmaxScalar x maxVal logSumExp
theorem logSoftmax_equiv (x m l : Int) : decompLogSoftmaxScalar x m l = onnxLogSoftmaxScalar x m l := rfl

def metaLogSoftmax : OpMeta := { name := "LogSoftmax", opsetSince := 1, support := .conditional "transcendental", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
