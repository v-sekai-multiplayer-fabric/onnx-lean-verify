-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- Upsample: nearest-neighbor (expand + reshape)
def onnxUpsampleFlat (data : Array Int) (scale : Nat) : Array Int :=
  Id.run do
    let mut result := #[]
    for i in [:data.size] do
      for _ in [:scale] do result := result.push (data.getD i 0)
    return result
def decompUpsampleFlat := onnxUpsampleFlat

def metaUpsample : OpMeta := { name := "Upsample", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
