-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxSize (t : Tensor Int) : Nat := t.shape.volume
def decompSize (t : Tensor Int) : Nat := t.shape.volume
theorem size_equiv (t : Tensor Int) : decompSize t = onnxSize t := rfl

def metaSize : OpMeta := { name := "Size", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
