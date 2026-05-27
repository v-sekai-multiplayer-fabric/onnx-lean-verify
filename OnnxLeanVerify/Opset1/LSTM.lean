-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026-present V-Sekai contributors
import OnnxLeanVerify.Tensor
import OnnxLeanVerify.Semantics
import OnnxLeanVerify.MicroOps

namespace OnnxLeanVerify.Opset1

-- h_t = o_t * tanh(c_t), c_t = f_t * c_{t-1} + i_t * g_t
def lstmGateElem (x w h_ r bias : Int) : Int :=
  evalB .add (evalB .add (evalB .mul w x) (evalB .mul r h_)) bias

def metaLSTM : ExtensionalOpMeta :=
  { toOpMeta := { name := "LSTM", opsetSince := 1, support := .full, semantics := .extensional, utilization := .native }, mechanism := .statefulRecurrent }

end OnnxLeanVerify.Opset1
