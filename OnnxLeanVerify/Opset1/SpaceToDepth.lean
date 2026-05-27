-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX SpaceToDepth: micro-op decomposition (implementation pending)
def decompSpaceToDepth : Unit := sorry
def metaSpaceToDepth : OpMeta := { name := "SpaceToDepth", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
