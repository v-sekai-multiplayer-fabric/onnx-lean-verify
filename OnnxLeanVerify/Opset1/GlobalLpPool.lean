-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX GlobalLpPool: micro-op decomposition (implementation pending)
def decompGlobalLpPool : Unit := sorry
def metaGlobalLpPool : OpMeta := { name := "GlobalLpPool", opsetSince := 1, support := .conditional "Lp norm", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
