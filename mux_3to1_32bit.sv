module mux_3to1_32bit (
  input [31:0] data0,
  input [31:0] data1,
  input [31:0] data2,
  input [1:0] select,
  output reg [31:0] write_data_N
);

always @(*)
begin
  case (select)
    2'b00: write_data_N = data0;
    2'b01: write_data_N = data1;
    2'b10: write_data_N = data2;
    default: write_data_N = 32'h0;
  endcase
end

endmodule