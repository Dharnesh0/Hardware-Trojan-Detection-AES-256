import re
import math
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import entropy

def parse_saif(file_path):
    toggle_counts = []
    
    # Standard regex to find toggle counts in a SAIF file
    # Example format: (TC 35) or (T01 15) (T10 20)
    tc_pattern = re.compile(r'\(TC\s+(\d+)\)')
    
    try:
        with open(file_path, 'r') as file:
            content = file.read()
            
            # Find all toggle counts
            matches = tc_pattern.findall(content)
            toggle_counts = [int(match) for match in matches]
            
            # NOTE: To strictly isolate the 646 internal nets as per the paper,
            # you would add logic here to filter out primary I/O, clock, and power nets based on the board
            # by parsing the (INSTANCE ...) or (NET ...) hierarchy blocks.
            
    except FileNotFoundError:
        print(f"Error: File {file_path} not found.")
        
    return np.array(toggle_counts)

def calculate_sturges_bins(data_length):
    """
    Calculates the number of bins using Sturges' formula: k = ceil(log2(n) + 1)
    For n = 646 nets, this yields 11 bins.
    """
    if data_length == 0:
        return 1
    return math.ceil(math.log2(data_length) + 1)

def compute_kl_divergence(P, Q):
    """
    Computes the Kullback-Leibler (KL) Divergence: D_KL(P || Q) = sum(P(i) * log2(P(i) / Q(i)))
    Adds a small epsilon to avoid division by zero or log(0) for empty bins.
    """
    epsilon = 1e-10
    P = P + epsilon
    Q = Q + epsilon
    
    # Normalize to create discrete probability distributions
    P_norm = P / np.sum(P)
    Q_norm = Q / np.sum(Q)
    
    # Scipy's entropy calculates KL divergence when two arrays are passed.
    # We use base 2 as specified in the research methodology.
    kl_div = entropy(P_norm, Q_norm, base=2)
    return kl_div

def plot_and_analyze(golden_saif, infected_saif, trojan_name):
    """
    Executes the full pipeline: parsing, binning, KL divergence calculation, and plotting.
    """
    print(f"--- Analyzing: Golden Reference vs {trojan_name} ---")
    
    # 1. Parse SAIF files
    golden_toggles = parse_saif(golden_saif)
    infected_toggles = parse_saif(infected_saif)
    
    if len(golden_toggles) == 0 or len(infected_toggles) == 0:
        print("Error: Could not extract toggle counts. Check SAIF paths and format.")
        return

    # Ensure we are analyzing the 646 internal nets
    n_nets = len(golden_toggles)
    print(f"Extracted {n_nets} nets from the Golden SAIF.")
    
    # 2. Determine Bins using Sturges' Formula
    num_bins = calculate_sturges_bins(n_nets)
    print(f"Calculated Bins (Sturges' Formula): {num_bins}")
    
    # Determine the global range to align both histograms perfectly
    max_toggle = max(np.max(golden_toggles), np.max(infected_toggles))
    min_toggle = min(np.min(golden_toggles), np.min(infected_toggles))
    bins = np.linspace(min_toggle, max_toggle, num_bins + 1)
    
    # 3. Create Histogram Distributions
    golden_hist, _ = np.histogram(golden_toggles, bins=bins)
    infected_hist, _ = np.histogram(infected_toggles, bins=bins)
    
    # 4. Compute KL Divergence
    kl_div = compute_kl_divergence(golden_hist, infected_hist)
    print(f"KL Divergence (D_KL): {kl_div:.4f}\n")
    
    # 5. Plot the Distributions
    plt.figure(figsize=(10, 6))
    
    # Plot Golden Reference
    plt.hist(golden_toggles, bins=bins, alpha=0.6, label='Golden Reference', 
             color='steelblue', edgecolor='black')
             
    # Plot Infected Variant
    plt.hist(infected_toggles, bins=bins, alpha=0.6, label=f'Trojan Infected ({trojan_name})', 
             color='indianred', edgecolor='black')
    
    plt.title(f'Switching Activity Distribution: Golden vs {trojan_name}\nKL Divergence: {kl_div:.3f}', fontsize=14)
    plt.xlabel('Toggle Count (toggles/clock cycle)', fontsize=12)
    plt.ylabel('Number of Nets (Frequency)', fontsize=12)
    plt.legend(fontsize=11)
    plt.grid(axis='y', linestyle='--', alpha=0.7)
    
    # Save the plot
    output_filename = f"Histogram_{trojan_name.replace(' ', '_')}.png"
    plt.savefig(output_filename, dpi=300, bbox_inches='tight')
    print(f"Plot saved successfully as {output_filename}\n")
    plt.show()

if __name__ == "__main__":
    # Example Usage:
    # Ensure your .saif files are in the correct directory
    golden_file = "../Simulation_SAIF/Golden_AES256.saif"
    
    # Analyze T1 (Synthesis-Neutralized Attack)
    t1_file = "../Simulation_SAIF/Trojan_T1.saif"
    # plot_and_analyze(golden_file, t1_file, "T1 (Synthesis-Neutralized)")
    
    # Analyze T3 (Synthesis-Masked Dormant Attack)
    t3_file = "../Simulation_SAIF/Trojan_T3.saif"
    # plot_and_analyze(golden_file, t3_file, "T3 (Synthesis-Masked)")
    
    print("Script ready. Uncomment the analysis lines above with valid SAIF paths to run.")
