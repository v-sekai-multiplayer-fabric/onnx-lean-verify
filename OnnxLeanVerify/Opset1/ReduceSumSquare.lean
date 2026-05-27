-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX ReduceSumSquare: micro-op decomposition (implementation pending)
def decompReduceSumSquare : Unit := sorry
def metaReduceSumSquare : OpMeta := { name := "ReduceSumSquare", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
