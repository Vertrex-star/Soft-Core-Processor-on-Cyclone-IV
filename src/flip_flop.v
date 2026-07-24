module flip_flop (input a, input clk, output b);
reg out = 0;

always @(posedge clk) begin 
	out <= a;
end

assign b = out; 

endmodule 