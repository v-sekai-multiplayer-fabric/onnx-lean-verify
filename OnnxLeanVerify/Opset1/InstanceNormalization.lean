-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxINElem (x mean var scale bias eps : Int) : Int :=
  evalB .add (evalB .mul scale (evalB .mul (evalB .sub x mean) (evalU .recip (evalU .sqrt (evalB .add var eps))))) bias
def decompINElem := onnxINElem

def metaInstanceNormalization : OpMeta := { name := "InstanceNormalization", opsetSince := 1, support := .conditional "float boundary", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
