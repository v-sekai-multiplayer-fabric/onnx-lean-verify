-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- BN(x) = (x - mean) * recip(sqrt(var + eps)) * scale + bias
def onnxBNElem (x mean var scale bias eps : Int) : Int :=
  evalB .add (evalB .mul scale (evalB .mul (evalB .sub x mean) (evalU .recip (evalU .sqrt (evalB .add var eps))))) bias
def decompBNElem := onnxBNElem

def metaBatchNormalization : OpMeta := { name := "BatchNormalization", opsetSince := 1, support := .conditional "running stats", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
