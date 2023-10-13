module left_shifter (
    input wire [31:0] shift_in,   // 2-bit input data
    output reg [31:0] shift_out  // 2-bit left-shifted output data
);

assign shift_out = shift_in << 2; // Left shift data_in by 1 bit

endmodule