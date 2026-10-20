module  control_unit(
	input logic [6:0]  opcoode,
	
	output logic reg_write,
	output logic alu_src,
	output logic mem_to_reg,
	output logic mem_read,
	output logic mem_write,
	output logic branch,
	output logic jump,
	output logic ecall,
   output logic ebreak    
);

	always_comb begin
		reg_write = 1'b0;
		alu_src = 1'b0;
		mem_to_reg = 1'b0;
		mem_read = 1'b0;
		mem_write = 1'b0;
		branch = 1'b0;
		jump = 1'b0;
		ecall = 1'b0;
      ebreak = 1'b0;
		
		case (opcode)
			7'b0110011: begin //r type
				reg_write = 1'b1;
				alu_src = 1'b0;
			end
			
			7'b0010011: begin //i type
				reg_write = 1'b1;
				alu_src = 1'b1;
			end
			
			7'b0000011: begin //i type load
				reg_write = 1'b1;
				alu_src = 1'b1;
				mem_to_reg = 1'b1;
				mem_read = 1'b1;
			end
			
			7'b0100011: begin //s type
				alu_src = 1'b1;
				mem_write = 1'b1;
			end
			
			7'b1100011: begin //branch
				branch = 1'b1;
				alu_src = 1'b0;
			end
			
			7'b1101111: begin //jal
				jump = 1'b1;
				reg_write = 1'b1;
			end
			
			7'b1100111: begin //jalr
				reg_write = 1'b1;
            alu_src = 1'b1;
            jump = 1'b1;
			end
			
			7'b0110111, // LUI
         7'b0010111: begin // AUIPC
				reg_write = 1'b1;
				alu_src   = 1'b1;
         end
			
			7'b1110011: begin //ecall ebreak
				if (imm_12 == 12'h000) begin
					ecall  = 1'b1; 
            end else if (imm_12 == 12'h001) begin
               ebreak = 1'b1; 
            end
         end
			
			default: ;
			
		endcase	
	end
endmodule
			
			
						