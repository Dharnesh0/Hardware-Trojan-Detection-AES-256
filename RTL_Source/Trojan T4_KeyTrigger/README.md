# Trojan T4: Key-Triggered DoS

This directory contains the RTL implementation of the T4 hardware Trojan, modeling an insider Denial of Service (DoS) attack scenario.

**Trojan Characteristics:**
* Continuously monitors the 16 least significant bits of the secret key, waiting for a match with `0xDEAD`.
* Performs a bitwise XOR on the ciphertext LSB to corrupt the encryption output.
* **Overhead:** <100 logic gates.
* Exhibits *synthesis-masking*. Because the trigger is extremely rare and remains dormant during standard simulations, EDA flattening reduces the dynamic switching of the block, shifting the distribution to the left and resulting in a -0.58% power anomaly.
