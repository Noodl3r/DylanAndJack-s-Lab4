`timescale 1ns / 1ns
`define D 1
module FA64_tb;
	// Inputs
	reg [63:0] a;
	reg [63:0] b;
	reg c_in;
	
	reg clk;
	// Outputs - RC adder
	wire        c_out_rc;
	wire [63:0] s_rc;
	// Outputs - CS adder
	wire        c_out_cs;
	wire [63:0] s_cs;
	// Verification outputs
	wire        c_out_verify;
	wire [63:0] s_verify;
	// Error flags
	wire error_rc;
	wire error_cs;
	
	// Instiatiating both modules in the same file to compare them with each other more easily. 
	// Instantiate Ripple-Carry 64-bit adder
	full_Adder_64RC RC (
		.c_out(c_out_rc),
		.s    (s_rc),
		.a    (a),
		.b    (b),
		.c_in (c_in)
	);
	
	// Instantiate Carry-Select 64-bit adder
	full_Adder_64CS CS (
		.c_out(c_out_cs),
		.s    (s_cs),
		.a    (a),
		.b    (b),
		.c_in (c_in)
	);
	
	// Verification module - c_in is folded into a so the 64-bit
	// reference port still produces the correct {c_out, s} result
	wire [63:0] a_cin = a + {63'b0, c_in};
	VERIFY_FA_PARAM #(.WIDTH(64)) Verification (
		.c_out(c_out_verify),
		.s    (s_verify),
		.a    (a_cin),
		.b    (b)
	);
	
	// Assign error flags
	assign error_rc = (c_out_rc != c_out_verify || s_rc != s_verify);
	assign error_cs = (c_out_cs != c_out_verify || s_cs != s_verify);
	
	// Verification logic - Essentially ripped from prelab
	always@(posedge clk)
		begin
		if(error_rc)

			$display("RC Error: a = %h, b = %h, c_in = %b", a, b, c_in);
		if(error_cs)
			$display("CS Error: a = %h, b = %h, c_in = %b", a, b, c_in);
		end
	
	// Define clk signal for verification purpose
	always #5 clk = ~clk;
	initial begin
		// Initialize inputs
		clk  = 0;
		a    = 64'h0;
		b    = 64'h0;
		c_in = 0;
		
		// --- Force overall carry-out ---    --- Test cases generated with AI because it's otherwise incredibly tedious
		@(posedge clk); a = 64'hFFFFFFFFFFFFFFFF; b = 64'h0000000000000001; c_in = 0;
		@(posedge clk); a = 64'hFFFFFFFFFFFFFFFF; b = 64'hFFFFFFFFFFFFFFFF; c_in = 0;
		@(posedge clk); a = 64'h8000000000000000; b = 64'h8000000000000000; c_in = 0;
		// ? @(posedge clk); a = 64'hFFFFFFFFFFFFFFFF; b = 64'hFFFFFFFFFFFFFFFF; c_in = 1;
		
		// --- Large A & B, without carry-in ---
		@(posedge clk); a = 64'hDEADBEEFCAFEBABE; b = 64'h0123456789ABCDEF; c_in = 0;
		@(posedge clk); a = 64'hFEDCBA9876543210; b = 64'hABCDEF0123456789; c_in = 0;
		@(posedge clk); a = 64'h7FFFFFFFFFFFFFFF; b = 64'h7FFFFFFFFFFFFFFF; c_in = 0;
		
		// --- Large A & B, with carry-in ---
		@(posedge clk); a = 64'hDEADBEEFCAFEBABE; b = 64'h0123456789ABCDEF; c_in = 1;
		@(posedge clk); a = 64'hFEDCBA9876543210; b = 64'hABCDEF0123456789; c_in = 1;
		@(posedge clk); a = 64'h7FFFFFFFFFFFFFFF; b = 64'h7FFFFFFFFFFFFFFF; c_in = 1;
		
		// --- Small A & B, without carry-in ---
		@(posedge clk); a = 64'h0000000000000003; b = 64'h0000000000000005; c_in = 0;
		@(posedge clk); a = 64'h000000000000000F; b = 64'h0000000000000001; c_in = 0;
		@(posedge clk); a = 64'h0000000000000000; b = 64'h0000000000000000; c_in = 0;
		
		// --- Small A & B, with carry-in ---
		@(posedge clk); a = 64'h0000000000000003; b = 64'h0000000000000005; c_in = 1;
		@(posedge clk); a = 64'h000000000000000F; b = 64'h0000000000000001; c_in = 1;
		@(posedge clk); a = 64'h0000000000000000; b = 64'h0000000000000000; c_in = 1;

		// --- Random combinations ---
		// Checkerboard patterns - stresses alternating carry chains
		@(posedge clk); a = 64'hAAAAAAAAAAAAAAAA; b = 64'h5555555555555555; c_in = 0;
		@(posedge clk); a = 64'hAAAAAAAAAAAAAAAA; b = 64'h5555555555555555; c_in = 1;
		// Long carry ripple
		@(posedge clk); a = 64'h0FFFFFFFFFFFFFFF; b = 64'h0000000000000001; c_in = 0;
		// Asymmetric operands
		@(posedge clk); a = 64'hFFFFFFFF00000000; b = 64'h0000000000000001; c_in = 0;
		@(posedge clk); a = 64'h00000000FFFFFFFF; b = 64'h0000000000000001; c_in = 1;
		@(posedge clk); a = 64'h123456789ABCDEF0; b = 64'hFEDCBA9876543210; c_in = 1;
		
		#10 $finish;
	end
      
endmodule
