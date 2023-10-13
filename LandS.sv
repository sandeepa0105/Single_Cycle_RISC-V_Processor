module LandS (LandS_en,IN_Data,out_Data);
        input [2:0] LandS_en;
        input [31:0] IN_Data;
        output reg [31:0] out_Data;

        // assign extended_value = {{16{input_value[15]}}, IN_Data};
    always @(*) begin
        case(LandS_en)
                3'b000: out_Data = {{24{IN_Data[7]}}, IN_Data[7:0]};
                3'b001: out_Data = {{16{IN_Data[15]}}, IN_Data[15:0]};
                3'b010: out_Data = IN_Data;
                3'b011: out_Data = {{24{1'b0}}, IN_Data[7:0]};
                3'b100: out_Data = {{16{1'b0}}, IN_Data[15:0]};
                // 3'b101: out_Data = {{24{IN_Data[7]}}, IN_Data[7:0]};
                // 3'b110: out_Data = {{16{IN_Data[15]}}, IN_Data[15:0]};
                // 3'b111: out_Data = IN_Data;
                default: out_Data = IN_Data;
        endcase
    end
endmodule