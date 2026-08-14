# Dual-Metric Detection of Synthesis-Masked Hardware Trojans in AES-256

![Research](https://img.shields.io/badge/Research-Hardware_Security-8A2BE2.svg)
![Cipher](https://img.shields.io/badge/Algorithm-AES--256-blue.svg)
![Target](https://img.shields.io/badge/Platform-Xilinx_Versal_VCK5000-orange.svg)
![Published](https://img.shields.io/badge/Published-JTCSST-brightgreen.svg)

> **Official Repository for the publication:** *"Dual-Metric Detection of Synthesis-Masked Hardware Trojans in AES-256: Correlating Power Signatures with Switching Activity"*.

## Abstract

Hardware Trojans can be accidentally hidden due to synthesis optimizations performed by electronic design automation (EDA) tools in cryptosystems, leaving critical detection gaps. Traditional detection relies on the assumption that malicious logic increases power consumption. However, this project demonstrates that EDA optimization can suppress or nullify Trojan signatures, resulting in unexpected **negative power deviations**. 

This repository introduces a **dual-metric correlation framework** that pairs vector-based power analysis with micro-architectural switching activity distributions (SAIF parsing) to successfully detect synthesis-masked and synthesis-neutralized hardware Trojans.

## Key Contributions & Discoveries

*   Characterized two distinct EDA interaction failures: *Synthesis-Masked Dormant Trojans* (lower toggles, leftward-shifting distributions) and *Synthesis-Neutralized Active Trojans* (40% more active nets, but lower total power).
*   Achieved reproducible structural detection by correlating sub-threshold power deviations (-0.58% to -0.72%) with KL divergence statistics (0.03–0.42) from switching histograms.
*   Demonstrated that 3 out of 4 tested hardware Trojans exhibited negative power deviations, contradicting standard detection assumptions.

## Hardware Trojan Threat Models

Four distinct RTL-level hardware Trojans were synthesized into an AES-256 core (NIST FIPS 197 compliant) and evaluated:

| Trojan | Trigger | Payload | Synthesis Effect | Power Signature | Kullback–Leibler (KL) Divergence |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **T1** | Rare Sequence | Battery Drain | Neutralized | -0.67% | 0.42 (Right Shift) |
| **T2** | Signal Comparator | LSB Bit Flip | Leakage Bomb | +110.80% | 0.03 (Center) |
| **T3** | Time/Count | LSB Bit Flip | Masked | -0.72% | 0.18 (Left Shift) |
| **T4** | Specific Key | Func. Failure | Masked | -0.58% | 0.21 (Left Shift) |

## Experimental Methodology

1.  The designs were synthesized targeting the 7nm Xilinx Versal VCK5000 architecture using Vivado 2023.2.
2.  Simulations ran for 10,000 clock cycles (30,000 for T1) across 714 different key/plaintext combinations.
3.  Switching Activity Interchange Format (SAIF) files captured toggle counts across 646 internal nets and the switching data was extracted.
4.  Post-synthesis vector-based power estimation was correlated with switching distribution histograms generated using Sturges' formula.

## Repository Structure

*   [`Manuscript/`](Manuscript/) - Final published paper.
*   [`RTL_Source/`](RTL_Source/) - Golden AES-256 and infected Verilog source files.
*   [`Testbenches/`](Testbenches/) - Testbenches for the Trojan-Free core and the infected cores.
*   [`Synthesis_Netlists/`](Synthesis_Netlists/) - Post-synthesis netlists for the Versal architecture.
*   [`Simulation_SAIF/`](Simulation_SAIF/) - Extracted switching activity files.
*   [`Power_Reports/`](Power_Reports/) - Vivado vector-based power estimations.
*   [`Scripts/`](Scripts/) - Python algorithms for SAIF parsing and KL divergence computation.

## Citation

If you use this research or dataset in your work, please cite the original publication:

```bibtex
K., Rahimunnisa, Aadhitya G., Abhyjeet J., and Dharnesh S. 2026. “Dual-Metric Detection of Synthesis-Masked Hardware Trojans in AES-256: Correlating Power Signatures with Switching Activity”. Journal of Trends in Computer Science and Smart Technology 8 (2): 243-266.
