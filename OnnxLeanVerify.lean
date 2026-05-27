-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
--
-- Peer review recreation of Goodman (2025), DOI:10.13140/RG.2.2.22243.92967
-- Full semantic closure of ONNX opset 1 (85 operators) via tinygrad micro-ops.
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps
import OnnxLeanVerify.Opset1.Catalog
