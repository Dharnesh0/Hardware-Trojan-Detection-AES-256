# Trojan T3: Sequential Trigger

This directory contains the RTL implementation of the T3 hardware Trojan, a time-delayed logic attack.

**Trojan Characteristics:**
* Triggered by a 4-bit asynchronous counter that increments when a specific internal signal is set, activating the payload only when the fourth bit is reached.
* Payload flips the LSB of the output, rendering the encryption useless.
* **Overhead:** <50 logic gates.
* Exhibits *synthesis-masking*. The EDA tool classifies the dormant paths as non-critical and optimizes them alongside adjacent cipher logic, reducing total switching and yielding a -0.72% power deviation.
