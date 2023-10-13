module riscv_decoder (opcode, funct3, funct7, MemtoReg, MemWrite, Branch, ALUControl, ALUsrc, RegDst, RegWrite,LSen,imm_src,Jump,jal_enn);
    input [6:0] opcode;
    input [2:0] funct3;
    input [6:0] funct7;
    output reg [1:0] MemtoReg;
    output reg  MemWrite, Branch, ALUsrc, RegDst, RegWrite;
    output reg [3:0] ALUControl;
    output reg [2:0] LSen;
    output reg [1:0]imm_src;
    output reg Jump;
    output reg jal_enn;

    wire [1:0] ALUop;

    controller controller (
        .opcode(opcode),
        .funct3(funct3),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUop(ALUop),
        .ALUsrc(ALUsrc),
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .LSen(LSen),
        .immSrc(imm_src),
        .jump(Jump),
        .jal_en(jal_enn)
    );

    aludc aludc (
        .ALUop(ALUop),
        .funct3(funct3),
        .funct7(funct7),
        .ALUcontrol(ALUControl)
    );


endmodule