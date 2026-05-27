-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- Pad: extend tensor with constant value
def onnxPadFlat (data : Array Int) (padBefore padAfter : Nat) (value : Int) : Array Int :=
  Array.replicate padBefore value ++ data ++ Array.replicate padAfter value
def decompPadFlat := onnxPadFlat

def metaPad : OpMeta := { name := "Pad", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
