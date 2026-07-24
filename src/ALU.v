module ALU (
    input  [7:0] a,
    input  [7:0] b,        
    input  [2:0] s,
    output reg [7:0] r,
    output reg       cout
);

    wire [7:0] b_selected = s[2] ? ~b : b;
    wire       add_cin    = s[2] ? 1'b1 : 1'b0;  
    wire [8:0] add_result;   

    ripple_adder_8_bit adder (
        .a   (a),
        .b   (b_selected),
        .cin (add_cin),
        .out (add_result[7:0]),
        .cout(add_result[8])
    );

    always @(*) begin
        case (s)
            3'b010: {cout, r} = add_result;          // ADD
            3'b110: {cout, r} = add_result;          // SUB
            3'b000: {cout, r} = {1'b0, a & b};      // AND
            3'b001: {cout, r} = {1'b0, a | b};      // OR
            default:{cout, r} = 9'b0;
        endcase
    end

endmodule