-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.Opset3.GRU

namespace OnnxLeanVerify.Opset3

def opset3Catalog : List OpMeta :=
  [
    metaGRU
  ]

theorem opset3_count : opset3Catalog.length = 1 := by native_decide

end OnnxLeanVerify.Opset3
