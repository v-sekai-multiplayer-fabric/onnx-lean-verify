-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxSin (x : Int) : Int := evalU .sin x
def decompSin (x : Int) : Int := evalU .sin x
theorem sin_equiv (x : Int) : decompSin x = onnxSin x := rfl

def metaSin : OpMeta := { name := "Sin", opsetSince := 1, support := .conditional "transcendental", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
