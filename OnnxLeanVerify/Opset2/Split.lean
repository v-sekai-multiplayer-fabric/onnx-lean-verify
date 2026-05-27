-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset2

-- Opset 2 Split: adds split attribute to specify output sizes
def onnxSplitV2 (data : Array Int) (axis : Nat := 0) (split : List Nat := []) : List (Array Int) :=
  if split.isEmpty then [data]
  else Id.run do
    let mut result : List (Array Int) := []
    let mut offset := 0
    for s in split do
      result := result ++ [data.toList.drop offset |>.take s |>.toArray]
      offset := offset + s
    return result

def decompSplitV2 := onnxSplitV2

def metaSplit : OpMeta := { name := "Split", opsetSince := 2, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset2
