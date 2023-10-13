module Test_bench();
  logic        clk;
  logic        rst;
  logic [31:0] PCPlus4;
  logic [31:0] PC_Top;
  logic [31:0] instra;
  logic [31:0] read1;
  logic [31:0] read2;
  logic        Zero;
  logic [31:0] result_val;
  logic [3:0]  alucontrol;
  logic        regwrite;
  logic [4:0]  write_reg;
  logic [31:0] extended;
  logic [31:0] ALUsrc_val;
  logic [31:0] ALU_out;
  logic [2:0]  LSen;
  logic [31:0] MEM_data;
  logic [1:0] Immsrc;
  logic [31:0] Added_Branch;
  logic        branch_1;
  logic [31:0] PCnext;
  logic        Jump;
  logic [31:0] After_Branch;
  logic [31:0] Shifted_jump;
  logic [31:0] ALUsrc_1;
  logic [31:0] PC_jal;
 

  // instantiate device to be tested
  single_cycle_mycode  dut(clk,rst,PC_Top,PCPlus4,instra,
                    read1,read2,result_val,Zero,regwrite,alucontrol,write_reg,
                    extended,ALUsrc_val,ALU_out,LSen,MEM_data,Immsrc,Added_Branch,
                    branch_1,PCnext,Jump,After_Branch,Shifted_jump,ALUsrc_1,PC_jal);
  
  // initialize test
  initial begin
      rst <= 1; # 50; rst <= 0;// # 300; rst <=1; # 50; rst <= 0; 
  end

  // generate clock to sequence tests
  always begin
      clk <= 0; # 50; clk <= 1; # 50;
  end
  
  endmodule