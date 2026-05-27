-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset2

-- Opset 2 GlobalLpPool: p attribute default changes from 2.0
def onnxGlobalLpPoolV2 (data : Array Int) (p : Nat := 2) : Int :=
  evalU .sqrt (evalR .sum (data.map (fun x => evalB .pow_ (if x < 0 then -x else x) p)))

def decompGlobalLpPoolV2 := onnxGlobalLpPoolV2

def metaGlobalLpPool : OpMeta := { name := "GlobalLpPool", opsetSince := 2, support := .conditional "Lp norm", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset2
