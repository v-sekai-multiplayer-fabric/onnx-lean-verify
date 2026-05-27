-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- ReduceSumSquare = sum(mul(x, x))
def onnxReduceSumSquare (arr : Array Int) : Int := evalR .sum (arr.map (fun x => evalB .mul x x))
def decompReduceSumSquare := onnxReduceSumSquare
theorem reduceSumSquare_equiv (arr : Array Int) :
    decompReduceSumSquare arr = onnxReduceSumSquare arr := rfl

def metaReduceSumSquare : OpMeta := { name := "ReduceSumSquare", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
