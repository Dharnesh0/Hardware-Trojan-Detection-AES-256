# Simulation SAIF Data

This directory hosts the **Switching Activity Interchange Format (SAIF)** files generated during behavioral simulation in Vivado.

## Simulation Parameters
*  10,000 clock cycles (100 microseconds at 100 MHz) for Golden, T2, T3, and T4. T1 was simulated for 30,000 clock cycles to capture its sequential trigger.
*   714 unique plaintext-key pairs utilized consistently across all designs.
*   Exact toggle counts (0→1 or 1→0 transitions) extracted for **646 internal nets**. Primary I/O and power/ground nets were intentionally excluded to isolate data-path switching behavior.

These files are the critical input for the Python parsing scripts to generate the KL divergence histograms.
