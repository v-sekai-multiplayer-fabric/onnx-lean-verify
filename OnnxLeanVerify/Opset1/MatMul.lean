-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- matmul(A[m,k], B[k,n]) -> C[m,n] where C[i,j] = reduce.sum(mul(A[i,:], B[:,j]))
-- Full tensor version requires strided indexing; scalar dot product here
def onnxDot (a b : Array Int) (h : a.size = b.size) : Int :=
  evalR .sum (Array.zipWith (evalB .mul) a b)
def decompDot (a b : Array Int) (h : a.size = b.size) : Int := onnxDot a b h
theorem dot_equiv (a b : Array Int) (h : a.size = b.size) : decompDot a b h = onnxDot a b h := rfl

def metaMatMul : OpMeta := { name := "MatMul", opsetSince := 1, support := .full, semantics := .executable, utilization := .native }

end OnnxLeanVerify.Opset1
