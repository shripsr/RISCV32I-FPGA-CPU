module shift_unit(
	input logic [31:0] a,
	input logic [4:0] shift_count,
	input logic [1:0] shift_fn,
	output logic [31:0] shift_out
);

	typedef enum logic [1:0]{
		SHIFT_SLL = 2'b00,
		SHIFT_SRL = 2'b01,
		SHIFT_SRA = 2'b10
	}logic_op_e;

	always_comb begin
	
		case (shift_fn)
		
			SHIFT_SLL: shift_out = a << shift_count;
         SHIFT_SRL: shift_out = a >> shift_count;
         SHIFT_SRA: shift_out = $signed(a) >>> shift_count;
			default: shift_out = 32'b0;
		endcase
		
	end
	
endmodule
