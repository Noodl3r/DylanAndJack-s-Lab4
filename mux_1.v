module mux_1(
    output q,
    input  a,
    input  b,
    input  sel
    );

    always @(*) begin
        q = (sel ? a : b);
    end
endmodule


