-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxVarMax : List Int -> Int
  | [] => 0  | [x] => x  | x :: xs => evalB .max x (onnxVarMax xs)
def decompVarMax : List Int -> Int
  | [] => 0  | [x] => x  | x :: xs => evalB .max x (decompVarMax xs)
theorem varMax_equiv (xs : List Int) : decompVarMax xs = onnxVarMax xs := by
  induction xs with | nil => rfl | cons x xs ih => cases xs <;> simp [decompVarMax, onnxVarMax, ih]

def metaMax : OpMeta := { name := "Max", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
