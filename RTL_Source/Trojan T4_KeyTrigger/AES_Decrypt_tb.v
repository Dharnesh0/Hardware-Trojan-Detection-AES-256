module AES_Decrypt_tb;

reg [127:0] in3;
wire [127:0] out3;
reg [255:0] key3;


AES_Decrypt #(256,14,8) c(in3,key3,out3);


initial begin

$monitor("in256= %h, key256= %h ,out256= %h",in3,key3,out3);
in3=128'h8ea2b7ca516745bfeafc49904b496089;
key3=256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
#10;
end

endmodule