`timescale 1ns / 1ps
module full_Adder_4(
    output c_out,
    output sum[3:0],
    input  a[3:0],
    input  b[3:0],
    input  c_in
    );

    input	   a, b, c_in; //declare inputs a, b and c_in, 1 bit each
    output	   c_out, sum; //declare outputs c_out and sum, 1 bit each

    //declare wire
    wire       c[2:0];

    //instantiate Adders
    full_Adder add0(c[0],  sum[0], a[0], b[0], c_in);
    full_Adder add1(c[1],  sum[1], a[1], b[1], c[0]);
    full_Adder add2(c[2],  sum[2], a[2], b[2], c[1]);
    full_Adder add3(c_out, sum[3], a[3], b[3], c[2]);

endmodule

