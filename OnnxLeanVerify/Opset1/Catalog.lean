-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
--
-- Complete catalog of all 85 ONNX opset 1 operators with three-dimensional
-- semantic accounting per Goodman (2025), DOI:10.13140/RG.2.2.22243.92967.
import OnnxLeanVerify.Opset1.Elementwise
import OnnxLeanVerify.Opset1.Reduce
import OnnxLeanVerify.Opset1.TensorManip
import OnnxLeanVerify.Opset1.Neural
import OnnxLeanVerify.Opset1.Realizability

namespace OnnxLeanVerify
namespace Opset1

def opset1Catalog : List OpMeta :=
  allElementwiseMeta ++ allReduceMeta ++ allTensorManipMeta ++
  allNeuralMeta ++ allRealizabilityMeta

-- ── Accounting invariants (all verified by native_decide) ────────────────────

theorem catalog_size : opset1Catalog.length = 85 := by native_decide

theorem catalog_all_opset1 :
    opset1Catalog.all (fun m => m.opsetSince == 1) = true := by native_decide

def executableOps : List OpMeta :=
  opset1Catalog.filter (fun m => m.semantics == .executable)

def extensionalOps : List OpMeta :=
  opset1Catalog.filter (fun m => m.semantics == .extensional)

theorem executable_count : executableOps.length = 77 := by native_decide
theorem extensional_count : extensionalOps.length = 8 := by native_decide

theorem partition_complete :
    executableOps.length + extensionalOps.length = opset1Catalog.length := by
  native_decide

theorem all_native :
    opset1Catalog.all (fun m => m.utilization == .native) = true := by native_decide

end Opset1
end OnnxLeanVerify
