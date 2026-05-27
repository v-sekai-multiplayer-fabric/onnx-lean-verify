-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- Slice: extract sub-array (shrink micro-op)
def onnxSliceFlat (data : Array Int) (start stop : Nat) : Array Int :=
  data.toList.drop start |>.take (stop - start) |>.toArray
def decompSliceFlat := onnxSliceFlat

def metaSlice : OpMeta := { name := "Slice", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
