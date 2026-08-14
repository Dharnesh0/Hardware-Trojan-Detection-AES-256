`timescale 1ns / 1ps

module AES_tb();

    // Clock and control inputs
    reg clk;
    reg rst;
    reg start;
    reg key_valid;
    reg data_valid;

    // Data inputs
    reg [127:0] in;
    reg [255:0] key256;

    // Outputs
    wire [127:0] e256;
    wire [127:0] d256;
    wire signal;

    // Instantiate the AES module
    AES uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .key_valid(key_valid),
        .data_valid(data_valid),
        .in(in),
        .key256(key256),
        .e256(e256),
        .d256(d256),
        .signal(signal)
    );

    // Generate a clock with 10ns period (100 MHz)
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Time | Input                          | Encrypted                       | Decrypted                       | Match");
        $monitor("%0t | %h | %h | %h | %b", $time, in, e256, d256, signal);

        // Initialize signals
rst = 1;
start = 0;
key_valid = 0;
data_valid = 0;
in = 128'h0;
key256 = 256'h0;

// Apply reset
#12;  // not aligned with posedge to check robustness
rst = 0;

// Wait for a clock edge
#8;

// ===== Trigger Sequence for AES-T500 Trojan =====

// Step 1
in = 128'h3243f6a8885a308d313198a2e0370734;
key256 = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
key_valid = 1;
data_valid = 1;
start = 1;
#10;
start = 0; key_valid = 0; data_valid = 0;
#30;

// Step 2
in = 128'h00112233445566778899aabbccddeeff;
key_valid = 1; data_valid = 1; start = 1;
#10;
start = 0; key_valid = 0; data_valid = 0;
#30;

// Step 3
in = 128'h00000000000000000000000000000000;
key_valid = 1; data_valid = 1; start = 1;
#10;
start = 0; key_valid = 0; data_valid = 0;
#30;

// Step 4
in = 128'h00000000000000000000000000000001;
key_valid = 1; data_valid = 1; start = 1;
#10;
start = 0; key_valid = 0; data_valid = 0;
#30;

// ===== After this step, Trojan should be active =====

        $finish;
    end

endmodule
