-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxReduceMax (arr : Array Int) (h : arr.size > 0) : Int :=
  arr.foldl (fun a b => if b > a then b else a) (arr[0]'h)
def decompReduceMax (arr : Array Int) (h : arr.size > 0) : Int := evalR .max arr
theorem reduceMax_equiv (arr : Array Int) (h : arr.size > 0) :
    decompReduceMax arr h = onnxReduceMax arr h := by
  simp [decompReduceMax, onnxReduceMax, evalR, h]

def metaReduceMax : OpMeta := { name := "ReduceMax", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
