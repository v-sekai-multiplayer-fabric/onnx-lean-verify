-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxSub (x y : Int) : Int := x - y
def decompSub (x y : Int) : Int := evalB .sub x y
theorem sub_equiv (x y : Int) : decompSub x y = onnxSub x y := by simp [decompSub, onnxSub, evalB]

def metaSub : OpMeta := { name := "Sub", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
