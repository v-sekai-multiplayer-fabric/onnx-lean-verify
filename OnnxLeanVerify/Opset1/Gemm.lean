-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- gemm(A,B,C,alpha,beta) = alpha * matmul(A,B) + beta * C
-- Scalar element: mulacc decomposition
def onnxGemmElem (abElem cElem alpha beta : Int) : Int :=
  evalT .mulacc alpha abElem (evalB .mul beta cElem)
def decompGemmElem (abElem cElem alpha beta : Int) : Int := onnxGemmElem abElem cElem alpha beta
theorem gemm_equiv (ab c a b : Int) : decompGemmElem ab c a b = onnxGemmElem ab c a b := rfl

def metaGemm : OpMeta := { name := "Gemm", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
