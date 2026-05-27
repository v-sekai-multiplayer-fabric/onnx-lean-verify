-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX Dropout: extensional (PCA realizability, mechanism: .stochastic)
def decompDropout : Unit := sorry
def metaDropout : ExtensionalOpMeta :=
  { toOpMeta := { name := "Dropout", opsetSince := 1, support := .conditional "stochastic", semantics := .extensional, utilization := .native }, mechanism := .stochastic }

end OnnxLeanVerify.Opset1
