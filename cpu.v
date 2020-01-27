module CPU(input clk);
wire muxJmp2Pc;
wire [31:0] instruction;
wire [31:0] readData1;
wire [31:0] readData2;
wire [31:0] aluResult;
wire [31:0] RdataDM;
wire [31:0] adder1Result;
wire [31:0] adder2Result;

wire dntCare;
wire zerom,lt,gt,bcond;
wire RegDst,Jump,Branch,MemRead,MemReg,AluSrc,RegWrite,MemWrite;
wire [3:0] Aluop;
reg [31:0] PC = 32'd0;
initial begin
  #20
  PC = 32'd0;                    // to test cpu set your instr mem in instrMem
end

IMemBank instrMem(1'b1,PC,instruction);
control control1(instruction[31:26],instruction[5:0],RegDst,Jump,Branch,MemRead,MemReg,AluSrc,RegWrite,MemWrite,Aluop);
RegFile registerFile(clk,instruction[25:21],instruction[20:16],RegDst?instruction[15:11]:instruction[20:16],MemReg?RdataDM:aluResult,RegWrite,readData1,readData2);
ALU alu(readData1,(AluSrc?32'(signed'(instruction[15:0])):readData2),Aluop,aluResult,zero,lt,gtl,bcond);
DMemBank DMem(MemRead,MemWrite,aluResult,readData2,RdataDM);
ALU adder1(PC,32'd4,4'b0000,adder1Result,dntCare,dntCare,dntCare,dntCare);
ALU adder2(adder1Result,32'(signed'(instruction[15:0]))<<<2,4'b0000,adder2Result,dntCare,dntCare,dntCare,dntCare);
always@(posedge clk)
begin
    PC = Jump?( {adder1Result[31:28],(instruction[25:0]<<<2)} ):((Branch&bcond) ? adder2Result: adder1Result);

end


endmodule

module CpuTB();

reg clock = 1'b0;
CPU cpu(clock);

initial begin 

forever begin
#50 clock = ~clock;
end
end

endmodule