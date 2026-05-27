-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- Split: divide array into chunks
def onnxSplitFlat (data : Array Int) (chunkSize : Nat) : List (Array Int) :=
  if chunkSize = 0 then [data]
  else Id.run do
    let mut result : List (Array Int) := []
    let mut i := 0
    while i < data.size do
      result := result ++ [data.toList.drop i |>.take chunkSize |>.toArray]
      i := i + chunkSize
    return result
def decompSplitFlat := onnxSplitFlat

def metaSplit : OpMeta := { name := "Split", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
