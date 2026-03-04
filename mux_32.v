module mux_32(
    output reg [31:0] q,
    input [31:0] a,
    input [31:0] b,
    input  sel
    );

    always @(*) begin
        q = (sel ? a : b);
    end
endmodule
