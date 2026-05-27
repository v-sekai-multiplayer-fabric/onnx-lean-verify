-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxConvTransposePatch (patch kernel : Array Int) (h : patch.size = kernel.size) : Int :=
  evalR .sum (Array.zipWith (evalB .mul) patch kernel)
def decompConvTransposePatch := onnxConvTransposePatch

def metaConvTranspose : OpMeta := { name := "ConvTranspose", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
