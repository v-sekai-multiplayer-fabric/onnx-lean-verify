-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
--
-- Opset 1 realizability-based operators (8 of 85)
-- Following Goodman (2025), DOI:10.13140/RG.2.2.22243.92967.
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics

namespace OnnxLeanVerify
namespace Opset1

-- ── Mechanism 1: Stochastic operators ────────────────────────────────────────

structure StochasticSpec where
  name : String
  mechanism : ExtensionalMechanism := .stochastic
  outputInvariant : Array Int → Prop

def randomNormalSpec (_mean _scale : Int) (shape : Shape) : StochasticSpec where
  name := "RandomNormal"
  outputInvariant := fun data => data.size = shape.volume

def randomNormalLikeSpec (shape : Shape) : StochasticSpec where
  name := "RandomNormalLike"
  outputInvariant := fun data => data.size = shape.volume

def randomUniformSpec (low high : Int) (shape : Shape) : StochasticSpec where
  name := "RandomUniform"
  outputInvariant := fun data =>
    data.size = shape.volume ∧ ∀ i : Fin data.size, low ≤ data[i] ∧ data[i] ≤ high

def randomUniformLikeSpec (low high : Int) (shape : Shape) : StochasticSpec where
  name := "RandomUniformLike"
  outputInvariant := fun data =>
    data.size = shape.volume ∧ ∀ i : Fin data.size, low ≤ data[i] ∧ data[i] ≤ high

def dropoutSpec (_ratio : Int) : StochasticSpec where
  name := "Dropout"
  outputInvariant := fun _data => True

-- ── Mechanism 2: Control flow ────────────────────────────────────────────────

structure ControlFlowSpec where
  name : String
  mechanism : ExtensionalMechanism := .complexDataStructure

def ifSpec : ControlFlowSpec where name := "If"
def loopSpec : ControlFlowSpec where name := "Loop"

-- ── Mechanism 3: Stateful/Recurrent ──────────────────────────────────────────

structure RecurrentSpec where
  name : String
  mechanism : ExtensionalMechanism := .statefulRecurrent
  hiddenSize : Nat
  numDirections : Nat := 1

def lstmSpec (hiddenSize : Nat) (bidirectional : Bool := false) : RecurrentSpec where
  name := "LSTM"
  hiddenSize := hiddenSize
  numDirections := if bidirectional then 2 else 1

-- ── PER instantiation ────────────────────────────────────────────────────────

def stochasticPER (spec : StochasticSpec) : PER (Array Int) where
  rel := fun a b => spec.outputInvariant a ∧ spec.outputInvariant b
  symm := fun _ _ ⟨ha, hb⟩ => ⟨hb, ha⟩
  trans := fun _ _ _ ⟨ha, _⟩ ⟨_, hc⟩ => ⟨ha, hc⟩

-- ── Metadata ─────────────────────────────────────────────────────────────────

def metaDropout : ExtensionalOpMeta :=
  ⟨⟨"Dropout", 1, .conditional "training-mode stochastic", .extensional, .native⟩,
   .stochastic⟩
def metaRandomNormal : ExtensionalOpMeta :=
  ⟨⟨"RandomNormal", 1, .conditional "non-deterministic", .extensional, .native⟩,
   .stochastic⟩
def metaRandomNormalLike : ExtensionalOpMeta :=
  ⟨⟨"RandomNormalLike", 1, .conditional "non-deterministic", .extensional, .native⟩,
   .stochastic⟩
def metaRandomUniform : ExtensionalOpMeta :=
  ⟨⟨"RandomUniform", 1, .conditional "non-deterministic", .extensional, .native⟩,
   .stochastic⟩
def metaRandomUniformLike : ExtensionalOpMeta :=
  ⟨⟨"RandomUniformLike", 1, .conditional "non-deterministic", .extensional, .native⟩,
   .stochastic⟩
def metaIf : ExtensionalOpMeta :=
  ⟨⟨"If", 1, .full, .extensional, .native⟩, .complexDataStructure⟩
def metaLoop : ExtensionalOpMeta :=
  ⟨⟨"Loop", 1, .conditional "potentially non-terminating", .extensional, .native⟩,
   .complexDataStructure⟩
def metaLSTM : ExtensionalOpMeta :=
  ⟨⟨"LSTM", 1, .full, .extensional, .native⟩, .statefulRecurrent⟩

def allRealizabilityMeta : List OpMeta := [
  metaDropout.toOpMeta, metaRandomNormal.toOpMeta,
  metaRandomNormalLike.toOpMeta, metaRandomUniform.toOpMeta,
  metaRandomUniformLike.toOpMeta, metaIf.toOpMeta,
  metaLoop.toOpMeta, metaLSTM.toOpMeta]

theorem all_realizability_extensional :
    ∀ m ∈ allRealizabilityMeta, m.semantics = .extensional := by
  intro m hm
  simp only [allRealizabilityMeta, List.mem_cons, List.mem_singleton, List.mem_nil_iff,
    or_false] at hm
  rcases hm with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl <;> rfl

end Opset1
end OnnxLeanVerify
