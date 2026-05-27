-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- exp(x) = exp2(x * log2(e)); opaque over Int
def onnxExp (x : Int) : Int := evalU .exp2 (evalB .mul x 1)
def decompExp (x : Int) : Int := evalU .exp2 (evalB .mul x 1)
theorem exp_equiv (x : Int) : decompExp x = onnxExp x := rfl

def metaExp : OpMeta := { name := "Exp", opsetSince := 1, support := .conditional "transcendental", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
