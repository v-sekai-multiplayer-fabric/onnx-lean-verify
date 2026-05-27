-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX LRN: micro-op decomposition (implementation pending)
def decompLRN : Unit := sorry
def metaLRN : OpMeta := { name := "LRN", opsetSince := 1, support := .conditional "float boundary", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
