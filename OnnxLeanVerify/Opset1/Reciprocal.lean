-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxReciprocal (x : Int) : Int := evalU .recip x
def decompReciprocal (x : Int) : Int := evalU .recip x
theorem reciprocal_equiv (x : Int) : decompReciprocal x = onnxReciprocal x := rfl

def metaReciprocal : OpMeta := { name := "Reciprocal", opsetSince := 1, support := .conditional "division; float boundary", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
