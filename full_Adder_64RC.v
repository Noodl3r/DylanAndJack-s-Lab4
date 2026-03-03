module full_Adder_64RC(
    output c_out,
    output s[63:0],
    input  a[63:0],
    input  b[63:0],
    input  c_in
    );

    // Generate wire
    wire c;

    // Instantiate
    full_Adder_32 FA32_1(c, s[31:0], a[31:0], b[31:0], c_in);
    full_Adder_32 FA32_2(c_out, s[63:32], a[63:32], b[63:32], c);

endmodule
