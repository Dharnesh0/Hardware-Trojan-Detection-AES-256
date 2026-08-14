# Trojan T2: Leakage Bomb

This directory contains the RTL implementation of the T2 hardware Trojan, designed to induce extreme static leakage.

**Trojan Characteristics:**
* **Trigger:** Combinational signal comparator that activates when two uncommon signals (`s2` and `s5`) occur simultaneously in their HIGH states.
* **Payload:** Flips the least significant bit (LSB) of the encrypted output, corrupting the ciphertext.
* **Overhead:** <50 logic gates.
* **Synthesis Behavior:** Functions as a "Leakage Bomb," creating internal node contention that drives static power up by over 270% (yielding a Z-score of +118.4) with minimal dynamic switching shift.
