//module single_cycle_mycode(input wire clk,rst,
//            output reg [31:0] PC_Top,PCPlus4,instra,read1,read2,result_val,
//            output reg Zero,regwrite,
//            output reg [3:0] alucontrol,
//            output reg [4:0]write_reg,
//            output reg [31:0] extended,
//            output reg [31:0] ALUsrc_val,    
//            output reg [31:0] ALU_out,
//            output reg [2:0] LSen,
//            output reg [31:0] MEM_data,
//            output reg [1:0] Immsrc,
//            output reg [31:0] Added_Branch,
//            output reg branch_1,
//            output reg [31:0] PCnext,
//            output reg Jump,
//            output reg [31:0] After_Branch,
//            output reg [31:0] Shifted_jump,
//            output reg [31:0] ALUsrc_1,
//            output reg [31:0] PC_jal
//            );

 module single_cycle_mycode(clk,rst);

     input wire clk,rst;
     wire [31:0] result_val;//     output reg [31:0] result_val;

     wire [31:0] PC_Top,PCPlus4,instra,read1,read2,extended,ALUsrc_val,ALU_out,MEM_data,Added_Branch,PCnext,After_Branch,Shifted_jump,ALUsrc_1,PC_jal;
     wire Zero,regwrite,branch_1,Jump;
     wire [3:0] alucontrol;
     wire [4:0]write_reg;
     wire [2:0] LSen;
     wire [1:0] Immsrc;

    wire ALUsrc,RegDst,memWrite;
    wire [1:0]MemtoReg;
    
    wire [31:0] Read_data;
    wire [31:0] ALUorMEM;
    wire [31:0] Shifted;
    wire Branch,jal_en;


    pc pc1(
        .rst(rst),
        .clk(clk),
        .PC_Next(PCnext),
        .PC(PC_Top)
    );
    
    adder_32 adder_321(
        .a(PC_Top),
        .b(32'h4),
        .y(PCPlus4)
    );

    InstructionMemory InstructionMemory1(
        .clk(clk),
        .rst(rst),
        .address(PC_Top),
        .instruction(instra)
    );

    Mux_5bit Mux_5bit1(
        .a(instra[11:7]),
        .b(instra[24:20]),
        .s(RegDst),
        .c(write_reg)
    );

    Register_File Register_File1(
        .clk(clk),
        .read_reg1(instra[19:15]),
        .read_reg2(instra[24:20]),
        .write_reg(write_reg),
        .write_data(result_val),
        .write_enable(regwrite),
        .read_data1(read1),
        .read_data2(read2)
    );

    riscv_alu riscv_alu1(
        .A(ALUsrc_1),
        .B(ALUsrc_val),
        .ALUcontrol(alucontrol),
        .ALUResult(ALU_out),
        .Zero(Zero)
    );

    riscv_decoder riscv_decoder1(
        .opcode(instra[6:0]),
        .funct3(instra[14:12]),
        .funct7(instra[31:25]),
        .MemtoReg(MemtoReg),
        .MemWrite(memWrite),
        .Branch(Branch),
        .ALUControl(alucontrol),
        .ALUsrc(ALUsrc),
        .RegDst(RegDst),
        .RegWrite(regwrite),
        .LSen(LSen),
        .imm_src(Immsrc),
        .Jump(Jump),
        .jal_enn(jal_en)
    );

    SignExtend SignExtend1(
        .imm(instra[31:7]),
        .immSrc(Immsrc),
        .extended(extended)
    );

    Mux32bit Mux_ALUSrc(
        .a(extended),
        .b(read2),
        .s(ALUsrc),
        .c(ALUsrc_val)
    );

    data_memory data_memory1(
        .clk(clk),
        .address(ALU_out),
        .write_data(MEM_data),
        .write_enable(memWrite),
        .read_data(Read_data)
    );

    // Mux Mux_WriteData(
    //     .a(Read_data),
    //     .b(ALU_out),
    //     .s(MemtoReg),
    //     .c(ALUorMEM)
    // );

    mux_3to1_32bit mux_3to1_32bit1(
        .data0(ALU_out),
        .data1(Read_data),
        .data2(PCPlus4),
        .select(MemtoReg),
        .write_data_N(ALUorMEM)
    );

    LandS Load_en(                 //for load
        .LandS_en(LSen),
        .IN_Data(ALUorMEM),
        .out_Data(result_val)
    );

    LandS Store_en(                 //for store
        .LandS_en(LSen),
        .IN_Data(read2),
        .out_Data(MEM_data)
    );

    left_shifter left_shifter1(
        .shift_in(extended),
        .shift_out(Shifted)
    );

    adder_32 adder_322(
        .a(Shifted),
        .b(PC_Top),
        .y(Added_Branch)
    );

    Mux32bit Mux_PC(
        .a(Added_Branch),
        .b(PCPlus4),
        .s(branch_1),
        .c(After_Branch)
    );

    logic_and logic_and1(
        .a(Zero),
        .b(Branch),
        .y(branch_1)
    );

    left_shifter left_shifter2(
        .shift_in(ALU_out),
        .shift_out(Shifted_jump)
    );

    Mux32bit muxjump(
        .a(Shifted_jump),
        .b(After_Branch),
        .s(Jump),
        .c(PCnext)
    );

    Mux32bit muxjal(
        .a(PC_jal),
        .b(read1),
        .s(jal_en),
        .c(ALUsrc_1)
    );

    right_shifter right_shifter1(
        .shift_in(PC_Top),
        .shift_out(PC_jal)
    );





endmodule