module microprocessor
(
    input  [23:0] i_instructions,   
    input         clk,
    input         rd,             
    input         wrt,              
    input         rst,
    output [7:0]  alu              
);

    wire [23:0] Instr;
    wire        RegWrite, ALUSrc, Branch, MemWrite, MemtoReg;
    wire [2:0]  ALUControl;         
    wire [7:0]  RD1, RD2, SrcB, ALUResult;
    wire        Zero;
    wire        PCSrc;

    wire [7:0] PC, PCNext, PCPlus1;


	count #(.inc(1)) pc_adder (
    .rst       (rst),
    .count     (PC),
    .countNext (PCPlus1)
	);

    assign PCSrc = Branch & Zero;

    mux_2_to_1 pc_mux (
        .a   (PCPlus1),            
        .b   (Instr[7:0]),          
        .c   (PCSrc),
        .d   (PCNext)
    );

    flip_flop pc_reg (
        .a   (PCNext),
        .clk (clk),
        .b   (PC)                   
    );

    instruction_memory memI (
        .wr            (wrt),
        .rd            (rd),
        .i_instructions(i_instructions),
        .PC            (PC),
        .clk           (clk),
        .o_instructions(Instr)
    );

       control_unit control (
        .op_code   (Instr[23:20]), 
        .regWrite  (RegWrite),
        .aluCtrl   (ALUControl),
        .aluSrc    (ALUSrc),
        .branch    (Branch),
        .memWrite  (MemWrite),
        .memToReg  (MemtoReg)
    );

    wire [7:0] WD3;               

    reg_file regF (
        .clk      (clk),
        .A1       (Instr[15:12]),   
        .A2       (Instr[11:8]),    
        .A3       (Instr[19:16]),   
        .WD3      (WD3),
        .regWrite (RegWrite),
        .RD1      (RD1),
        .RD2      (RD2)
    );

    mux_2_to_1 alu_src_mux (
        .a (RD2),
        .b (Instr[7:0]),          
        .c (ALUSrc),
        .d (SrcB)
    );

    ALU alu_inst (
        .a    (RD1),               
        .b    (SrcB),
        .s    (ALUControl),
        .r    (ALUResult),
        .cout (),                   
        .zero (Zero)
    );

    assign alu = ALUResult;         

endmodule
