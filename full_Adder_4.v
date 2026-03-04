`timescale 1ns / 1ps
module full_Adder_4(
    output c_out,
    output [3:0]sum,
    input [3:0]a,
    input [3:0]b,
    input  c_in
    );
    
    //declare wire
    wire       [2:0]c;

    //instantiate Adders
    full_Adder add0(c[0],  sum[0], a[0], b[0], c_in);
    full_Adder add1(c[1],  sum[1], a[1], b[1], c[0]);
    full_Adder add2(c[2],  sum[2], a[2], b[2], c[1]);
    full_Adder add3(c_out, sum[3], a[3], b[3], c[2]);

endmodule

