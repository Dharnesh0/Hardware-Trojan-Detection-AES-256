# Golden AES-256 Core

This directory contains the baseline, uninfected Register Transfer Level (RTL) Verilog files for the AES-256 encryption architecture. 

**Design Specifications:**
* Designed strictly according to the NIST FIPS PUB 197 standard.
* Utilizes a single Round Transformation Module that executes iteratively for all 14 encryption rounds to balance performance and area.
* Synchronous interface accepts 128-bit plaintext and a 256-bit key, outputting 128-bit ciphertext.

This model serves as the critical reference point for all baseline power and switching distribution comparisons.
