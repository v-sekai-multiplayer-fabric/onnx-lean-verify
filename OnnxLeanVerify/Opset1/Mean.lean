-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- Mean(variadic) = cdiv(sum, count)
def onnxVarMean (xs : List Int) (_ : xs.length > 0) : Int :=
  evalB .cdiv (xs.foldl (fun a b => evalB .add a b) 0) xs.length
def decompVarMean := onnxVarMean
theorem varMean_equiv (xs : List Int) (h : xs.length > 0) :
    decompVarMean xs h = onnxVarMean xs h := rfl

def metaMean : OpMeta := { name := "Mean", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
