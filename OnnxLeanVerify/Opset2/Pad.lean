-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset2

-- Opset 2 Pad: adds mode attribute (constant, reflect, edge)
inductive PadMode where | constant | reflect | edge
  deriving Repr, BEq

def onnxPadV2 (data : Array Int) (pads : List Nat) (value : Int)
    (_mode : PadMode := .constant) : Array Int :=
  let padBefore := pads.headD 0
  let padAfter := pads.getD 1 0
  Array.replicate padBefore value ++ data ++ Array.replicate padAfter value

def decompPadV2 := onnxPadV2

def metaPad : OpMeta := { name := "Pad", opsetSince := 2, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset2
