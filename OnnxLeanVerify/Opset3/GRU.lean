-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset3

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

def metaGRU : OpMeta := { name := "GRU", opsetSince := 3, support := .full, semantics := .extensional, utilization := .native }

end OnnxLeanVerify.Opset3
