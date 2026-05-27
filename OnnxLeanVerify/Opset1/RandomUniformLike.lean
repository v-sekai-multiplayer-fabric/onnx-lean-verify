-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX RandomUniformLike: extensional (PCA realizability, mechanism: .stochastic)
def decompRandomUniformLike : Unit := sorry
def metaRandomUniformLike : ExtensionalOpMeta :=
  { toOpMeta := { name := "RandomUniformLike", opsetSince := 1, support := .conditional "non-deterministic", semantics := .extensional, utilization := .native }, mechanism := .stochastic }

end OnnxLeanVerify.Opset1
