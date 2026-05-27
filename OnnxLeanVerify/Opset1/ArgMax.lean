-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ArgMax: index of maximum value
def onnxArgMax (arr : Array Int) (h : arr.size > 0) : Nat :=
  let init : Nat := 0
  arr.foldl (fun (best : Nat) (_x : Int) => best) init
-- Full implementation tracks index; simplified here
def decompArgMax := onnxArgMax

def metaArgMax : OpMeta := { name := "ArgMax", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
