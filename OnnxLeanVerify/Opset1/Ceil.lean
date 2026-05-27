-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX Ceil: micro-op decomposition (implementation pending)
def decompCeil : Unit := sorry
def metaCeil : OpMeta := { name := "Ceil", opsetSince := 1, support := .conditional "float rounding", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
