-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxReduceLogSum (arr : Array Int) : Int := evalU .log2 (evalR .sum arr)
def decompReduceLogSum (arr : Array Int) : Int := onnxReduceLogSum arr
theorem reduceLogSum_equiv (arr : Array Int) : decompReduceLogSum arr = onnxReduceLogSum arr := rfl

def metaReduceLogSum : OpMeta := { name := "ReduceLogSum", opsetSince := 1, support := .conditional "transcendental", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
