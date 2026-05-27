-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX InstanceNormalization: micro-op decomposition (implementation pending)
def decompInstanceNormalization : Unit := sorry
def metaInstanceNormalization : OpMeta := { name := "InstanceNormalization", opsetSince := 1, support := .conditional "float boundary", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
