-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxSqueeze (t : Tensor Int) : Tensor Int :=
  { shape := t.shape.filter (fun d => d != 1), data := t.data, h_valid := sorry }
def decompSqueeze := onnxSqueeze

def metaSqueeze : OpMeta := { name := "Squeeze", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
