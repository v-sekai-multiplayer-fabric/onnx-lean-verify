-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def loopDescription : String := "graph-level iteration, potentially non-terminating"

def metaLoop : ExtensionalOpMeta :=
  { toOpMeta := { name := "Loop", opsetSince := 1, support := .conditional "non-terminating", semantics := .extensional, utilization := .native }, mechanism := .complexDataStructure }

end OnnxLeanVerify.Opset1
