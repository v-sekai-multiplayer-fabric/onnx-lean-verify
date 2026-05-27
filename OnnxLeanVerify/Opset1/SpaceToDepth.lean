-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- SpaceToDepth = reshape + permute
def onnxSpaceToDepthShape (n c h_ w bs : Nat) : List Nat :=
  [n, c * bs * bs, h_ / bs, w / bs]
def decompSpaceToDepthShape := onnxSpaceToDepthShape

def metaSpaceToDepth : OpMeta := { name := "SpaceToDepth", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
