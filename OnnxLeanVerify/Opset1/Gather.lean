-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- Gather: index into tensor along axis
def onnxGatherFlat (data : Array Int) (indices : Array Nat) : Array Int :=
  indices.map (fun i => data.getD i 0)
def decompGatherFlat := onnxGatherFlat

def metaGather : OpMeta := { name := "Gather", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
