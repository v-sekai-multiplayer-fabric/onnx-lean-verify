-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxIdentity (x : Int) : Int := x
def decompIdentity (x : Int) : Int := x
theorem identity_equiv (x : Int) : decompIdentity x = onnxIdentity x := rfl

def metaIdentity : OpMeta := { name := "Identity", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
