-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxUnsqueeze (t : Tensor Int) (axis : Nat) : Tensor Int :=
  { shape := t.shape.take axis ++ [1] ++ t.shape.drop axis, data := t.data, h_valid := sorry }
def decompUnsqueeze := onnxUnsqueeze

def metaUnsqueeze : OpMeta := { name := "Unsqueeze", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
