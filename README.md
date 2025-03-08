# Sparse Tensor Train Decomposition via PALM Algorithm



## Project Overview
This repository contains the implementation and experiments for the paper **"PALM Algorithm for Sparse Tensor Train Decomposition"**, which has passed initial peer review and is currently under revision. The code provides a scalable approach for sparse tensor train decomposition using the Proximal Alternating Linearized Minimization (PALM) framework.

---

## Correspondence Between Paper Experiments and Code
Below is the mapping between the experimental sections in the paper and the corresponding code/directories:

### Section 5.1: Synthetic Data Analysis
| Experiment Case          | Code Path                          | Description                     |
|--------------------------|------------------------------------|---------------------------------|
| Varying $\mu$            | `Synthetic_data/Untitled1`         | Sensitivity analysis for $\mu$  |
| Varying $\gamma$         | `Synthetic_data/Untitled3`         | Impact of regularization $\gamma$ |
| Varying $v$              | `Synthetic_data/Untitled4`         | Convergence analysis for $v$    |

### Section 5.2: Real-World Applications
#### 5.2.1: Image Compression
- **Code**: `Untitled7`  
  Tensor train decomposition for image datasets.

#### 5.2.2: Feature Extraction
- **Code**: `Untitled3` to `Untitled5`  
  Feature extraction pipeline for high-dimensional data.

---

## Core Functions
The key algorithmic components are implemented in the following functions:
- **`PALM_4`**: Main optimization loop of the Proximal Alternating Linearized Minimization algorithm.
- **`SNTT_MUR_2`**: Sparse Non-negative Tensor Train update rules.
- **`PTF`**: Parallel tensor factorization module for distributed computing.

---

## Getting Started
### Dependencies
- Python 3.8+
- NumPy, SciPy, PyTorch
- Matplotlib (for visualization)

### Usage Example
```python
from core import PALM_4

# Initialize tensor and parameters
X = load_tensor("data/synthetic.pt")
result = PALM_4(X, mu=0.1, max_iter=100)
