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

// 4 bit adder
module ripple_adder_4bit(
	input[3:0] a,
	input[3:0] b,
	input cin,
	output cout,
	output[3:0] sum
);

wire c0, c1, c2;

full_adder FA0(
	.i_bit1(a[0]), .i_bit2(b[0]), .i_cin(cin),
	.o_out(sum[0]), .o_cout(c0)
	);
	
full_adder FA1(
	.i_bit1(a[1]), .i_bit2(b[1]), .i_cin(c0),
	.o_out(sum[1]), .o_cout(c1)
	);
	
full_adder FA2(
	.i_bit1(a[2]), .i_bit2(b[2]), .i_cin(c1),
	.o_out(sum[2]), .o_cout(c2)
	);
	
full_adder FA3(
	.i_bit1(a[3]), .i_bit2(b[3]), .i_cin(c2),
	.o_out(sum[3]), .o_cout(cout)
	);
	
endmodule


// 8 bit adder
module ripple_adder_8_bit_test(
	input[7:0] a,
	input[7:0] b,
	output[7:0] out,
	input cin,
	output cout
);

wire c0;

ripple_adder_4bit FA0(
		.a(a[3:0]), .b(b[3:0]), .sum(out[3:0]), .cin(cin),
		.cout(c0)
	);
	
ripple_adder_4bit FA1(
		.a(a[7:4]), .b(b[7:4]), .sum(out[7:4]), .cin(c0),
		.cout(cout)
	);


endmodule 

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


