# Sparse Tensor Train Decomposition via PALM Algorithm (MATLAB)

## Project Description
This work is associated with the accepted paper:  
**"Proximal Alternating Linearized Minimization Algorithm for Sparse Tensor Train Decomposition"**  
(Hu & Chen, 2025, *Statistics, Optimization & Information Computing*)

---

## Experiments in the Paper and Corresponding Code
### Section 5.1: Synthetic Data
| Experiment Case | MATLAB Code Path               |
|-----------------|--------------------------------|
| Different $\mu$ | `Synthetic_data/Untitled1.m`   |
| Different $\gamma$ | `Synthetic_data/Untitled3.m` |
| Different $v$   | `Synthetic_data/Untitled4.m`   |

### Section 5.2: Real-World Data
#### 5.2.1
- Code: `Untitled7.m`

#### 5.2.2
- Code: `Untitled3.m` to `Untitled5.m`

---

## Core Functions
- ​**`PALM_4`** - Proximal Alternating Linearized Minimization algorithm (Main optimization framework)
- **`PALM_no_orth`** - PALM variant without orthogonal constraints (Other components unchanged)
- ​**`SNTT_MUR_2`** Sparse Nonnegative Tensor Train factorization-Multiplicative update rules algorithm
- ​**`PTF`** - Positive Tensor Factorization algorithm

> Note: Other auxiliary functions are designed for debugging and algorithmic extensions. Users should prioritize the three core functions above.

---
## Citation
Hu, Z., & Chen, Z. (2025). Proximal Alternating Linearized Minimization Algorithm for Sparse Tensor Train Decomposition. _Statistics, Optimization & Information Computing_. https://doi.org/10.19139/soic-2310-5070-2440

---

## MATLAB Requirements
- **MATLAB R2016b** (or newer)
- **Tensor Toolbox**: Included in this repository.  
  Initialize it by running `run_first.m` before using the code.

---

