-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxSqrt (x : Int) : Int := evalU .sqrt x
def decompSqrt (x : Int) : Int := evalU .sqrt x
theorem sqrt_equiv (x : Int) : decompSqrt x = onnxSqrt x := rfl

def metaSqrt : OpMeta := { name := "Sqrt", opsetSince := 1, support := .conditional "float boundary", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
