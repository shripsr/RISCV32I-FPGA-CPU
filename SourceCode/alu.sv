module alu(
	input logic [31:0] a,
	input logic [31:0] b,
	
	input logic [1:0] log_fn,
	input logic add_sub,
	input logic [4:0] shift_count,
	input logic [1:0] shift_fn,
	input logic [1:0] mux1_sel,
	input logic [2:0] mux2_sel,
	
	output logic zero,    // High if result == 0 (BEQ / BNE)
   output logic altb,    // High if A < B (Signed: SLT, BLT, BGE)
   output logic altbu,
	output logic [31:0] alu_out
);

	logic [31:0] adder_out;
	logic [31:0] log_out;
	logic [31:0] shift_out;
	logic [31:0] mux1_out;
	
    arithmetic_unit arith_inst (
        .a (a),
        .b (b),
        .add_sub (add_sub),
        .sum (adder_out),
        .zero (zero),
        .altb (altb),
        .altbu (altbu)
    );

    logic_unit logic_inst (
        .a (a),
        .b (b),
        .log_fn (log_fn),
        .log_out (log_out)
    );

    shift_unit shift_inst (
        .a (a),
        .shift_count (b[4:0]),
        .shift_fn (shift_fn),
        .shift_out (shift_out)
    );
	 
	always_comb begin
		case (mux1_sel)
			1'b0: mux1_out = adder_out;
			1'b1:    mux1_out = shift_out;  // Shifter output
         default: mux1_out = 32'b0;
		endcase
	end
	
	always_comb begin
		case(mux2_sel)
			2'b00:   alu_out = {31'b0, altb}; 
         2'b01:   alu_out = {31'b0, altbu}; 
         2'b10:   alu_out = mux1_out;     
         2'b11:   alu_out = log_out;    
         default: alu_out = 32'b0;
		endcase
	end
	
endmodule
			
			