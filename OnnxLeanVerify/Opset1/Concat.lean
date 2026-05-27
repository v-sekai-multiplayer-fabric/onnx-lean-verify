-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- Concatenation along axis: append data arrays
def onnxConcatFlat (arrays : List (Array Int)) : Array Int :=
  arrays.foldl (fun acc a => acc ++ a) #[]
def decompConcatFlat := onnxConcatFlat

def metaConcat : OpMeta := { name := "Concat", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
