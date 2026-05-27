-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxReduceMean (arr : Array Int) (h : arr.size > 0) : Int :=
  arr.foldl (fun a b => a + b) 0 / arr.size
def decompReduceMean (arr : Array Int) (h : arr.size > 0) : Int :=
  evalB .cdiv (evalR .sum arr) arr.size
theorem reduceMean_equiv (arr : Array Int) (h : arr.size > 0) :
    decompReduceMean arr h = onnxReduceMean arr h := by
  simp only [decompReduceMean, onnxReduceMean, evalB, evalR]
  split <;> simp_all <;> omega

def metaReduceMean : OpMeta := { name := "ReduceMean", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
