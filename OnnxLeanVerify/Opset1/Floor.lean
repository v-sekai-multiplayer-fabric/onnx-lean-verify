-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- On Int, floor is identity
def onnxFloor (x : Int) : Int := x
def decompFloor (x : Int) : Int := evalU .trunc x
theorem floor_equiv (x : Int) : decompFloor x = onnxFloor x := by simp [decompFloor, onnxFloor, evalU]

def metaFloor : OpMeta := { name := "Floor", opsetSince := 1, support := .conditional "float rounding", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
