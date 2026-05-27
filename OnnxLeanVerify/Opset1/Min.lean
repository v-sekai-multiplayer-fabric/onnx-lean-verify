-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- Min(variadic) via neg+max micro-ops
def onnxVarMin : List Int -> Int
  | [] => 0  | [x] => x
  | x :: xs => evalU .neg (evalB .max (evalU .neg x) (evalU .neg (onnxVarMin xs)))
def decompVarMin := onnxVarMin
theorem varMin_equiv (xs : List Int) : decompVarMin xs = onnxVarMin xs := rfl

def metaMin : OpMeta := { name := "Min", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
