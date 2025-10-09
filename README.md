# Adaptive Filtering Algorithms – Comparative Study
### Author: Andreas Karesiou  
**Department of Computer Engineering and Informatics, University of Patras**

---

## 🧩 Overview

This project implements and compares **four major adaptive filtering approaches** — **LMS**, **WLMS**, **RLS**, and the **optimal Wiener–Hopf filter** — using both synthetic and preloaded data.

The objective is to identify an unknown system’s impulse response \( h[n] \) by adaptively minimizing the mean squared error (MSE) between the system output \( d[n] \) and the filter output \( y[n] \).

All methods are analyzed for their **learning behavior**, **convergence speed**, and **ability to track time-varying systems**.


## 📂 File Structure

| File | Type | Description |
|------|------|-------------|
| **x.mat**, **d.mat** | Data | Contain 100 pairs of input and desired-output signals (each 2000 samples long). Used by all algorithms. |
| **wiener_hopf.m** | Function | Computes optimal Wiener filter coefficients using the Wiener–Hopf equations. |
| **Wiener_Hopf_Filter_Estimation.m** | Script | Uses `wiener_hopf` to estimate optimal coefficients for full, half, and segmented signals. |
| **LMS_Adaptive_Filter_FromData.m** | Script | Implements the Least Mean Squares (LMS) adaptive filter using the loaded datasets. |
| **LMS_WeightEvolution_and_MSE.m** | Script | Visualizes LMS convergence: plots weight evolution and learning curve (MSE vs. iteration). |
| **RLS_Adaptive_Filter_FromData.m** | Script | Implements the Recursive Least Squares (RLS) adaptive filter for system identification. |
| **RLS_WeightEvolution_and_MSE.m** | Script | Plots RLS filter weight evolution and average MSE convergence curve. |
| **WLMS_Adaptive_Filter_FromData.m** | Script | Implements the Windowed Least Mean Squares (WLMS) adaptive filter using a sliding window. |
| **WLMS_WeightEvolution_and_MSE.m** | Script | Visualizes WLMS convergence behavior: learning curve and filter coefficient trajectories. |



## 🧠 Learning Objectives

This project enables you to:

- Understand the theory and implementation of adaptive filters.  
- Compare LMS, WLMS, and RLS convergence speeds and accuracy.  
- Visualize weight adaptation and steady-state error.  
- Explore how adaptive filters track **time-varying systems**, while the Wiener filter cannot.  
- Evaluate convergence behavior through Monte Carlo simulation (100 runs).



## 📊 Experimental Setup

- **Number of signals:** 100  
- **Samples per signal:** 2000  
- **Filter order (p):** 4  
- **True system:**  
  \[
  h(n) = [51.0,\ -41.6,\ -30.73,\ 200.15]
  \]
- **Window size (WLMS):** 5  
- **Forgetting factor (RLS):** 0.9  
- **Learning rate (LMS/WLMS):** 0.01 × (2 / λₘₐₓ)  

---

## 🕒 Additional Observations on Time-Varying Signals

For the **LMS**, **WLMS**, and **RLS** algorithms, the signals \( x[n] \) and \( d[n] \) are **time-varying**.  
Around the **1000th time instant**, the coefficients of the system begin to change, causing the adaptive filters to modify their estimates.  
Specifically, the system transitions from:

\[
h(n) = 51.0\,\delta(n) - 41.6\,\delta(n-1) - 30.73\,\delta(n-2)
\]

to

\[
h(n) = -51.0\,\delta(n) - 41.6\,\delta(n-1) - 30.73\,\delta(n-2)
\]

This change is successfully tracked by the **adaptive filters** (LMS, WLMS, RLS), demonstrating their ability to follow **time-varying system dynamics**.  
In contrast, the **Wiener filter** produces a single optimal static solution and cannot adapt to temporal variations — hence it fails to model this change.

---

## 📈 Results and Analysis

- **LMS:** Stable but slower convergence. Tracks the time-varying system with a small lag.  
- **WLMS:** Faster convergence and smoother weight adaptation due to windowed updates.  
- **RLS:** Rapid convergence and precise tracking of coefficient changes, at the cost of higher complexity.  
- **Wiener–Hopf:** Provides a static optimal solution for the stationary case but cannot adapt when the system changes.
