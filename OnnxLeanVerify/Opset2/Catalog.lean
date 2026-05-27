-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.Opset2.GlobalLpPool
import OnnxLeanVerify.Opset2.LpPool
import OnnxLeanVerify.Opset2.Pad
import OnnxLeanVerify.Opset2.Split

namespace OnnxLeanVerify.Opset2

def opset2Catalog : List OpMeta :=
  [
    metaGlobalLpPool,
    metaLpPool,
    metaPad,
    metaSplit
  ]

theorem opset2_count : opset2Catalog.length = 4 := by native_decide

end OnnxLeanVerify.Opset2
