-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxNot (x : Int) : Int := if x = 0 then 1 else 0
def decompNot (x : Int) : Int := evalB .cmpeq x 0
theorem not_equiv (x : Int) : decompNot x = onnxNot x := by simp [decompNot, onnxNot, evalB]

def metaNot : OpMeta := { name := "Not", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
