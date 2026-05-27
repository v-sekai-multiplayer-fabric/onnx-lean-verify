-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxReshape (t : Tensor Int) (s : Shape) (h : s.volume = t.shape.volume) : Tensor Int :=
  { shape := s, data := t.data, h_valid := by rw [t.h_valid, h] }
def decompReshape := onnxReshape
theorem reshape_preserves (t : Tensor Int) (s : Shape) (h : s.volume = t.shape.volume) :
    (onnxReshape t s h).data = t.data := rfl

def metaReshape : OpMeta := { name := "Reshape", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
