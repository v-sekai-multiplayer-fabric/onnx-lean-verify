-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- hardmax: 1 at argmax position, 0 elsewhere
def onnxHardmax (x maxVal : Int) : Int := evalB .cmpeq x maxVal
def decompHardmax := onnxHardmax

def metaHardmax : OpMeta := { name := "Hardmax", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
