module adder_32 ( a, b,  y);
    input [31:0] a;
    input [31:0] b;
    output [31:0] y;

    assign y = a + b;
endmodule