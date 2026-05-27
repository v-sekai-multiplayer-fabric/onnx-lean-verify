-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.Opset1.Abs
import OnnxLeanVerify.Opset1.Add
import OnnxLeanVerify.Opset1.And
import OnnxLeanVerify.Opset1.ArgMax
import OnnxLeanVerify.Opset1.ArgMin
import OnnxLeanVerify.Opset1.AveragePool
import OnnxLeanVerify.Opset1.BatchNormalization
import OnnxLeanVerify.Opset1.Cast
import OnnxLeanVerify.Opset1.Ceil
import OnnxLeanVerify.Opset1.Clip
import OnnxLeanVerify.Opset1.Concat
import OnnxLeanVerify.Opset1.Constant
import OnnxLeanVerify.Opset1.Conv
import OnnxLeanVerify.Opset1.ConvTranspose
import OnnxLeanVerify.Opset1.Dropout
import OnnxLeanVerify.Opset1.Equal
import OnnxLeanVerify.Opset1.Exp
import OnnxLeanVerify.Opset1.Flatten
import OnnxLeanVerify.Opset1.Floor
import OnnxLeanVerify.Opset1.Gather
import OnnxLeanVerify.Opset1.Gemm
import OnnxLeanVerify.Opset1.GlobalAveragePool
import OnnxLeanVerify.Opset1.GlobalLpPool
import OnnxLeanVerify.Opset1.GlobalMaxPool
import OnnxLeanVerify.Opset1.Greater
import OnnxLeanVerify.Opset1.Hardmax
import OnnxLeanVerify.Opset1.Identity
import OnnxLeanVerify.Opset1.If
import OnnxLeanVerify.Opset1.InstanceNormalization
import OnnxLeanVerify.Opset1.LRN
import OnnxLeanVerify.Opset1.LSTM
import OnnxLeanVerify.Opset1.LeakyRelu
import OnnxLeanVerify.Opset1.Less
import OnnxLeanVerify.Opset1.Log
import OnnxLeanVerify.Opset1.LogSoftmax
import OnnxLeanVerify.Opset1.Loop
import OnnxLeanVerify.Opset1.LpNormalization
import OnnxLeanVerify.Opset1.LpPool
import OnnxLeanVerify.Opset1.MatMul
import OnnxLeanVerify.Opset1.Max
import OnnxLeanVerify.Opset1.MaxPool
import OnnxLeanVerify.Opset1.Mean
import OnnxLeanVerify.Opset1.Min
import OnnxLeanVerify.Opset1.Mul
import OnnxLeanVerify.Opset1.Neg
import OnnxLeanVerify.Opset1.Not
import OnnxLeanVerify.Opset1.Or
import OnnxLeanVerify.Opset1.PRelu
import OnnxLeanVerify.Opset1.Pad
import OnnxLeanVerify.Opset1.Pow
import OnnxLeanVerify.Opset1.RandomNormal
import OnnxLeanVerify.Opset1.RandomNormalLike
import OnnxLeanVerify.Opset1.RandomUniform
import OnnxLeanVerify.Opset1.RandomUniformLike
import OnnxLeanVerify.Opset1.Reciprocal
import OnnxLeanVerify.Opset1.ReduceL1
import OnnxLeanVerify.Opset1.ReduceL2
import OnnxLeanVerify.Opset1.ReduceLogSum
import OnnxLeanVerify.Opset1.ReduceLogSumExp
import OnnxLeanVerify.Opset1.ReduceMax
import OnnxLeanVerify.Opset1.ReduceMean
import OnnxLeanVerify.Opset1.ReduceMin
import OnnxLeanVerify.Opset1.ReduceProd
import OnnxLeanVerify.Opset1.ReduceSum
import OnnxLeanVerify.Opset1.ReduceSumSquare
import OnnxLeanVerify.Opset1.Relu
import OnnxLeanVerify.Opset1.Reshape
import OnnxLeanVerify.Opset1.Shape
import OnnxLeanVerify.Opset1.Sigmoid
import OnnxLeanVerify.Opset1.Sin
import OnnxLeanVerify.Opset1.Size
import OnnxLeanVerify.Opset1.Slice
import OnnxLeanVerify.Opset1.Softmax
import OnnxLeanVerify.Opset1.SpaceToDepth
import OnnxLeanVerify.Opset1.Split
import OnnxLeanVerify.Opset1.Sqrt
import OnnxLeanVerify.Opset1.Squeeze
import OnnxLeanVerify.Opset1.Sub
import OnnxLeanVerify.Opset1.Sum
import OnnxLeanVerify.Opset1.Tanh
import OnnxLeanVerify.Opset1.Tile
import OnnxLeanVerify.Opset1.Transpose
import OnnxLeanVerify.Opset1.Unsqueeze
import OnnxLeanVerify.Opset1.Upsample
import OnnxLeanVerify.Opset1.Xor

namespace OnnxLeanVerify.Opset1

def opset1Catalog : List OpMeta :=
  [
    metaAbs,
    metaAdd,
    metaAnd,
    metaArgMax,
    metaArgMin,
    metaAveragePool,
    metaBatchNormalization,
    metaCast,
    metaCeil,
    metaClip,
    metaConcat,
    metaConstant,
    metaConv,
    metaConvTranspose,
    metaDropout.toOpMeta,
    metaEqual,
    metaExp,
    metaFlatten,
    metaFloor,
    metaGather,
    metaGemm,
    metaGlobalAveragePool,
    metaGlobalLpPool,
    metaGlobalMaxPool,
    metaGreater,
    metaHardmax,
    metaIdentity,
    metaIf.toOpMeta,
    metaInstanceNormalization,
    metaLRN,
    metaLSTM.toOpMeta,
    metaLeakyRelu,
    metaLess,
    metaLog,
    metaLogSoftmax,
    metaLoop.toOpMeta,
    metaLpNormalization,
    metaLpPool,
    metaMatMul,
    metaMax,
    metaMaxPool,
    metaMean,
    metaMin,
    metaMul,
    metaNeg,
    metaNot,
    metaOr,
    metaPRelu,
    metaPad,
    metaPow,
    metaRandomNormal.toOpMeta,
    metaRandomNormalLike.toOpMeta,
    metaRandomUniform.toOpMeta,
    metaRandomUniformLike.toOpMeta,
    metaReciprocal,
    metaReduceL1,
    metaReduceL2,
    metaReduceLogSum,
    metaReduceLogSumExp,
    metaReduceMax,
    metaReduceMean,
    metaReduceMin,
    metaReduceProd,
    metaReduceSum,
    metaReduceSumSquare,
    metaRelu,
    metaReshape,
    metaShape,
    metaSigmoid,
    metaSin,
    metaSize,
    metaSlice,
    metaSoftmax,
    metaSpaceToDepth,
    metaSplit,
    metaSqrt,
    metaSqueeze,
    metaSub,
    metaSum,
    metaTanh,
    metaTile,
    metaTranspose,
    metaUnsqueeze,
    metaUpsample,
    metaXor
  ]

theorem opset1_count : opset1Catalog.length = 85 := by native_decide
theorem opset1_all_v1 : opset1Catalog.all (fun m => m.opsetSince == 1) = true := by native_decide
theorem opset1_all_native : opset1Catalog.all (fun m => m.utilization == .native) = true := by native_decide

def executableOps := opset1Catalog.filter (fun m => m.semantics == .executable)
def extensionalOps := opset1Catalog.filter (fun m => m.semantics == .extensional)
theorem exec_count : executableOps.length = 77 := by native_decide
theorem ext_count : extensionalOps.length = 8 := by native_decide
theorem partition_complete : executableOps.length + extensionalOps.length = 85 := by native_decide

end OnnxLeanVerify.Opset1
