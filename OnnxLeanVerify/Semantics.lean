-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
namespace OnnxLeanVerify

inductive SupportStatus where
  | full
  | conditional (reason : String)
  deriving Repr, BEq

inductive SemanticsKind where
  | executable
  | extensional
  deriving Repr, BEq

inductive UtilizationKind where
  | native
  | importOnly
  deriving Repr, BEq

structure OpMeta where
  name : String
  opsetSince : Nat
  support : SupportStatus
  semantics : SemanticsKind
  utilization : UtilizationKind
  deriving Repr

def OpMeta.isExecutable (m : OpMeta) : Bool := m.semantics == .executable
def OpMeta.isFullSupport (m : OpMeta) : Bool := m.support == .full

-- ── Partial Combinatory Algebra ──────────────────────────────────────────────

class PCA (A : Type) where
  app : A → A → Option A

structure PER (A : Type) where
  rel : A → A → Prop
  symm : ∀ a b, rel a b → rel b a
  trans : ∀ a b c, rel a b → rel b c → rel a c

structure RealizabilitySpec (A : Type) [PCA A] where
  inputPER : PER A
  outputPER : PER A
  realizer : A
  spec : ∀ a, inputPER.rel a a →
    ∃ b, PCA.app realizer a = some b ∧ outputPER.rel b b

-- ── Extensional mechanism tags ───────────────────────────────────────────────

inductive ExtensionalMechanism where
  | statefulRecurrent
  | stochastic
  | complexDataStructure
  | hardwareNumericBoundary
  deriving Repr, BEq

structure ExtensionalOpMeta extends OpMeta where
  mechanism : ExtensionalMechanism
  deriving Repr

end OnnxLeanVerify
