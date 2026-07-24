module mux_2_to_1 (input[7:0] a, input[7:0] b, input c, output[7:0] d);

assign d = c ? b : a;

endmodule 