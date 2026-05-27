-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- L2 = sqrt(sum(x^2))
def onnxReduceL2 (arr : Array Int) : Int :=
  evalU .sqrt (evalR .sum (arr.map (fun x => evalB .mul x x)))
def decompReduceL2 (arr : Array Int) : Int := onnxReduceL2 arr
theorem reduceL2_equiv (arr : Array Int) : decompReduceL2 arr = onnxReduceL2 arr := rfl

def metaReduceL2 : OpMeta := { name := "ReduceL2", opsetSince := 1, support := .conditional "sqrt", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
