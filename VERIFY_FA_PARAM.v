module VERIFY_FA_PARAM #(parameter WIDTH = 32)(
    output c_out, 
    output s[WIDTH-1: 0],
    input  a[WIDTH-1: 0],
    input  b[WIDTH-1: 0],
    );
    //Directly assign
    assign s = a + b;

