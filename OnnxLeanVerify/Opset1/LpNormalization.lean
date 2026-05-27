-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxLpNormElem (x norm : Int) : Int := evalB .cdiv x norm
def decompLpNormElem := onnxLpNormElem

def metaLpNormalization : OpMeta := { name := "LpNormalization", opsetSince := 1, support := .conditional "Lp norm", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
