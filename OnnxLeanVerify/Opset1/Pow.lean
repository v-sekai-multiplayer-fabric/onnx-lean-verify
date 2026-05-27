-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxPow (x y : Int) : Int := evalB .pow_ x y
def decompPow (x y : Int) : Int := evalB .pow_ x y
theorem pow_equiv (x y : Int) : decompPow x y = onnxPow x y := rfl

def metaPow : OpMeta := { name := "Pow", opsetSince := 1, support := .conditional "transcendental", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
