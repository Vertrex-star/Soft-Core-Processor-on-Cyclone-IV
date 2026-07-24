module count #(parameter int inc)(input[7:0] count, output[7:0] countNext);

reg[7:0] r_countrNex;

always @(count) begin
	r_countNext = count + inc; 
end

assign countNext = r_countNext;

endmodule 
