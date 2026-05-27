-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.Opset4.Concat

namespace OnnxLeanVerify.Opset4

def opset4Catalog : List OpMeta :=
  [
    metaConcat
  ]

theorem opset4_count : opset4Catalog.length = 1 := by native_decide

end OnnxLeanVerify.Opset4
