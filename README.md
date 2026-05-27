# onnx-lean-verify

Peer review recreation of [Goodman (2025)](https://doi.org/10.13140/RG.2.2.22243.92967) — formally verifying the ONNX operator catalog in Lean 4, starting from opset 1 through opset 26.

## Architecture

Following the paper's dual-architecture approach:

1. **Executable evaluators** (77 of 85 opset-1 operators) — pure Lean 4 kernels with proofs of key properties (commutativity, associativity, non-negativity, shape preservation).

2. **Realizability-based extensional semantics** (8 operators) — PCA + PER framework for non-deterministic operators (Dropout, Random*, If, Loop, LSTM).

3. **Three-dimensional semantic accounting** — every operator tracks:
   - **Support status**: full vs conditional (with boundary reasons)
   - **Semantics kind**: executable vs extensional
   - **Utilization kind**: native vs import-only

### Tinygrad micro-op reduction

Future opsets will leverage [tinygrad](https://github.com/tinygrad/tinygrad)'s insight that all ONNX operators decompose into a small set of micro-ops (movement, unary, binary, reduce, ternary), drastically cutting the proof surface.

## Building

```bash
lake build
```

Requires Lean 4.30.0 (no Mathlib dependency).

## Opset 1 status

- **85 operators** classified and cataloged
- **77 executable** / **8 extensional** partition verified via `native_decide`
- Key properties proved: `abs_nonneg`, `relu_nonneg`, `relu_le_abs`, `neg_neg`, `identity_involutive`, `reduceL1_nonneg`, `reshapeOp_preserves_numel`, `flattenOp_preserves_numel`, `all_realizability_extensional`
- Complex operators (Conv, Pool, MatMul, etc.) have type signatures and metadata; implementations are `sorry` placeholders

## References

See [references.bib](references.bib).
