-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxAbs (x : Int) : Int := if x < 0 then -x else x
def decompAbs (x : Int) : Int := evalT .where_ (evalB .cmplt x 0) (evalU .neg x) x
theorem abs_equiv (x : Int) : decompAbs x = onnxAbs x := by
  simp only [decompAbs, onnxAbs, evalT, evalB, evalU]; by_cases h : x < 0 <;> simp [h]

def metaAbs : OpMeta := { name := "Abs", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
