-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- On Int, cast to same type is identity
def onnxCast (x : Int) : Int := x
def decompCast (x : Int) : Int := x
theorem cast_equiv (x : Int) : decompCast x = onnxCast x := rfl

def metaCast : OpMeta := { name := "Cast", opsetSince := 1, support := .conditional "type-dependent", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
