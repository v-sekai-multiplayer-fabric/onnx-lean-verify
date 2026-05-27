-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
namespace OnnxLeanVerify

abbrev Shape := List Nat

namespace Shape

def volume : Shape → Nat
  | [] => 1
  | d :: ds => d * volume ds

@[simp] theorem volume_nil : volume ([] : Shape) = 1 := rfl
@[simp] theorem volume_cons (d : Nat) (ds : Shape) :
    volume (d :: ds) = d * volume ds := rfl

theorem volume_singleton (d : Nat) : volume [d] = d := by simp [volume]

end Shape

structure Tensor (α : Type) where
  shape : Shape
  data : Array α
  h_valid : data.size = shape.volume

namespace Tensor

def scalar (x : α) : Tensor α :=
  ⟨[], #[x], by simp [Shape.volume]⟩

def map (f : α → β) (t : Tensor α) : Tensor β :=
  ⟨t.shape, t.data.map f, by simp [Array.size_map, t.h_valid]⟩

def zipWith (f : α → β → γ) (a : Tensor α) (b : Tensor β)
    (h : a.shape = b.shape) : Tensor γ :=
  ⟨a.shape, Array.zipWith f a.data b.data, by
    simp [Array.size_zipWith, a.h_valid, b.h_valid, h]⟩

def fill (s : Shape) (x : α) : Tensor α :=
  ⟨s, Array.replicate s.volume x, by simp [Array.size_replicate]⟩

def numel (t : Tensor α) : Nat := t.data.size
def rank (t : Tensor α) : Nat := t.shape.length

theorem map_shape (f : α → β) (t : Tensor α) : (t.map f).shape = t.shape := rfl
theorem fill_shape (s : Shape) (x : α) : (fill s x).shape = s := rfl

def foldl (f : β → α → β) (init : β) (t : Tensor α) : β :=
  t.data.foldl f init

def get (t : Tensor α) (i : Fin t.data.size) : α := t.data[i]

end Tensor
end OnnxLeanVerify
