module pc (rst, clk,PC_Next,PC);
    input rst, clk;
    input [31:0] PC_Next;
    output reg [31:0] PC;
    

    always_ff @(posedge clk or posedge rst) 
        if (rst) PC <= 32'h0;
        else    PC = PC_Next;

endmodule