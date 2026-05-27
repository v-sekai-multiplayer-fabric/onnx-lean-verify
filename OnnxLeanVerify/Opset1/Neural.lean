-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
--
-- Opset 1 neural-network operators (26 of 85)
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics

namespace OnnxLeanVerify
namespace Opset1

-- ── Convolution ──────────────────────────────────────────────────────────────

structure ConvAttrs where
  kernelShape : List Nat
  strides : List Nat := [1]
  pads : List Nat := [0, 0]
  dilations : List Nat := [1]
  group : Nat := 1
  deriving Repr

def convOp (_input _weight : Tensor Int) (_attrs : ConvAttrs) : Tensor Int := sorry
def convTransposeOp (_input _weight : Tensor Int) (_attrs : ConvAttrs) : Tensor Int := sorry

-- ── Pooling ──────────────────────────────────────────────────────────────────

structure PoolAttrs where
  kernelShape : List Nat
  strides : List Nat := [1]
  pads : List Nat := [0, 0]
  deriving Repr

def maxPoolOp (_t : Tensor Int) (_attrs : PoolAttrs) : Tensor Int := sorry
def averagePoolOp (_t : Tensor Int) (_attrs : PoolAttrs) : Tensor Int := sorry
def lpPoolOp (_t : Tensor Int) (_p : Nat) (_attrs : PoolAttrs) : Tensor Int := sorry
def globalMaxPoolOp (_t : Tensor Int) : Tensor Int := sorry
def globalAveragePoolOp (_t : Tensor Int) : Tensor Int := sorry
def globalLpPoolOp (_t : Tensor Int) (_p : Nat) : Tensor Int := sorry

-- ── Normalization ────────────────────────────────────────────────────────────

def batchNormOp (_input _scale _bias _mean _variance : Tensor Int)
    (_epsilon : Int) : Tensor Int := sorry
def instanceNormOp (_input _scale _bias : Tensor Int)
    (_epsilon : Int) : Tensor Int := sorry
def lrnOp (_t : Tensor Int) (_size : Nat) (_alpha _beta _bias : Int) :
    Tensor Int := sorry
def lpNormOp (_t : Tensor Int) (_p : Nat) (_axis : Int) : Tensor Int := sorry

-- ── Linear algebra ───────────────────────────────────────────────────────────

def matMulOp (_a _b : Tensor Int) : Tensor Int := sorry
def gemmOp (_a _b _c : Tensor Int) (_alpha _beta : Int)
    (_transA _transB : Bool) : Tensor Int := sorry

-- ── Activation (multi-element) ───────────────────────────────────────────────

def softmaxOp (_t : Tensor Int) (_axis : Nat) : Tensor Int := sorry
def logSoftmaxOp (_t : Tensor Int) (_axis : Nat) : Tensor Int := sorry
def hardmaxOp (_t : Tensor Int) (_axis : Nat) : Tensor Int := sorry

-- ── Variadic ─────────────────────────────────────────────────────────────────

def variadicMaxOp (_tensors : List (Tensor Int)) : Tensor Int := sorry
def variadicMeanOp (_tensors : List (Tensor Int)) : Tensor Int := sorry
def variadicMinOp (_tensors : List (Tensor Int)) : Tensor Int := sorry
def variadicSumOp (_tensors : List (Tensor Int)) : Tensor Int := sorry

-- ── Misc ─────────────────────────────────────────────────────────────────────

def castOp (_t : Tensor Int) (_toType : Nat) : Tensor Int := sorry

def constantOp (shape : Shape) (value : Int) : Tensor Int := Tensor.fill shape value

def spaceToDepthOp (_t : Tensor Int) (_blockSize : Nat) : Tensor Int := sorry
def upsampleOp (_t : Tensor Int) (_scales : List Nat) : Tensor Int := sorry

-- ── Proofs ───────────────────────────────────────────────────────────────────

theorem constantOp_shape (s : Shape) (v : Int) : (constantOp s v).shape = s := rfl

-- ── Metadata ─────────────────────────────────────────────────────────────────

def metaAveragePool : OpMeta := ⟨"AveragePool", 1, .full, .executable, .native⟩
def metaBatchNorm : OpMeta := ⟨"BatchNormalization", 1, .conditional "running stats; float boundary", .executable, .native⟩
def metaCast : OpMeta := ⟨"Cast", 1, .conditional "type-dependent precision", .executable, .native⟩
def metaClip : OpMeta := ⟨"Clip", 1, .full, .executable, .native⟩
def metaConstant : OpMeta := ⟨"Constant", 1, .full, .executable, .native⟩
def metaConv : OpMeta := ⟨"Conv", 1, .full, .executable, .native⟩
def metaConvTranspose : OpMeta := ⟨"ConvTranspose", 1, .full, .executable, .native⟩
def metaGemm : OpMeta := ⟨"Gemm", 1, .full, .executable, .native⟩
def metaGlobalAveragePool : OpMeta := ⟨"GlobalAveragePool", 1, .full, .executable, .native⟩
def metaGlobalLpPool : OpMeta := ⟨"GlobalLpPool", 1, .conditional "Lp norm; float boundary", .executable, .native⟩
def metaGlobalMaxPool : OpMeta := ⟨"GlobalMaxPool", 1, .full, .executable, .native⟩
def metaHardmax : OpMeta := ⟨"Hardmax", 1, .full, .executable, .native⟩
def metaInstanceNorm : OpMeta := ⟨"InstanceNormalization", 1, .conditional "float boundary", .executable, .native⟩
def metaLRN : OpMeta := ⟨"LRN", 1, .conditional "float boundary", .executable, .native⟩
def metaLogSoftmax : OpMeta := ⟨"LogSoftmax", 1, .conditional "transcendental", .executable, .native⟩
def metaLpNorm : OpMeta := ⟨"LpNormalization", 1, .conditional "Lp norm; float boundary", .executable, .native⟩
def metaLpPool : OpMeta := ⟨"LpPool", 1, .conditional "Lp norm; float boundary", .executable, .native⟩
def metaMatMul : OpMeta := ⟨"MatMul", 1, .full, .executable, .native⟩
def metaMaxPool : OpMeta := ⟨"MaxPool", 1, .full, .executable, .native⟩
def metaSoftmax : OpMeta := ⟨"Softmax", 1, .conditional "transcendental", .executable, .native⟩
def metaSpaceToDepth : OpMeta := ⟨"SpaceToDepth", 1, .full, .executable, .native⟩
def metaUpsample : OpMeta := ⟨"Upsample", 1, .full, .executable, .native⟩
def metaVariadicMax : OpMeta := ⟨"Max", 1, .full, .executable, .native⟩
def metaVariadicMean : OpMeta := ⟨"Mean", 1, .full, .executable, .native⟩
def metaVariadicMin : OpMeta := ⟨"Min", 1, .full, .executable, .native⟩
def metaVariadicSum : OpMeta := ⟨"Sum", 1, .full, .executable, .native⟩

def allNeuralMeta : List OpMeta := [
  metaAveragePool, metaBatchNorm, metaCast, metaClip, metaConstant,
  metaConv, metaConvTranspose, metaGemm, metaGlobalAveragePool,
  metaGlobalLpPool, metaGlobalMaxPool, metaHardmax, metaInstanceNorm,
  metaLRN, metaLogSoftmax, metaLpNorm, metaLpPool, metaMatMul,
  metaMaxPool, metaSoftmax, metaSpaceToDepth, metaUpsample,
  metaVariadicMax, metaVariadicMean, metaVariadicMin, metaVariadicSum]

end Opset1
end OnnxLeanVerify
