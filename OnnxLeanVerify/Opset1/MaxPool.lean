-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- MaxPool: max over sliding window (reduce micro-op)
def onnxMaxPoolWindow (window : Array Int) (h : window.size > 0) : Int :=
  evalR .max window
def decompMaxPoolWindow := onnxMaxPoolWindow

def metaMaxPool : OpMeta := { name := "MaxPool", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
