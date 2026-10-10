module logic_unit(
	input logic [31:0] a,
	input logic [31:0] b,
	input logic [1:0] log_fn,
	output logic [31:0] log_out
);

	typedef enum logic [1:0]{
		OP_XOR = 2'b00,
		OP_OR = 2'b01,
		OP_AND = 2'b10
	}logic_op_e;
	
	always_comb begin
	
		case (log_fn)
		
			OP_XOR:  log_out = a ^ b;
         OP_OR:   log_out = a | b;
         OP_AND:  log_out = a & b;
			default: log_out = 32'b0;
		endcase
		
	end
	
endmodule
	
