-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX Sigmoid: micro-op decomposition (implementation pending)
def decompSigmoid : Unit := sorry
def metaSigmoid : OpMeta := { name := "Sigmoid", opsetSince := 1, support := .conditional "transcendental", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
