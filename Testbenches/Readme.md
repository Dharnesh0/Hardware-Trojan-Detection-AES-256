# AES-256 Hardware Trojan Simulation & Testbench Suite

Simulation testbenches, verification environments, and stimulus vectors used for vector-based power and switching activity analysis of golden and Trojan-infected AES-256 cores.

## Overview

* 1x Golden Reference AES-256 core and 4x Trojan-infected variants (T1: Battery Drain, T2: Leakage Bomb, T3: Sequential Counter, T4: Key-Triggered DoS).
* 714 pseudo-random plaintext-key test vector pairs providing 100% toggle coverage across 646 internal nets.
* 10,000 clock cycles (100 μs at 100 MHz) for Golden, T2, T3, and T4; 30,000 clock cycles for T1 sequential activation.
* Vector-based Switching Activity Interchange Format (`.saif`) files for dynamic power and switching distribution analysis in Xilinx Vivado.
