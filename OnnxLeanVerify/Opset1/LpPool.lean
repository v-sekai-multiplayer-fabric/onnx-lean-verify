-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- LpPool: Lp over sliding window (reduce micro-op)
def onnxLpPoolWindow (window : Array Int) (h : window.size > 0) : Int :=
  evalR .sum window / window.size
def decompLpPoolWindow := onnxLpPoolWindow

def metaLpPool : OpMeta := { name := "LpPool", opsetSince := 1, support := .conditional "Lp norm", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
