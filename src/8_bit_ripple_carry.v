// 1 bit adder
module full_adder(i_bit1, i_bit2, i_cin, o_out, o_cout);
	input i_bit1, i_bit2, i_cin;
	output o_out, o_cout;

	wire w_in1;
	wire w_in2;
	wire w_cin;
		
	assign w_in1 = (i_bit1 ^ i_bit2); 
	assign w_in2 = w_in1 & i_cin;
	assign w_cin = i_bit1 & i_bit2;

	assign o_out = (w_in1 ^ i_cin);
	assign o_cout = (w_in2 | w_cin);
		
endmodule 

// 8 bit adder
module ripple_adder_8_bit #(parameter N = 8) (
	input[N-1:0] a,
	input[N-1:0] b,
	input cin,
	
	output[N-1:0] out,
	output cout
);

wire[N:0] carry;
assign carry[0] = cin;

genvar i;

generate 
	for (i = 0; i < N; i = i + 1) begin: gen_block
			full_adder FA(
				.i_bit1(a[i]),
				.i_bit2(b[i]),
				.i_cin(carry[i]),
				.o_cout(carry[i+1]),
				.o_out(out[i])
			);
	end
endgenerate 

assign cout = carry[N];

endmodule 


