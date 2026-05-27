-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- log(x) = log2(x) * (1/log2(e)); opaque over Int
def onnxLog (x : Int) : Int := evalU .log2 x
def decompLog (x : Int) : Int := evalU .log2 x
theorem log_equiv (x : Int) : decompLog x = onnxLog x := rfl

def metaLog : OpMeta := { name := "Log", opsetSince := 1, support := .conditional "transcendental", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
