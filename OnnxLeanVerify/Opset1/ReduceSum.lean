-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxReduceSum (arr : Array Int) : Int := arr.foldl (fun a b => a + b) 0
def decompReduceSum (arr : Array Int) : Int := evalR .sum arr
theorem reduceSum_equiv (a : Array Int) : decompReduceSum a = onnxReduceSum a := by
  simp [decompReduceSum, onnxReduceSum, evalR]
def metaReduceSum : OpMeta := { name := "ReduceSum", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
