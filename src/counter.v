module count #(parameter inc = 1)
	  (
	  input rst,
	  input[7:0] count, 
	  output[7:0] countNext  
	  );

reg[7:0] r_countNext;

always @(count) begin
	if(rst == 1) begin 
		r_countNext <= 0;
	end else begin 
	  r_countNext = count + inc;
	end
end

assign countNext = r_countNext;

endmodule 
