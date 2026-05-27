-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX ReduceL2: micro-op decomposition (implementation pending)
def decompReduceL2 : Unit := sorry
def metaReduceL2 : OpMeta := { name := "ReduceL2", opsetSince := 1, support := .conditional "sqrt", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
