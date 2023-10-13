module riscv_alu (A, B, ALUcontrol, ALUResult, Zero);
    input [31:0] A; // Operand A
    input [31:0] B; // Operand B
    input  [3:0] ALUcontrol; // ALU operation code
    output  reg [31:0] ALUResult;// ALU operation result
    output  Zero ;// Zero flag

    wire [31:0]sum;
    wire [31:0] C,D;

    assign sum = (ALUcontrol[3] == 1'b0) ? A + B : (A + ((~B)+1)) ;
    assign C  = (A[31] == 1'b0) ? A : (~(A-1)) ;
    assign D  = (B[31] == 1'b0) ? B : (~(B-1)) ;

    always_comb
        case (ALUcontrol)
            4'b0000: ALUResult = sum; // Addition
            4'b1000: ALUResult = sum; // Subtraction            beq
            4'b0111: ALUResult = A & B; // Bitwise AND
            4'b0110: ALUResult = A | B; // Bitwise OR
            4'b0100: ALUResult = A ^ B; // Bitwise XOR
            4'b0001: ALUResult = A << $unsigned(B); // Shift left
            4'b0101: ALUResult = A >> $unsigned(B); // Shift right
            4'b1101: ALUResult = A >>> $unsigned(B); // Shift right (arithmetic)
            4'b0010: ALUResult = (A < B) ? 32'h1 : 32'h0; // Set if less than
            4'b0011: ALUResult = (C < D) ? 32'h1 : 32'h0;//($signed(A) < $signed(B)) ? 32'h1 : 32'h0; // Set if less than (unsigned)

            // 4'b1001: ALUResult = (A == B) ? 32'h0 : 32'h1; // beq
            4'b1010: ALUResult = (A != B) ? 32'h0 : 32'h1; // bne
            4'b1011: ALUResult = (A < B) ? 32'h0 : 32'h1; // blt
            4'b1100: ALUResult = (A >= B) ? 32'h0 : 32'h1; // bge
            4'b1110: ALUResult = (C < D) ? 32'h0 : 32'h1; // bltu
            4'b1111: ALUResult = (C >= D) ? 32'h0 : 32'h1; // bgeu  

            4'b1001: ALUResult = A[15:0]*B[15:0];                         //mul

            default: ALUResult = 32'h0;
        endcase
	
    // Zero flag generation
    assign Zero = (ALUResult == 32'h0);

endmodule