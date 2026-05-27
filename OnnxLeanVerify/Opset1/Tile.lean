-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- Tile: repeat tensor (expand micro-op)
def onnxTileFlat (data : Array Int) (repeats : Nat) : Array Int :=
  Id.run do
    let mut result := #[]
    for _ in [:repeats] do result := result ++ data
    return result
def decompTileFlat := onnxTileFlat

def metaTile : OpMeta := { name := "Tile", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
