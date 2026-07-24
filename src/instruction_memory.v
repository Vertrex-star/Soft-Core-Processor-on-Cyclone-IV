module instruction_memory 
(
	input wr,
	input rd,
	input[23:0] i_instructions,
	input[7:0] PC, 
	input clk,
	output[23:0] o_instructions
);

reg [23:0] mem [7:0];
reg [23:0] out;

integer N = 0;

always @(posedge clk) begin 
	if (wr == 1'b1 && ~rd && ~(i_instructions == 0) && N < 8) begin
		mem[N] <= i_instructions;
		N <= N + 1;
		end
	end 
	else if (rd == 1'b1 && ~wr) begin 
		out <= mem[PC-1];
		mem[PC - 1] = 0;
	end
end

assign o_instructions = out;
									
endmodule
