-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxVarSum : List Int -> Int
  | [] => 0  | x :: xs => evalB .add x (onnxVarSum xs)
def decompVarSum : List Int -> Int
  | [] => 0  | x :: xs => evalB .add x (decompVarSum xs)
theorem varSum_equiv (xs : List Int) : decompVarSum xs = onnxVarSum xs := by
  induction xs with | nil => rfl | cons x xs ih => simp [decompVarSum, onnxVarSum, ih]

def metaSum : OpMeta := { name := "Sum", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
