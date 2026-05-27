-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX Cast: micro-op decomposition (implementation pending)
def decompCast : Unit := sorry
def metaCast : OpMeta := { name := "Cast", opsetSince := 1, support := .conditional "type-dependent", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
