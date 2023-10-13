module Mux_5bit (

    input [4:0]a,b,
    input wire s,
    output [4:0]c
    );
    
    assign c = s ? a : b ;
    
endmodule