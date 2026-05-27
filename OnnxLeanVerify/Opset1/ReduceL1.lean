-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxReduceL1 (arr : Array Int) : Int :=
  arr.foldl (fun acc x => acc + if x < 0 then -x else x) 0
def decompReduceL1 (arr : Array Int) : Int :=
  evalR .sum (arr.map (fun x => evalT .where_ (evalB .cmplt x 0) (evalU .neg x) x))
theorem reduceL1_equiv (arr : Array Int) :
    decompReduceL1 arr = onnxReduceL1 arr := sorry

def metaReduceL1 : OpMeta := { name := "ReduceL1", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
