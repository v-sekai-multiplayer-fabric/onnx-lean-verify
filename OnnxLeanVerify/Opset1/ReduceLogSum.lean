-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX ReduceLogSum: micro-op decomposition (implementation pending)
def decompReduceLogSum : Unit := sorry
def metaReduceLogSum : OpMeta := { name := "ReduceLogSum", opsetSince := 1, support := .conditional "transcendental", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
