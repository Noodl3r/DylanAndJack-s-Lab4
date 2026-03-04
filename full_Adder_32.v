module full_Adder_32(
    output c_out,
    output [31:0]s,
    input  [31:0]a,
    input  [31:0]b,
    input  c_in
    );

    // Generate wires
    wire [6:0]c;

    // Instantiate full_adders
    full_Adder_4 FA4_1(c[0],  s[3:0],   a[3:0],   b[3:0],   c_in);
    full_Adder_4 FA4_2(c[1],  s[7:4],   a[7:4],   b[7:4],   c[0]);
    full_Adder_4 FA4_3(c[2],  s[11:8],  a[11:8],  b[11:8],  c[1]);
    full_Adder_4 FA4_4(c[3],  s[15:12], a[15:12], b[15:12], c[2]);
    full_Adder_4 FA4_5(c[4],  s[19:16], a[19:16], b[19:16], c[3]);
    full_Adder_4 FA4_6(c[5],  s[23:20], a[23:20], b[23:20], c[4]);
    full_Adder_4 FA4_7(c[6],  s[27:24], a[27:24], b[27:24], c[5]);
    full_Adder_4 FA4_8(c_out, s[31:28], a[31:28], b[31:28], c[6]);

endmodule
