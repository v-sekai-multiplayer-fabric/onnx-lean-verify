-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset2

-- Opset 2 LpPool: adds auto_pad, pads attributes
-- Core computation unchanged from opset 1: Lp norm over window
def onnxLpPoolV2Window (window : Array Int) (p : Nat := 2) : Int :=
  evalU .sqrt (evalR .sum (window.map (fun x => evalB .pow_ (if x < 0 then -x else x) p)))

def decompLpPoolV2Window := onnxLpPoolV2Window

def metaLpPool : OpMeta := { name := "LpPool", opsetSince := 2, support := .conditional "Lp norm", semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset2
