-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
--
-- Slang compute shaders for the 12 opaque tinygrad micro-ops.
-- Compile via slangc to SPIR-V (Vulkan), Metal, HLSL, or CUDA.
-- Differential testing validates GPU/CPU against Lean formal specs.
import LeanSlang

namespace OnnxLeanVerify.Codegen
open LeanSlang

private def tid : SlangBinding :=
  { name := "tid", type := .vec .uint 3, semantic := .svDispatchThreadId }

private def rwFloat (name : String) (idx : Nat) : SlangBinding :=
  { name := name, type := .rwBuf (.scalar .float), binding := some idx, space := some 0 }

private def rwInt (name : String) (idx : Nat) : SlangBinding :=
  { name := name, type := .rwBuf (.scalar .int), binding := some idx, space := some 0 }

private def ix := SlangExpr.member (.var "tid") "x"

-- ── Unary float shaders (5): recip, sqrt, sin, exp2, log2 ───────────────────

private def unaryFloatShader (kname : String) (expr : SlangExpr → SlangExpr) : SlangShaderModule :=
  { functions := [{
      attrs := [.shaderCompute, .numthreads 64 1 1]
      name := kname
      params := [tid, rwFloat "input" 0, rwFloat "output" 1]
      body := [.assign (.index (.var "output") ix)
                       (expr (.index (.var "input") ix))]
    }] }

def recipShader := unaryFloatShader "recip_kernel" fun a => .bin "/" (.litFloat 1.0) a
def sqrtShader  := unaryFloatShader "sqrt_kernel"  fun a => .call "sqrt" [a]
def sinShader   := unaryFloatShader "sin_kernel"   fun a => .call "sin" [a]
def exp2Shader  := unaryFloatShader "exp2_kernel"  fun a => .call "exp2" [a]
def log2Shader  := unaryFloatShader "log2_kernel"  fun a => .call "log2" [a]

-- ── Binary float shaders (2): fdiv, pow ──────────────────────────────────────

private def binaryFloatShader (kname : String) (expr : SlangExpr → SlangExpr → SlangExpr) :
    SlangShaderModule :=
  { functions := [{
      attrs := [.shaderCompute, .numthreads 64 1 1]
      name := kname
      params := [tid, rwFloat "inputA" 0, rwFloat "inputB" 1, rwFloat "output" 2]
      body := [.assign (.index (.var "output") ix)
        (expr (.index (.var "inputA") ix) (.index (.var "inputB") ix))]
    }] }

def fdivShader := binaryFloatShader "fdiv_kernel" fun a b => .bin "/" a b
def powShader  := binaryFloatShader "pow_kernel"  fun a b => .call "pow" [a, b]

-- ── Binary int shaders (5): shl, shr, xor, or, and ──────────────────────────

private def binaryIntShader (kname op : String) : SlangShaderModule :=
  { functions := [{
      attrs := [.shaderCompute, .numthreads 64 1 1]
      name := kname
      params := [tid, rwInt "inputA" 0, rwInt "inputB" 1, rwInt "output" 2]
      body := [.assign (.index (.var "output") ix)
        (.bin op (.index (.var "inputA") ix) (.index (.var "inputB") ix))]
    }] }

def shlShader := binaryIntShader "shl_kernel" "<<"
def shrShader := binaryIntShader "shr_kernel" ">>"
def xorShader := binaryIntShader "xor_kernel" "^"
def orShader  := binaryIntShader "or_kernel"  "|"
def andShader := binaryIntShader "and_kernel" "&"

-- ── Collection + emit ────────────────────────────────────────────────────────

def allMicroOpShaders : List (String × SlangShaderModule) :=
  [("recip", recipShader), ("sqrt", sqrtShader), ("sin", sinShader),
   ("exp2", exp2Shader), ("log2", log2Shader),
   ("fdiv", fdivShader), ("pow", powShader),
   ("shl", shlShader), ("shr", shrShader),
   ("xor", xorShader), ("or", orShader), ("and", andShader)]

theorem all_micro_op_shaders_count : allMicroOpShaders.length = 12 := by native_decide

def emitAll : List (String × String) :=
  allMicroOpShaders.map fun (name, shader) => (name, LeanSlang.emit shader)

end OnnxLeanVerify.Codegen
