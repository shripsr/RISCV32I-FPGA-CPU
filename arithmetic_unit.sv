module arithmetic_unit(
	input logic [31:0] a,
	input logic [31:0] b,
	input logic add_sub, //0 for add, 1 for sub
	output logic [31:0] sum,
	output logic zero,    // High if result == 0 (BEQ / BNE)
   output logic altb,    // High if A < B (Signed: SLT, BLT, BGE)
   output logic altbu    // High if A < B (Unsigned: SLTU, BLTU, BGEU)
);

	logic [31:0] sign_b;
	logic cout;
	logic ovfl;
	
	assign sign_b = add_sub ? ~b : b;
	
	assign {cout, sum} = a + sign_b + add_sub;
	
	assign ovfl = (a[31] == sign_b[31]) && (sum[31] != a[31]);
	
	assign zero = (sum == 32'b0);
	
	assign altbu = ~cout;
	
	assign altb = sum[31] ^ ovfl;
	
endmodule
