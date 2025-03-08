# Sparse Tensor Train Decomposition via PALM Algorithm (MATLAB)

## Project Description
This MATLAB code is associated with the paper **"PALM Algorithm for Sparse Tensor Train Decomposition"**, which has passed initial peer review and is currently in the revision stage.

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
| Function    | File         |
|-------------|--------------|
| `PALM_4`    | `PALM_4.m`   |
| `SNTT_MUR_2` | `SNTT_MUR_2.m` |
| `PTF`       | `PTF.m`      |

---

## MATLAB Requirements
- **MATLAB R2016b** (or newer)
- **Tensor Toolbox**: Included in this repository.  
  Initialize it by running `run_first.m` before using the code.

---

## Basic Usage
1. Clone the repository:
   ```matlab
   !git clone https://github.com/yourusername/sparse-tt-palm-matlab.git
