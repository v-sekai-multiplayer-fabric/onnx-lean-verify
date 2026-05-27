-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX If: extensional (PCA realizability, mechanism: .complexDataStructure)
def decompIf : Unit := sorry
def metaIf : ExtensionalOpMeta :=
  { toOpMeta := { name := "If", opsetSince := 1, support := .full, semantics := .extensional, utilization := .native }, mechanism := .complexDataStructure }

end OnnxLeanVerify.Opset1
