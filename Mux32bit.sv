module Mux32bit (

    input [31:0]a,b,
    input wire s,
    output [31:0]c
    );
    
    assign c = s ? a : b ;
    
endmodule