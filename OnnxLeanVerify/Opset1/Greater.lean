-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxGreater (x y : Int) : Int := if x > y then 1 else 0
def decompGreater (x y : Int) : Int := evalB .cmplt y x
theorem greater_equiv (x y : Int) : decompGreater x y = onnxGreater x y := by
  unfold decompGreater onnxGreater evalB
  by_cases h : y < x <;> by_cases h2 : x > y
  all_goals simp_all
  all_goals omega

def metaGreater : OpMeta := { name := "Greater", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
