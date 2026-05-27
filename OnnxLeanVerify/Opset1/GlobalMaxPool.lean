-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- GlobalMaxPool: global max over sliding window (reduce micro-op)
def onnxGlobalMaxPoolWindow (window : Array Int) (h : window.size > 0) : Int :=
  evalR .max window
def decompGlobalMaxPoolWindow := onnxGlobalMaxPoolWindow

def metaGlobalMaxPool : OpMeta := { name := "GlobalMaxPool", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
