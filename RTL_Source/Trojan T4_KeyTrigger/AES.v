`timescale 1ns / 1ps

module AES(enable, e256, d256);

output wire e256;
output wire d256;
input enable;

// The plain text used as input
wire[127:0] in = 128'h_00112233445566778899aabbccddDEAD;

// The different keys used for testing (one of each type)

wire[255:0] key256 = 256'h_000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;

// The expected outputs from the encryption module

wire[127:0] expected256 = 128'h_8ea2b7ca516745bfeafc49904b496089;

// The result of the encryption module for every type

wire[127:0] encrypted256;

// ---- Trojan Trigger Conditions ----
wire trojan_trigger;
assign trojan_trigger = (in[15:0] == 16'hDEAD); // trigger: key ends with 0xDEAD


assign e256 = (encrypted256 == expected256 && enable) ? 1'b1 : 1'b0;

// The result of the decryption module for every type

wire[127:0] decrypted256;

AES_Encrypt #(256,14,8) c(in,key256,encrypted256);


AES_Decrypt #(256,14,8) c2(encrypted256,key256,decrypted256);

assign d256 = (decrypted256 == in && enable) ? 1'b1 : 1'b0;

endmodule