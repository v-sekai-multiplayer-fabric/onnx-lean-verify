-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX BatchNormalization: micro-op decomposition (implementation pending)
def decompBatchNormalization : Unit := sorry
def metaBatchNormalization : OpMeta := { name := "BatchNormalization", opsetSince := 1, support := .conditional "running stats", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
