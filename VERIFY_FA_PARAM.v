module VERIFY_FA_PARAM #(parameter WIDTH = 32)(
    output c_out,
    output [WIDTH-1:0] s,
    input  [WIDTH-1:0] a,
    input  [WIDTH-1:0] b
);
    // Directly assign
    assign {c_out, s} = a + b;
endmodule
