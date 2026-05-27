-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX ReduceL1: micro-op decomposition (implementation pending)
def decompReduceL1 : Unit := sorry
def metaReduceL1 : OpMeta := { name := "ReduceL1", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
