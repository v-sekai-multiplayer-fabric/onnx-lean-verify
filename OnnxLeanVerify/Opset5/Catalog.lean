-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.Opset5.Reshape

namespace OnnxLeanVerify.Opset5

def opset5Catalog : List OpMeta :=
  [
    metaReshape
  ]

theorem opset5_count : opset5Catalog.length = 1 := by native_decide

end OnnxLeanVerify.Opset5
