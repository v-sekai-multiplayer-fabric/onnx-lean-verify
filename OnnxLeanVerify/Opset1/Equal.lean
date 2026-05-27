-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxEqual (x y : Int) : Int := if x = y then 1 else 0
def decompEqual (x y : Int) : Int := evalB .cmpeq x y
theorem equal_equiv (x y : Int) : decompEqual x y = onnxEqual x y := by simp [decompEqual, onnxEqual, evalB]
def metaEqual : OpMeta := { name := "Equal", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
