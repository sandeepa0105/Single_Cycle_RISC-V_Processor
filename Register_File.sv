module Register_File(
    input clk, // Clock input
    input  [4:0] read_reg1,read_reg2,write_reg, // Read register 1 addressr
    input [31:0] write_data,  // Data to be written to the register
    input write_enable,  // Write enable signal
    output reg [31:0] read_data1,  // Data read from register 1
    output reg [31:0] read_data2  // Data read from register 2
);

    logic [31:0] registers [31:0];  // 32 registers

    initial begin
        // Initialize register 0 to zero
        
        registers[1] = 32'h0000000C;
        registers[2] = 32'h00000007;
        registers[3] = 32'h00000002;
        registers[4] = 32'hFFFFFFFB;
        registers[5] = 32'hFFFFFFF7;
        registers[8] = 32'h0A050102;
    end

    always @(negedge clk) begin
        if (write_enable) begin
            registers[write_reg] <= write_data;
        end
    end
    

    assign read_data1 = (read_reg1 == 0) ? 32'h0 : registers[read_reg1];
    assign read_data2 = (read_reg2 == 0) ? 32'h0 : registers[read_reg2];

endmodule