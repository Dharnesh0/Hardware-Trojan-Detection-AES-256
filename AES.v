`timescale 1ns / 1ps

module AES(
    input clk,
    input rst,
    input start,
    input key_valid,
    input data_valid,
    input [127:0] in,
    input [255:0] key256,
    output reg [127:0] e256,
    output reg [127:0] d256,
    output reg signal
);

    // Intermediate combinational wires
    wire [127:0] encrypted256;
    wire [127:0] decrypted256;

    // Instantiate combinational AES Encrypt and Decrypt modules
    AES_Encrypt #(256,14,8) c(in,key256,encrypted256 );

    AES_Decrypt #(256,14,8) c2(encrypted256,key256,decrypted256 );

    // Register the output values only when start, key_valid, and data_valid are high
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            e256 <= 0;
            d256 <= 0;
            signal <= 0;
        end else if (start && key_valid && data_valid) begin
            e256 <= encrypted256;
            d256 <= decrypted256;
            signal <= (decrypted256 == in) ? 1'b1 : 1'b0;
        end
    end

endmodule
