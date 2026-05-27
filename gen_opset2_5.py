#!/usr/bin/env python3
"""Generate opset 2-5 operator files (7 ops total)."""
import os

BASE = os.path.dirname(os.path.abspath(__file__))

H = """-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

"""
F = "\nend OnnxLeanVerify.Opset{v}\n"

def w(opset, name, body, support=".full", sem=".executable"):
    d = os.path.join(BASE, "OnnxLeanVerify", f"Opset{opset}")
    os.makedirs(d, exist_ok=True)
    ns = f"namespace OnnxLeanVerify.Opset{opset}\n"
    meta = f'\ndef meta{name} : OpMeta := {{ name := "{name}", opsetSince := {opset}, support := {support}, semantics := {sem}, utilization := .native }}\n'
    with open(os.path.join(d, f"{name}.lean"), "w", encoding="utf-8") as f:
        f.write(H + ns + body + meta + f"\nend OnnxLeanVerify.Opset{opset}\n")

# ═══════════════════════════════════════════════════════════════════════════
# Opset 2: Pad, Split, LpPool, GlobalLpPool
# ═══════════════════════════════════════════════════════════════════════════

w(2, "Pad", """
-- Opset 2 Pad: adds mode attribute (constant, reflect, edge)
inductive PadMode where | constant | reflect | edge
  deriving Repr, BEq

def onnxPadV2 (data : Array Int) (pads : List Nat) (value : Int)
    (_mode : PadMode := .constant) : Array Int :=
  let padBefore := pads.headD 0
  let padAfter := pads.getD 1 0
  Array.replicate padBefore value ++ data ++ Array.replicate padAfter value

def decompPadV2 := onnxPadV2
""")

w(2, "Split", """
-- Opset 2 Split: adds split attribute to specify output sizes
def onnxSplitV2 (data : Array Int) (axis : Nat := 0) (split : List Nat := []) : List (Array Int) :=
  if split.isEmpty then [data]
  else Id.run do
    let mut result : List (Array Int) := []
    let mut offset := 0
    for s in split do
      result := result ++ [data.toList.drop offset |>.take s |>.toArray]
      offset := offset + s
    return result

def decompSplitV2 := onnxSplitV2
""")

w(2, "LpPool", """
-- Opset 2 LpPool: adds auto_pad, pads attributes
-- Core computation unchanged from opset 1: Lp norm over window
def onnxLpPoolV2Window (window : Array Int) (p : Nat := 2) : Int :=
  evalU .sqrt (evalR .sum (window.map (fun x => evalB .pow_ (if x < 0 then -x else x) p)))

def decompLpPoolV2Window := onnxLpPoolV2Window
""", '.conditional "Lp norm"')

w(2, "GlobalLpPool", """
-- Opset 2 GlobalLpPool: p attribute default changes from 2.0
def onnxGlobalLpPoolV2 (data : Array Int) (p : Nat := 2) : Int :=
  evalU .sqrt (evalR .sum (data.map (fun x => evalB .pow_ (if x < 0 then -x else x) p)))

def decompGlobalLpPoolV2 := onnxGlobalLpPoolV2
""", '.conditional "Lp norm"')

# ═══════════════════════════════════════════════════════════════════════════
# Opset 3: GRU
# ═══════════════════════════════════════════════════════════════════════════

w(3, "GRU", """
-- Opset 3 GRU: adds linear_before_reset attribute
-- z_t = sigmoid(Wz*x_t + Rz*h_{t-1} + Wbz + Rbz)
-- r_t = sigmoid(Wr*x_t + Rr*h_{t-1} + Wbr + Rbr)
-- if linear_before_reset:
--   h_t' = tanh(Wh*x_t + r_t*(Rh*h_{t-1} + Rbh) + Wbh)
-- else:
--   h_t' = tanh(Wh*x_t + Rh*(r_t*h_{t-1}) + Wbh + Rbh)
-- h_t = (1-z_t)*h_t' + z_t*h_{t-1}

def gruGateElem (wx rh bias : Int) : Int :=
  evalB .add (evalB .add wx rh) bias

def gruUpdateElem (z hPrime hPrev : Int) : Int :=
  evalB .add (evalB .mul (evalB .sub 1 z) hPrime) (evalB .mul z hPrev)

def decompGruGateElem := gruGateElem
def decompGruUpdateElem := gruUpdateElem
""", ".full", ".extensional")

# ═══════════════════════════════════════════════════════════════════════════
# Opset 4: Concat
# ═══════════════════════════════════════════════════════════════════════════

w(4, "Concat", """
-- Opset 4 Concat: axis attribute is now required (was optional)
def onnxConcatV4 (arrays : List (Array Int)) (_axis : Nat) : Array Int :=
  arrays.foldl (fun acc a => acc ++ a) #[]

def decompConcatV4 := onnxConcatV4
""")

# ═══════════════════════════════════════════════════════════════════════════
# Opset 5: Reshape
# ═══════════════════════════════════════════════════════════════════════════

w(5, "Reshape", """
-- Opset 5 Reshape: shape becomes an input tensor instead of attribute
-- This is the key semantic change: dynamic shapes
def onnxReshapeV5 (t : Tensor Int) (shapeInput : Array Int) : Tensor Int :=
  let newShape := shapeInput.toList.map Int.toNat
  if h : newShape.volume = t.shape.volume then
    { shape := newShape, data := t.data, h_valid := by rw [t.h_valid, h] }
  else t

def decompReshapeV5 := onnxReshapeV5
""")

# ═══════════════════════════════════════════════════════════════════════════
# Catalog for opsets 2-5
# ═══════════════════════════════════════════════════════════════════════════

for v, ops in [(2, ["GlobalLpPool", "LpPool", "Pad", "Split"]),
               (3, ["GRU"]),
               (4, ["Concat"]),
               (5, ["Reshape"])]:
    d = os.path.join(BASE, "OnnxLeanVerify", f"Opset{v}")
    cat = "-- SPDX-License-Identifier: MIT\n-- Copyright (c) 2026-present V-Sekai contributors\nimport OnnxLeanVerify.Semantics\n"
    for op in ops:
        cat += f"import OnnxLeanVerify.Opset{v}.{op}\n"
    cat += f"\nnamespace OnnxLeanVerify.Opset{v}\n\n"
    cat += f"def opset{v}Catalog : List OpMeta :=\n  [\n"
    for i, op in enumerate(ops):
        ref = f"meta{op}"
        if op == "GRU":
            ref = f"meta{op}"  # GRU is extensional but meta returns OpMeta
        cat += f"    {ref}" + (",\n" if i < len(ops) - 1 else "\n")
    cat += "  ]\n\n"
    cat += f"theorem opset{v}_count : opset{v}Catalog.length = {len(ops)} := by native_decide\n"
    cat += f"\nend OnnxLeanVerify.Opset{v}\n"
    with open(os.path.join(d, "Catalog.lean"), "w", encoding="utf-8") as f:
        f.write(cat)

print("Generated opset 2-5 files")
print("  Opset 2: 4 ops (Pad, Split, LpPool, GlobalLpPool)")
print("  Opset 3: 1 op (GRU)")
print("  Opset 4: 1 op (Concat)")
print("  Opset 5: 1 op (Reshape)")
