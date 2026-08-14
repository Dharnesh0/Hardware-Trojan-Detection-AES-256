# RTL Source Codes

This directory contains the Register Transfer Level (RTL) Verilog files used for the experimental testbed.

*   **Golden_AES256:** The baseline, uninfected AES-256 encryption architecture designed strictly according to the NIST FIPS PUB 197 standard. It utilizes a single Round Transformation Module executed iteratively.
*   **Trojan_T1_BatteryDrain:** Implements a sequential rare-event trigger designed to rotate a register continuously, modeling a battery exhaustion attack.
*   **Trojan_T2_LeakageBomb:** A signal comparator trigger that activates when two uncommon signals transition to HIGH simultaneously, flipping the ciphertext LSB.
*   **Trojan_T3_SequentialTrigger:** Utilizes a 4-bit asynchronous counter to trigger an LSB bit-flip after specific encryption conditions persist.
*   **Trojan_T4_KeyTrigger:** Monitors the 16 least significant bits of the key for a specific pattern (`0xDEAD`) to trigger functional failure.

*Note: The Trojan insertions were designed to utilize minimal overhead (<50 to <100 gates) to test synthesis masking limits*.
