# Analysis Scripts

This directory contains the custom Python scripts developed for the micro-architectural switching activity analysis.

## Capabilities
1.  Automatically extracts toggle activity values for the 646 internal structural nets defined in the methodology.
2.  Constructs switching distribution histograms using equal-sized bins calculated via **Sturges' formula** ($k = \lceil \log_2(n) + 1 \rceil$) yielding 11 bins for this datset.
3.  Computes the **Kullback-Leibler (KL) Divergence** to quantify the distributional shift between the infected designs and the Golden reference probability distributions.
