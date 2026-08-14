# Trojan T1: Battery Drain

This directory contains the RTL implementation of the T1 hardware Trojan, designed for an availability attack targeting battery-powered devices.

**Trojan Characteristics:**
* **Trigger:** Rare sequence detector that activates sequentially following a specific plaintext pattern.
* **Payload:** Initiates constant rotation within a specific register to artificially increase power consumption.
* **Overhead:** <50 logic gates.
* **Synthesis Behavior:** Exhibits *synthesis-neutralization*. The EDA optimization minimizes surrounding path switching to compensate for the Trojan's activity, resulting in a net negative power signature (-0.67%) despite the active payload.
