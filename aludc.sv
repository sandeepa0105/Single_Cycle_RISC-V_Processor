module aludc(ALUop,funct3,funct7,ALUcontrol);
        
        input [1:0] ALUop;
        input [2:0] funct3;
        input [6:0] funct7;
        output reg [3:0] ALUcontrol;


        wire [5:0] addr;

        assign addr= {funct7[5],funct3,ALUop};
    

        always @(*) begin
            casex(addr)
                //r type
                6'b000010: ALUcontrol = 4'b0000; //add
                6'b100010: ALUcontrol = 4'b1000; //sub
                6'b011110: ALUcontrol = 4'b0111; //and
                6'b011010: ALUcontrol = 4'b0110; //or
                6'b010010: ALUcontrol = 4'b0100; //xor
                6'b000110: ALUcontrol = 4'b0001; //sll
                6'b010110: ALUcontrol = 4'b0101; //srl
                6'b110110: ALUcontrol = 4'b1101; //sra
                6'b001010: ALUcontrol = 4'b0010; //slt
                6'b001110: ALUcontrol = 4'b0011; //sltu
                6'b110010: ALUcontrol = 4'b1001; //mul

                //i type
                6'bx00000: ALUcontrol = 4'b0000; //addi     , jalr ,jal
                6'bx11100: ALUcontrol = 4'b0111; //andi
                6'bx11000: ALUcontrol = 4'b0110; //ori
                6'bx10000: ALUcontrol = 4'b0100; //xori
                6'b000100: ALUcontrol = 4'b0001; //slli
                6'b010100: ALUcontrol = 4'b0101; //srli
                6'b110100: ALUcontrol = 4'b1101; //srai
                6'bx01000: ALUcontrol = 4'b0010; //slti
                6'bx01100: ALUcontrol = 4'b0011; //sltui

                //lw,lb,lbu,lh,lhu
                6'bx00011: ALUcontrol = 4'b0000; //LB        ,SB
                6'bx00111: ALUcontrol = 4'b0000; //LH       ,SH
                6'bx01011: ALUcontrol = 4'b0000; //LW        ,SW
                6'bx10011: ALUcontrol = 4'b0000; //LBU
                6'bx10111: ALUcontrol = 4'b0000; //LHU
                
                //sw,sb,sh
//                6'bx00011: ALUcontrol = 4'b0000; //SB
//                6'bx00111: ALUcontrol = 4'b0000; //SH
//                6'bx01011: ALUcontrol = 4'b0000; //SW

                //sb type
                6'bx00001: ALUcontrol = 4'b1000; //beq
                6'bx00101: ALUcontrol = 4'b1010; //bne
                6'bx10001: ALUcontrol = 4'b1011; //blt
                6'bx10101: ALUcontrol = 4'b1100; //bge
                6'bx11001: ALUcontrol = 4'b1110; //bltu
                6'bx11101: ALUcontrol = 4'b1111; //bgeu


                 default: ALUcontrol = 4'b0000;
            endcase
        end
endmodule