-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxAdd (x y : Int) : Int := x + y
def decompAdd (x y : Int) : Int := evalB .add x y
theorem add_equiv (x y : Int) : decompAdd x y = onnxAdd x y := by simp [decompAdd, onnxAdd, evalB]
def metaAdd : OpMeta := { name := "Add", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
