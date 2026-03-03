module mux_32(
    output q[31:0],
    input  a[31:0],
    input  b[31:0],
    input  sel
    );

    always @(*) begin
        q = (sel ? a : b);
    end
endmodule


