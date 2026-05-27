-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxReduceMin (arr : Array Int) (h : arr.size > 0) : Int :=
  arr.foldl (fun a b => if b < a then b else a) (arr[0]'h)
def decompReduceMin (arr : Array Int) (_ : arr.size > 0) : Int :=
  evalU .neg (evalR .max (arr.map (evalU .neg)))
theorem reduceMin_equiv (arr : Array Int) (h : arr.size > 0) :
    decompReduceMin arr h = onnxReduceMin arr h := sorry

def metaReduceMin : OpMeta := { name := "ReduceMin", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
