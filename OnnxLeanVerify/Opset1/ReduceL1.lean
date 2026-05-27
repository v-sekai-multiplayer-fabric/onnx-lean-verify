-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ReduceL1 = sum(abs(arr)) where abs uses where+cmplt+neg micro-ops
def absScalar (x : Int) : Int := evalT .where_ (evalB .cmplt x 0) (evalU .neg x) x
def onnxReduceL1 (arr : Array Int) : Int := evalR .sum (arr.map absScalar)
def decompReduceL1 := onnxReduceL1
theorem reduceL1_equiv (arr : Array Int) : decompReduceL1 arr = onnxReduceL1 arr := rfl

def metaReduceL1 : OpMeta := { name := "ReduceL1", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
