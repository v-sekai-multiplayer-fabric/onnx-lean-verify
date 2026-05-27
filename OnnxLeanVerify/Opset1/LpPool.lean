-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX LpPool: micro-op decomposition (implementation pending)
def decompLpPool : Unit := sorry
def metaLpPool : OpMeta := { name := "LpPool", opsetSince := 1, support := .conditional "Lp norm", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
