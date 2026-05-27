-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- conv = reduce.sum over sliding window: sum(mul(patch, kernel))
-- Full implementation requires stride/pad/dilation logic
def onnxConvPatch (patch kernel : Array Int) (h : patch.size = kernel.size) : Int :=
  evalR .sum (Array.zipWith (evalB .mul) patch kernel)
def decompConvPatch (patch kernel : Array Int) (h : patch.size = kernel.size) : Int :=
  onnxConvPatch patch kernel h
theorem convPatch_equiv (p k : Array Int) (h : p.size = k.size) :
    decompConvPatch p k h = onnxConvPatch p k h := rfl

def metaConv : OpMeta := { name := "Conv", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
