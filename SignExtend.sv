module SignExtend(imm,immSrc, extended);

        input[24:0] imm;
        input [1:0] immSrc;
        output reg [31:0] extended;

    always @(*) begin
            case(immSrc)
                2'b00: extended = {{20{imm[24]}}, imm[24:13]};
                2'b01: extended = {{20{imm[24]}}, imm[24:18], imm[4:0]};
                2'b10: extended = {{19{imm[24]}}, imm[24], imm[0],imm[23:18],imm[4:1],{1'b0}};
                2'b11: extended = {{11{imm[24]}}, imm[24], imm[12:5],imm[13], imm[23:14],{1'b0}};
            endcase

        end
// assign extended={{20{imm[11]}},imm[11:0]};

endmodule