module full_subtractor(
	input i_bit1, 
	input i_bit2, 
	input i_bin, 
	output o_out, 
	output o_bout
);

	wire w_in1;
	wire w_in2;
	wire w_bin;
		
	assign w_in1 = (i_bit1 ^ i_bit2); 
	assign w_in2 = ~w_in1 & i_bin;
	assign w_bin = ~i_bit1 & i_bit2;

	assign o_out = (w_in1 ^ i_bin);
	assign o_bout = (w_in2 | w_bin);

endmodule 

// N-bit ripple_substractor 

module ripple_subtractor #(parameter N = 8) (
	input[N-1:0] a,
	input[N-1:0] b,
	input initial_bin,
	
	output bout,
	output[N-1:0] diff
);

wire[N:0] borrow;
assign borrow[0] = initial_bin;

genvar i;

generate 
		for(i = 0; i < N; i = i + 1) begin : sub_stage 
				full_subtractor UUT (
					.i_bit1(a[i]), .i_bit2(b[i]), .i_bin(borrow[i]),
					.o_out(diff[i]), .o_bout(borrow[i + 1])
				);
		end
endgenerate 

assign bout = borrow[N];

endmodule 