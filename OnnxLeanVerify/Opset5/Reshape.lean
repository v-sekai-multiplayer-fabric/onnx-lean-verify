-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset5

-- Opset 5 Reshape: shape becomes an input tensor instead of attribute
-- This is the key semantic change: dynamic shapes
def onnxReshapeV5 (t : Tensor Int) (shapeInput : Array Int) : Tensor Int :=
  let newShape := shapeInput.toList.map Int.toNat
  if h : Shape.volume newShape = Shape.volume t.shape then
    { shape := newShape, data := t.data, h_valid := by rw [t.h_valid, h] }
  else t

def decompReshapeV5 := onnxReshapeV5

def metaReshape : OpMeta := { name := "Reshape", opsetSince := 5, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset5
