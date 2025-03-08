# Sparse Tensor Train Decomposition via PALM Algorithm (MATLAB)

[![MATLAB](https://img.shields.io/badge/MATLAB-R2021a%2B-blue.svg)](https://www.mathworks.com/products/matlab.html)
[![Paper Status](https://img.shields.io/badge/Paper%20Status-Revision%20Stage-orange)](https://arxiv.org/abs/XXXX.XXXXX)

## Project Overview
This MATLAB repository implements the algorithms and experiments for the paper **"PALM Algorithm for Sparse Tensor Train Decomposition"** (currently under revision). The code provides efficient sparse tensor train decomposition using the Proximal Alternating Linearized Minimization (PALM) framework.

---

## Correspondence Between Paper Experiments and Code
### Section 5.1: Synthetic Data Analysis
| Experiment Case          | MATLAB Scripts                   | Description                     |
|--------------------------|-----------------------------------|---------------------------------|
| Varying $\mu$            | `Synthetic_data/run_experiment_mu.m`    | Sensitivity analysis for $\mu$  |
| Varying $\gamma$         | `Synthetic_data/run_experiment_gamma.m` | Impact of regularization $\gamma$ |
| Varying $v$              | `Synthetic_data/run_experiment_v.m`     | Convergence analysis for $v$    |

### Section 5.2: Real-World Applications
#### 5.2.1: Image Compression
- **Script**: `applications/image_compression_demo.m`  
  ```matlab
  % Example usage:
  img = imread('data/test_image.jpg');
  compressed_tt = PALM_4(img, 'mu', 0.1, 'max_iter', 50);
