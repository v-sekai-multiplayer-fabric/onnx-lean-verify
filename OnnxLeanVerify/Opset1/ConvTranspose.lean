-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX ConvTranspose: micro-op decomposition (implementation pending)
def decompConvTranspose : Unit := sorry
def metaConvTranspose : OpMeta := { name := "ConvTranspose", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
