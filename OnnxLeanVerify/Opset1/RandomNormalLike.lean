-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX RandomNormalLike: extensional (PCA realizability, mechanism: .stochastic)
def decompRandomNormalLike : Unit := sorry
def metaRandomNormalLike : ExtensionalOpMeta :=
  { toOpMeta := { name := "RandomNormalLike", opsetSince := 1, support := .conditional "non-deterministic", semantics := .extensional, utilization := .native }, mechanism := .stochastic }

end OnnxLeanVerify.Opset1
