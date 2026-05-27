-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ReduceMin = neg(max(neg(arr)))
def onnxReduceMin (arr : Array Int) (_ : arr.size > 0) : Int :=
  evalU .neg (evalR .max (arr.map (evalU .neg)))
def decompReduceMin := onnxReduceMin
theorem reduceMin_equiv (arr : Array Int) (h : arr.size > 0) :
    decompReduceMin arr h = onnxReduceMin arr h := rfl

def metaReduceMin : OpMeta := { name := "ReduceMin", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
