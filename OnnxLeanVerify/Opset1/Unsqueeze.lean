-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- Unsqueeze: insert size-1 dimension at axis (volume preserved by volume_take_one_drop)
def onnxUnsqueeze (t : Tensor Int) (axis : Nat) : Tensor Int :=
  { shape := t.shape.take axis ++ [1] ++ t.shape.drop axis,
    data := t.data,
    h_valid := by rw [t.h_valid]; exact (volume_take_one_drop t.shape axis).symm }
def decompUnsqueeze := onnxUnsqueeze

def metaUnsqueeze : OpMeta := { name := "Unsqueeze", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
