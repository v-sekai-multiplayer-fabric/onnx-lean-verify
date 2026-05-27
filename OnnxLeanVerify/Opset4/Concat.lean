-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset4

-- Opset 4 Concat: axis attribute is now required (was optional)
def onnxConcatV4 (arrays : List (Array Int)) (_axis : Nat) : Array Int :=
  arrays.foldl (fun acc a => acc ++ a) #[]

def decompConcatV4 := onnxConcatV4

def metaConcat : OpMeta := { name := "Concat", opsetSince := 4, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset4
