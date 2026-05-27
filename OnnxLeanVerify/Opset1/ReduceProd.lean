-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxReduceProd (arr : Array Int) : Int := arr.foldl (fun a b => a * b) 1
def decompReduceProd (arr : Array Int) : Int := evalR .prod arr
theorem reduceProd_equiv (a : Array Int) : decompReduceProd a = onnxReduceProd a := by
  simp [decompReduceProd, onnxReduceProd, evalR]

def metaReduceProd : OpMeta := { name := "ReduceProd", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
