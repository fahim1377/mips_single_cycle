//memory unit
module IMemBank(input memread, input [7:0] address, output reg [31:0] readdata);
 
  reg [31:0] mem_array [63:0];
  
  initial begin
/*
     mem_array[0]= 32'b00000000000000000000100000100000;     //add 1,0,0
     mem_array[1]= 32'b10001100101001110000000000000000;     //lw  7,0,5
     mem_array[2]= 32'b00000000000001110001000000100000;     // add 2,0,7
     mem_array[3]= 32'b00000000000001110001100000100000;     // add 3,0,7
     mem_array[4]= 32'b00101000001001000000000000001010;      // slti 1,4,2
     mem_array[5]= 32'b00010000100000000000000000001011;     // beq 2,0,11
     mem_array[6]= 32'b10100000001001100000000000000010;    //sll 3,1,2 
     mem_array[7]= 32'b00000000110001010011000000100000;     //add 6,6,3
     mem_array[8]= 32'b10001100110001100000000000000000;      //lw 3,0,6
     mem_array[9]= 32'b00000000010001100010000000101010;     //slt  4,2,6
     mem_array[10]= 32'b00010000100000000000000000000001;    //  beq 4,0,1
     mem_array[11]= 32'b00000000000001100001000000100000;   // add 2,0,6 
     mem_array[12]= 32'b00000000110000110010000000101010;   //  slt 4,6,3
     mem_array[13]= 32'b00010000100000000000000000000001;   //  beq 4,0,1
     mem_array[14]= 32'b00000000000001100001100000100000;   //add 3,0,6 
     mem_array[15]= 32'b00100000001000010000000000000001;    //addi 1,1,1 
     mem_array[16]= 32'b00001000000000000000000000000100;   // j 4
     */


     mem_array[0] = 32'b10101101000100000000000000000000;
     mem_array[1] = 32'b10101101000100010000000000000100;
     mem_array[2] = 32'b10101101000100100000000000001000;
     mem_array[3] = 32'b10101101000100110000000000001100;
     mem_array[4] = 32'b10101101000101000000000000010000;
     mem_array[5] = 32'b10101101000101010000000000010100;
     mem_array[6] = 32'b10101101000101100000000000011000;
     mem_array[7] = 32'b10101101000101110000000000011100;
     mem_array[8] = 32'b10101101000010010000000000100000;
     mem_array[9] = 32'b10101101000010100000000000100100;
     mem_array[10] = 32'b00000010000000000101100000100000;
     mem_array[11] = 32'b00000010000000000110000000100000;
     mem_array[12] = 32'b00000000000000000110100000100000;
     mem_array[13] = 32'b00000001000011010111000000100000;
     mem_array[14] = 32'b10001101110011100000000000000000;
     mem_array[15] = 32'b00000001100011100111100000101010;
     mem_array[16] = 32'b00010000000011110000000000000010;
     mem_array[17] = 32'b00000001110000000110000000100000;
     mem_array[18] = 32'b00001000000000000000000000010110;
     mem_array[19] = 32'b00000001110010110111100000101010;
     mem_array[20] = 32'b00010000000011110000000000000001;
     mem_array[21] = 32'b00000001110000000101100000100000;
     mem_array[22] = 32'b00100001101011010000000000000001;
     mem_array[23] = 32'b00101001101110000000000000001010;
     mem_array[24] = 32'b00010100000110001111111111110100;
     mem_array[25] = 32'b10101101000010110000000000000000;
     mem_array[26] = 32'b10101101000011000000000000000100;

  end
 
  always@(memread, address, mem_array[address])
  begin
    if(memread)begin
      readdata=mem_array[address>>>2];
    end
  end

endmodule

module testbench;
  reg memread;              /* rw=RegWrite */
  reg [7:0] adr;  /* adr=address */
  wire [31:0] rd; /* rd=readdata */
  
  memBank u0(memread, adr, rd);
  
  initial begin
    memread=1'b0;
    adr=16'd0;
    
    #5
    memread=1'b1;
    adr=16'd0;
  end
  
  initial repeat(127)#4 adr=adr+1;
  
endmodule;
