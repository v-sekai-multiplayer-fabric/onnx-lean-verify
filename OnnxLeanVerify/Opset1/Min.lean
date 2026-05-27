-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxVarMin : List Int -> Int
  | [] => 0  | [x] => x
  | x :: xs => let m := onnxVarMin xs; if x < m then x else m
def decompVarMin : List Int -> Int
  | [] => 0  | [x] => x
  | x :: xs => evalU .neg (evalB .max (evalU .neg x) (evalU .neg (decompVarMin xs)))
theorem varMin_equiv (xs : List Int) : decompVarMin xs = onnxVarMin xs := sorry

def metaMin : OpMeta := { name := "Min", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
