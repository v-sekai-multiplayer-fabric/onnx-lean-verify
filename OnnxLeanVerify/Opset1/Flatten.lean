-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxFlatten (t : Tensor Int) : Tensor Int :=
  { shape := [t.shape.volume], data := t.data, h_valid := by simp [Shape.volume, t.h_valid] }
def decompFlatten (t : Tensor Int) : Tensor Int := onnxFlatten t
theorem flatten_equiv (t : Tensor Int) : decompFlatten t = onnxFlatten t := rfl

def metaFlatten : OpMeta := { name := "Flatten", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
