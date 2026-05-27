-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX Log: micro-op decomposition (implementation pending)
def decompLog : Unit := sorry
def metaLog : OpMeta := { name := "Log", opsetSince := 1, support := .conditional "transcendental", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
