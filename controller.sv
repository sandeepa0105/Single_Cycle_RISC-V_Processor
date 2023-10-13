module controller(opcode,funct3, MemtoReg, MemWrite, Branch, ALUop, ALUsrc, RegDst, RegWrite,LSen,immSrc,jump,jal_en);
    input [6:0] opcode;
    input [2:0] funct3;
    output reg [1:0] MemtoReg;
    output reg MemWrite, Branch, ALUsrc, RegDst, RegWrite;
    output reg [1:0] ALUop;
    output reg [2:0] LSen;
    output reg [1:0] immSrc;
    output reg jump;
    output reg jal_en;

    always @(*) begin
        // Initialize control signals to default values
        MemtoReg = 2'b00;
        MemWrite = 1'b0;
        Branch = 1'b0;
        ALUop = 2'b00;
        ALUsrc = 1'b0;
        RegDst = 1'b0;
        RegWrite = 1'b0;
        LSen = 3'b010;
        immSrc = 2'b00;
        jump = 1'b0;
        jal_en=1'b0;

        // Check the opcode to determine the instruction type
        case (opcode)
            // R-Type instructions
            7'b0110011: begin
                // Set control signals for R-type instructions
                MemtoReg = 2'b00;  // No memory-to-register write
                MemWrite = 1'b0;  // No memory write
                Branch = 1'b0;    // No branch
                ALUop = 2'b10;    // ALU operation for R-type
                ALUsrc = 1'b0;    // ALU source is from registers
                RegDst = 1'b1;    // Destination register is rd
                RegWrite = 1'b1;  // Enable register write
            end
            // Add more cases for other instruction types here

            // I-Type instructions
            7'b0010011: begin
                // Set control signals for I-type instructions
                MemtoReg = 2'b00;  // No memory-to-register write
                MemWrite = 1'b0;  // No memory write
                Branch = 1'b0;    // No branch
                ALUop = 2'b00;    // ALU operation for I-type
                ALUsrc = 1'b1;    // ALU source is from immediate
                RegDst = 1'b1;    // Destination register is rt
                RegWrite = 1'b1;  // Enable register write
            end
            //lw,lb,lbu,lh,lhu  
            7'b0000011: begin
                // Set control signals for I-type instructions
                MemtoReg = 2'b01;  // No memory-to-register write
                MemWrite = 1'b0;  // No memory write
                Branch = 1'b0;    // No branch
                ALUop = 2'b11;    // ALU operation for I-type
                ALUsrc = 1'b1;    // ALU source is from immediate
                RegDst = 1'b1;    // Destination register is rt
                RegWrite = 1'b1;  // Enable register write
                case(funct3)
                    3'b000: LSen = 3'b000; //LB
                    3'b001: LSen = 3'b001; //LH
                    3'b010: LSen = 3'b010; //LW
                    3'b100: LSen = 3'b011; //LBU
                    3'b101: LSen = 3'b100; //LHU
                    default: LSen = 3'b010;						  
                endcase

            end


            // S-Type instructions
            7'b0100011: begin
                // Set control signals for S-type instructions
                MemtoReg = 2'bxx;  // No memory-to-register write
                MemWrite = 1'b1;  // No memory write
                Branch = 1'b0;    // No branch
                ALUop = 2'b11;    // ALU operation for S-type
                ALUsrc = 1'b1;    // ALU source is from immediate
                RegDst = 1'bx;    // Destination register is rt
                RegWrite = 1'b0;  // Enable register write
                immSrc = 2'b01;    // Immediate source is from instruction
                case(funct3)
                    3'b000: LSen = 3'b000; //SB
                    3'b001: LSen = 3'b001; //SH
                    3'b010: LSen = 3'b010; //SW
                    default: LSen = 3'b010;
                endcase
            end

            // SB-Type instructions
            7'b1100011: begin
                // Set control signals for SB-type instructions
                MemtoReg = 2'bxx;  // No memory-to-register write
                MemWrite = 1'b0;  // No memory write
                Branch = 1'b1;    // No branch
                ALUop = 2'b01;    // ALU operation for SB-type
                ALUsrc = 1'b0;    // ALU source is from registers
                RegDst = 1'bx;    // Destination register is rt
                RegWrite = 1'b0;  // Enable register write
                immSrc = 2'b10;    // Immediate source is from instruction
                
            end

            // jalr-Type instructions
            7'b1100111: begin
                // Set control signals for U-type instructions
                MemtoReg = 2'b10;  // No memory-to-register write
                MemWrite = 1'b0;  // No memory write
                Branch = 1'bx;    // No branch
                ALUop = 2'bxx;    // ALU operation for U-type
                ALUsrc = 1'b1;    // ALU source is from immediate
                RegDst = 1'b1;    // Destination register is rd
                RegWrite = 1'b1;  // Enable register write
                jump = 1'b1;
                immSrc = 2'b00;
            end

            // jal Type instructions
            7'b1101111: begin
                // Set control signals for U-type instructions
                MemtoReg = 2'b10;  // No memory-to-register write
                MemWrite = 1'b0;  // No memory write
                Branch = 1'bx;    // No branch
                ALUop = 2'bxx;    // ALU operation for U-type
                ALUsrc = 1'b1;    // ALU source is from immediate
                RegDst = 1'b1;    // Destination register is rd
                RegWrite = 1'b1;  // Enable register write
                jump = 1'b1;
                jal_en=1'b1;
                immSrc = 2'b11;
                
            end
        
            // Default case for unsupported instructions
            default: begin
                // Set default control signals
                MemtoReg = 2'b00;
                MemWrite = 1'b0;
                Branch = 1'b0;
                ALUop = 2'b00;
                ALUsrc = 1'b0;
                RegDst = 1'b0;
                RegWrite = 1'b0;
                LSen = 3'b000;
                immSrc = 2'b00;
                jump = 1'b0;
                jal_en=1'b0;
            end
        endcase
    end 

endmodule