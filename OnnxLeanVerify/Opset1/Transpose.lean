-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- permute micro-op: reorders axes
def onnxTransposeShape (shape : List Nat) (perm : List Nat) : List Nat :=
  perm.map (fun i => shape.getD i 0)
def decompTransposeShape := onnxTransposeShape

def metaTranspose : OpMeta := { name := "Transpose", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
