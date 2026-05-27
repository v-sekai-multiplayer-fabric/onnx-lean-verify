-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX Reciprocal: micro-op decomposition (implementation pending)
def decompReciprocal : Unit := sorry
def metaReciprocal : OpMeta := { name := "Reciprocal", opsetSince := 1, support := .conditional "division; float boundary", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
