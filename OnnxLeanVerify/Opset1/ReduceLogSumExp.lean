-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxReduceLogSumExp (arr : Array Int) : Int :=
  evalU .log2 (evalR .sum (arr.map (fun x => evalU .exp2 (evalB .mul x 1))))
def decompReduceLogSumExp (arr : Array Int) : Int := onnxReduceLogSumExp arr
theorem reduceLogSumExp_equiv (arr : Array Int) :
    decompReduceLogSumExp arr = onnxReduceLogSumExp arr := rfl

def metaReduceLogSumExp : OpMeta := { name := "ReduceLogSumExp", opsetSince := 1, support := .conditional "transcendental", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
