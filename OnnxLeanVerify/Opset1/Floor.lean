-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX Floor: micro-op decomposition (implementation pending)
def decompFloor : Unit := sorry
def metaFloor : OpMeta := { name := "Floor", opsetSince := 1, support := .conditional "float rounding", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
