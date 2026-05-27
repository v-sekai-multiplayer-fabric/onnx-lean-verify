-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- Squeeze: remove size-1 dimensions (volume preserved by volume_filter_ne_one)
def onnxSqueeze (t : Tensor Int) : Tensor Int :=
  { shape := t.shape.filter (fun d => d != 1),
    data := t.data,
    h_valid := by rw [t.h_valid]; exact (volume_filter_ne_one t.shape).symm }
def decompSqueeze := onnxSqueeze

def metaSqueeze : OpMeta := { name := "Squeeze", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
