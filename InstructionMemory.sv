module InstructionMemory(
    input clk,
    input rst,
    input  [31:0] address,
    output reg [31:0] instruction
);

    // Declare internal memory to store instructions
    reg [31:0] memory [1023:0]; // 1024 instructions of 32 bits each

    // initial begin
    //     // Initialize memory with instructions
    //     // memory[0] = 32'h00108263;
    //     memory[0] = 32'h00000000;
    //     memory[1] = 32'h0141fa13;            //andi x20, x3, 20
    //     memory[2] = 32'h00208333;           //add x6, x1, x2
    //     memory[3] = 32'h002183b3;            //add x7, x3, x2
    //     memory[4] = 32'h402183b3;          //sub x7, x3, x2
    //     memory[5] = 32'h0020f3b3;            //and x7, x1, x2
    //     memory[6] = 32'h0020e3b3;           //or x7, x1, x2
    //     memory[7] = 32'h0020c3b3;            //xor x7, x1, x2
    //     memory[8] = 32'h401141b3;            //mul
    //     memory[9] = 32'h002093b3;             //sll x7, x1, x2
    //     memory[10] = 32'h0020a3b3;          //slt x7, x1, x2
    //     memory[11] = 32'h0020d3b3;           //srl x7, x1, x2
    // end

    assign instruction = (rst)? 32'h0 : memory[address[31:2]];

    initial begin
        $readmemh("instruction.hex", memory);
    end
	 

    
endmodule