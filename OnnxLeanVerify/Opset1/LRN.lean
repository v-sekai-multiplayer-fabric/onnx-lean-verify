-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- LRN(x) = x / (bias + alpha/size * sum(x^2))^beta
def onnxLRNElem (x sumSq bias alpha beta size : Int) : Int :=
  evalB .cdiv x (evalB .pow_ (evalB .add bias (evalB .cdiv (evalB .mul alpha sumSq) size)) beta)
def decompLRNElem := onnxLRNElem

def metaLRN : OpMeta := { name := "LRN", opsetSince := 1, support := .conditional "float boundary", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
