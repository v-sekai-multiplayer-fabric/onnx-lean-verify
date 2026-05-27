-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxMul (x y : Int) : Int := x * y
def decompMul (x y : Int) : Int := evalB .mul x y
theorem mul_equiv (x y : Int) : decompMul x y = onnxMul x y := by simp [decompMul, onnxMul, evalB]
def metaMul : OpMeta := { name := "Mul", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
