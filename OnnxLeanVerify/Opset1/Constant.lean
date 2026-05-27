-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxConstant (v : Int) : Int := v
def decompConstant (v : Int) : Int := v
theorem constant_equiv (v : Int) : decompConstant v = onnxConstant v := rfl
def metaConstant : OpMeta := { name := "Constant", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
