module and_8 (
	input[7:0] a,
	input[7:0] b,
	output[7:0] out
);  

assign out = a & b;

endmodule 

module xor_8 (
	input[7:0] a,
	input[7:0] b,
	output[7:0] out
);

assign out = a ^ b;

endmodule

module or_8 (
	input[7:0] a,
	input[7:0] b,
	output[7:0] out
);

assign out = a | b;

endmodule  

module shift_register (
	input[7:0] a,
	input[7:0] b,
	input dir,
	output[7:0] out
);

assign out = dir ? (a >> b) : (a << b);
endmodule 