module data_memory (
    input wire clk,
    input wire [31:0] address,
    input wire [31:0] write_data,
    input wire write_enable,
    output wire [31:0] read_data
);

    // Define the memory array to store data
    reg [31:0] memory [0:1023]; // 1024 words of 32 bits each

    initial begin
            memory[1] = 32'h0000000B;
            memory[2] = 32'h00000102;
            memory[7] = 32'h00000016;
            memory[8] = 32'h0A050102;
            memory[9] = 32'h00000018;
            memory[10] = 32'h00000020;
    end

    // Read operation
    assign read_data = (write_enable) ? write_data : memory[address];

    // Write operation
    always @(posedge clk) begin
        if (write_enable) begin
            memory[address] <= write_data;
        end
    end

endmodule