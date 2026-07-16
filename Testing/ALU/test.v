module testing;
    reg [7:0] a, b;
    reg [2:0] s;
    reg cin;
    wire [7:0] r;
    wire cout;

    reg [8:0] expected;
    integer i, j, k;
    integer errors;

    ALU UUT (.a(a), .b(b), .cin(cin), .s(s), .r(r), .cout(cout));

    wire [7:0] ref_sum, ref_diff, ref_and, ref_xor, ref_or, ref_shift;
    wire ref_cout, ref_bout;

    ripple_adder_8_bit ref_add (.a(a), .b(b), .cin(cin), .out(ref_sum), .cout(ref_cout));
    ripple_subtractor  ref_sub (.a(a), .b(b), .initial_bin(cin), .diff(ref_diff), .bout(ref_bout));
    and_8 ref_and8 (.a(a), .b(b), .out(ref_and));
    xor_8 ref_xor8 (.a(a), .b(b), .out(ref_xor));
    or_8  ref_or8  (.a(a), .b(b), .out(ref_or));
    shift_register ref_shift_reg (.a(a), .b(b), .dir(cin), .out(ref_shift));

    always @(*) begin
        case (s)
            3'b000: expected = {ref_cout, ref_sum};
            3'b001: expected = {ref_bout, ref_diff};
            3'b010: expected = {1'b0, ref_and};
            3'b011: expected = {1'b0, ref_xor};
            3'b100: expected = {1'b0, ref_or};
            3'b101: expected = {1'b0, ref_shift};
            default: expected = 9'bx;
        endcase
    end

    initial begin
        errors = 0;
        for (i = 0; i <= 5; i = i + 1) begin
            s = i;
            for (j = 0; j <= 255; j = j + 1) begin
                a = j;
                for (k = 0; k <= 511; k = k + 1) begin
                    {b, cin} = k;
                    #10;
                    if ({cout, r} !== expected) begin
                        $display("Error at inputs a=%b b=%b s=%b: expected=%b got=%b", a, b, s, expected, {cout, r});
                        errors = errors + 1;
                    end
                end
            end
        end
        $display("Total errors: %d", errors);
    end
endmodule
