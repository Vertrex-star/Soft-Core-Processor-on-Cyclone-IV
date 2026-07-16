module ALU(
	input[7:0] a,
	input[7:0] b,
	input cin,
	input[2:0] s,
	
	output reg[7:0] r,
	output reg cout
);

	wire[8:0] r0;
	wire[8:0] r1;
	wire[7:0] r2;
	wire[7:0] r3;
	wire[7:0] r4;
	wire[7:0] r5;
	
	ripple_adder_8_bit M1 (
			.a(a), .b(b), .cin(cin), 
			.out(r0[7:0]), .cout(r0[8])
	);
	
	ripple_subtractor M2 (
			.a(a), .b(b), .initial_bin(cin), 
			.bout(r1[8]), .diff(r1[7:0])
	);
	
	and_8 M3 (
			.a(a), .b(b), .out(r2)
	);
	
	xor_8 M4(
			.a(a), .b(b), .out(r3)
	);
	
	or_8 M5(
			.a(a), .b(b), .out(r4)
	);
	
	shift_register M6(
			.a(a), .b(b), .dir(cin), 
			.out(r5)
	);
	
	always @(*) begin 
		case(s)
			3'b000: begin r = r0[7:0]; cout = r0[8]; end 
			3'b001: begin r = r1[7:0]; cout = r1[8]; end
			3'b010: begin r = r2; cout = 1'b0; end
			3'b011: begin r = r3; cout = 1'b0; end
			3'b100: begin r = r4; cout = 1'b0; end
			3'b101: begin r = r5; cout = 1'b0; end
			default: begin r = 8'b0; cout = 1'b0;  end
		endcase
	end
endmodule 