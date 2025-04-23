module ALU(input [3:0] c, input [7:0] A, input [7:0] B, output reg [7:0] s,output reg cout);
  wire[7:0] result1;
  wire[7:0] result2;
  wire[7:0] result3;
  wire[7:0] result4;
  wire[7:0] result5;
  wire[7:0] result6;
  wire cout1;
  wire cout2;
  wire cout3;
  wire cout4;
  EIGHTBITADDER add1(A,B,result1,cout1);
  EIGHTBITADDER add2(A,8'b00000001,result2,cout2);
  EIGHTBITADDER add3(A,(~B)+8'b00000001,result3,cout3);
  EIGHTBITADDER add4(A,8'b11111111,result4,cout4);
  EIGHTBITCOMPAREMIN(A,B,result5);
  EIGHTBITCOMPAREMAX(A,B,result6);
  
  always@(*)begin
    case(c)
      4'b0001:begin s = result1; cout = cout1; 
    	end
      4'b0010:begin s = result2; cout = cout2; 
    	end
      4'b0011:begin s = result3; cout = cout3; 
      	end
      4'b0100:begin s = result4; cout = cout4; 
      	end
      4'b0110 : s = result5;
      4'b0111 : s = result6;
      4'b1000 : s = {A[0], A[7:1]}; 
      4'b1001 : s = {A[6:0], A[7]}; 
      4'b1010 : s = {1'b0, A[7:1]}; 
      4'b1011 : s = {A[6:0], 1'b0}; 
      4'b1100 : s = {A[7], A[7:1]}; 
      4'b1101 : s = {A[6:0], A[0]}; 
    endcase
  end

endmodule

module EIGHTBITADDER(input [7:0] a, input [7:0] b, output [7:0] s,output cout);
  wire [6:0] cin;
  
  assign s[0] = a[0] ^ b[0];
  assign cin[0] = a[0] & b[0];
  
  assign s[1] = a[1] ^ b[1] ^ cin[0];
  assign cin[1] = (a[1] & b[1]) | (a[1] & cin[0]) | (b[1] & cin[0]);

  assign s[2] = a[2] ^ b[2] ^ cin[1];
  assign cin[2] = (a[2] & b[2]) | (a[2] & cin[1]) | (b[2] & cin[1]);

  assign s[3] = a[3] ^ b[3] ^ cin[2];
  assign cin[3] = (a[3] & b[3]) | (a[3] & cin[2]) | (b[3] & cin[2]);

  assign s[4] = a[4] ^ b[4] ^ cin[3];
  assign cin[4] = (a[4] & b[4]) | (a[4] & cin[3]) | (b[4] & cin[3]);

  assign s[5] = a[5] ^ b[5] ^ cin[4];
  assign cin[5] = (a[5] & b[5]) | (a[5] & cin[4]) | (b[5] & cin[4]);

  assign s[6] = a[6] ^ b[6] ^ cin[5];
  assign cin[6] = (a[6] & b[6]) | (a[6] & cin[5]) | (b[6] & cin[5]);

  assign s[7] = a[7] ^ b[7] ^ cin[6];
  assign cout = (a[7] & b[7]) | (a[7] & cin[6]) | (b[7] & cin[6]);
endmodule
module EIGHTBITCOMPAREMIN(input [7:0]A,input [7:0]B , output reg [7:0] min);
  always@(*)begin
    integer i;
    if(A[7]==1'b1 && B[7] == 1'b0)
      min = A;
    else if(A[7]==1'b0 && B[7]==1'b1)
      min = B;
    else begin
     for (integer i = 6; i >= 0; i = i - 1)begin
        if (A[i] != B[i]) begin
          if (A[i] == 1'b1 && B[i] == 1'b0)begin
            min = B;
          end else if (A[i] == 1'b0 && B[i] == 1'b1)begin
            min = A;
          end
          break;
        end
     end
  end
  end
          
endmodule

module EIGHTBITCOMPAREMAX(input [7:0]A,input [7:0]B , output reg [7:0] max);
  always@(*)begin
    integer j;
    if(A[7]==1'b1 && B[7] == 1'b0)
      max = B;
    else if(A[7]==1'b0 && B[7]==1'b1)
      max = A;
    else begin
      for (integer j = 6; j >= 0; j = j - 1)begin
        if (A[j] != B[j]) begin
          if (A[j] == 1'b1 && B[j] == 1'b0)begin
            max = A;
          end else if (A[j] == 1'b0 && B[j] == 1'b1)begin
            max = B;
          end
          break;
        end
     end
  end
  end
          
endmodule