-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxLess (x y : Int) : Int := if x < y then 1 else 0
def decompLess (x y : Int) : Int := evalB .cmplt x y
theorem less_equiv (x y : Int) : decompLess x y = onnxLess x y := by simp [decompLess, onnxLess, evalB]

def metaLess : OpMeta := { name := "Less", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
