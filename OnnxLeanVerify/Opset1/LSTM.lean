-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ONNX LSTM: extensional (PCA realizability, mechanism: .statefulRecurrent)
def decompLSTM : Unit := sorry
def metaLSTM : ExtensionalOpMeta :=
  { toOpMeta := { name := "LSTM", opsetSince := 1, support := .full, semantics := .extensional, utilization := .native }, mechanism := .statefulRecurrent }

end OnnxLeanVerify.Opset1
