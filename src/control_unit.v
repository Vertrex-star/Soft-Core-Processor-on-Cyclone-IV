modmodule control_unit (
	input [3:0] op_code,

	output regWrite,
	output [2:0] aluCtrl,
	output aluSrc,
	output branch,
	output memWrite,
	output memToReg
);

reg r_regWrite;
reg [2:0] r_aluCtrl;
reg r_aluSrc;
reg r_branch;
reg r_memWrite;
reg r_memToReg;

parameter op_and  = 4'b0000;
parameter op_or   = 4'b0001;
parameter op_add  = 4'b0010;
parameter op_sub  = 4'b0011;
parameter op_andi = 4'b0100;
parameter op_ori  = 4'b0101;
parameter op_addi = 4'b0110;
parameter op_beq  = 4'b0111;
parameter op_lw   = 4'b1000;
parameter op_sw   = 4'b1001;

parameter alu_and = 3'b000;
parameter alu_or  = 3'b001;
parameter alu_add = 3'b010;
parameter alu_sub = 3'b110;

always @(*) begin
	case (op_code)
		op_and: begin
			r_regWrite = 1;
			r_aluCtrl  = alu_and;
			r_memToReg = 0;
			r_memWrite = 0;
			r_branch   = 0;
			r_aluSrc   = 0;
		end

		op_or: begin
			r_regWrite = 1;
			r_aluCtrl  = alu_or;
			r_memToReg = 0;
			r_memWrite = 0;
			r_branch   = 0;
			r_aluSrc   = 0;
		end

		op_add: begin
			r_regWrite = 1;
			r_aluCtrl  = alu_add;
			r_memToReg = 0;
			r_memWrite = 0;
			r_branch   = 0;
			r_aluSrc   = 0;
		end

		op_sub: begin
			r_regWrite = 1;
			r_aluCtrl  = alu_sub;
			r_memToReg = 0;
			r_memWrite = 0;
			r_branch   = 0;
			r_aluSrc   = 0;
		end

		op_andi: begin
			r_regWrite = 1;
			r_aluCtrl  = alu_and;
			r_memToReg = 0;
			r_memWrite = 0;
			r_branch   = 0;
			r_aluSrc   = 1;
		end

		op_ori: begin
			r_regWrite = 1;
			r_aluCtrl  = alu_or;
			r_memToReg = 0;
			r_memWrite = 0;
			r_branch   = 0;
			r_aluSrc   = 1;
		end

		op_addi: begin
			r_regWrite = 1;
			r_aluCtrl  = alu_add;
			r_memToReg = 0;
			r_memWrite = 0;
			r_branch   = 0;
			r_aluSrc   = 1;
		end

		op_beq: begin
			r_regWrite = 0;
			r_aluCtrl  = alu_sub;
			r_memToReg = 0;
			r_memWrite = 0;
			r_branch   = 1;
			r_aluSrc   = 0;
		end

		op_lw: begin
			r_regWrite = 1;
			r_aluCtrl  = alu_add;
			r_memToReg = 1;
			r_memWrite = 0;
			r_branch   = 0;
			r_aluSrc   = 1;
		end

		op_sw: begin
			r_regWrite = 0;
			r_aluCtrl  = alu_add;
			r_memToReg = 0;
			r_memWrite = 1;
			r_branch   = 0;
			r_aluSrc   = 1;
		end

		default: begin
			r_regWrite = 0;
			r_aluCtrl  = alu_add;
			r_memToReg = 0;
			r_memWrite = 0;
			r_branch   = 0;
			r_aluSrc   = 0;
		end

	endcase
end

assign aluCtrl   = r_aluCtrl;
assign regWrite  = r_regWrite;
assign aluSrc    = r_aluSrc;
assign branch    = r_branch;
assign memWrite  = r_memWrite;
assign memToReg  = r_memToReg;

endmodule
