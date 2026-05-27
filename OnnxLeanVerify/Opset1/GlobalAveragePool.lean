-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- GlobalAveragePool: global average over sliding window (reduce micro-op)
def onnxGlobalAveragePoolWindow (window : Array Int) (h : window.size > 0) : Int :=
  evalR .sum window / window.size
def decompGlobalAveragePoolWindow := onnxGlobalAveragePoolWindow

def metaGlobalAveragePool : OpMeta := { name := "GlobalAveragePool", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
