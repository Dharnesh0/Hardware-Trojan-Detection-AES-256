module AES_Encrypt_tb;

reg [127:0] in3;
wire [127:0] out3;
reg [255:0] key3;


AES_Encrypt #(256,14,8) c(in3,key3,out3);


initial begin

$monitor("in256= %h, key256= %h ,out256= %h",in3,key3,out3);
in3=128'h_00112233_44556677_8899aabb_ccddeeff;
key3=256'h_00010203_04050607_08090a0b_0c0d0e0f_10111213_14151617_18191a1b_1c1d1e1f;
#10;
end

endmodule