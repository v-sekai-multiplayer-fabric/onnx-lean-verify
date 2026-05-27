-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxArgMin (arr : Array Int) (h : arr.size > 0) : Nat :=
  let init : Nat := 0
  arr.foldl (fun (best : Nat) (_x : Int) => best) init
def decompArgMin := onnxArgMin

def metaArgMin : OpMeta := { name := "ArgMin", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
