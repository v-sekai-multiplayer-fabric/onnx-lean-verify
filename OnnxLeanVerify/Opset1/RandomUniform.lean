-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def randomUniformDescription : String := "non-deterministic; THREEFRY counter-based RNG"

def metaRandomUniform : ExtensionalOpMeta :=
  { toOpMeta := { name := "RandomUniform", opsetSince := 1, support := .conditional "non-deterministic", semantics := .extensional, utilization := .native }, mechanism := .stochastic }

end OnnxLeanVerify.Opset1
