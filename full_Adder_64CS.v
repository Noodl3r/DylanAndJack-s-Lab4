`timescale 1ns / 1ns
module full_Adder_64CS(
    output c_out,
    output [63:0]s,
    input  [63:0]a,
    input  [63:0]b,
    input  c_in
    );

    // First full Addder
    wire c;
    full_Adder_32 FA32_1(c, s[31:0], a[31:0], b[31:0], c_in);

    // Second half
    wire c1, c2;
    wire [31:0] s1,s2;
    full_Adder_32 FA32_2(c1, s1[31:0], a[63:32], b[63:32], 0);
    full_Adder_32 FA32_3(c2, s2[31:0], a[63:32], b[63:32], 1);

    mux_32  MUX_32(s[63:32], s2[31:0], s1[31:0], c);
    mux_1   MUX_1 (c_out,    c2,       c1,       c);


endmodule
