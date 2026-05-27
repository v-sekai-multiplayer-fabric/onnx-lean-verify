-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

def onnxShape (t : Tensor Int) : List Nat := t.shape
def decompShape (t : Tensor Int) : List Nat := t.shape
theorem shape_equiv (t : Tensor Int) : decompShape t = onnxShape t := rfl

def metaShape : OpMeta := { name := "Shape", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
