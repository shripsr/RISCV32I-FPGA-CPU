module alu_conntrol(
	input logic [2:0] func3,
	input logic [6:0] func7,
	output logic [1:0]  log_fn,
	output logic add_sub,
	output logic [4:0] shift_count,
	output logic [1:0] shift_fn,
	output logic mux1_sel,
	output logic [1:0] mux2_sel
)

	localparam mux1_adder = 1'b0;
	localparam mux1_shift = 1'b1;
	localparam mux2_altb = 2'b00;
	localparam mux2_altbu = 2'b01;
	localparam mux2_add_shift = 2'b10;
	localparam mux2_logic = 2'b11;
	
	always_comb begin
		log_fn = 2'b00;
		add_sub = 1'b0;
		shift_countt = 5'b00000;
		shift_fn = 2'b00;
		mux1_sel = mux1_adder;
		mux2_sel = mux2_altb;
		
		case(func3)
			3'b000: begin //add and sub
				mux1_sel = mux1_adder
				add_sub = func7[5];
				mux2_sel = mux2_add_shift;
			end
			
			3'b001: begin //sll
				mux1_sel = mux1_shift;
				shift_fn = 2'b00;
				mux2_sel = mux2_add_shift;
			end
			
			3'b010: begin //slt
				mux2_sel = mux2_altb;
				add_sub = 1'b1;
			end
			
			3'b011: begin //slt
				mux2_sel = mux2_altbu;
				add_sub = 1'b1;
			end
			
			3'b100: begin //xor
				mux2_sel = mux2_logic;
				log_fn = 2'b00;
			end			
				
			3'b101: begin //srl and sra
				mux2_sel = mux2_add_shift;
				shift_fn = funct7[5] ? 2'b10 : 2'b01; // 0 = srl, 1 = sra
			end

			3'b100: begin //or
				mux2_sel = mux2_logic;
				log_fn = 2'b01;
			end

			3'b100: begin //and
				mux2_sel = mux2_logic;
				log_fn = 2'b11;
			end

			default: begin
				mux1_sel = mux1_adder;
				log_fn   = 2'b00;
				add_sub  = 1'b0;
				shift_fn = 2'b00;
				mux2_sel = 3'b000;
         end
		endcase
	end
endmodule
			
			
			
	