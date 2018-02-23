
module DFF (Q,D,CLK,RST);
   output Q;
   input D,CLK,RST;
   reg Q;
   always @(RST) 
     if (RST == 1) Q = 1'b0;   
    
   always @(posedge CLK) 
     if (RST == 1) Q = 1'b0;   
     else Q = D;
endmodule 



   module JKFF (Q,J,K,CLK,RST);
   output Q;
   input J,K,CLK,RST;
   wire JK;
   assign JK = (J & ~Q) | (~K & Q);
   DFF JK1 (Q,JK,CLK,RST);
endmodule

module BCounter(result,Re,CLK,en);
  output [6:0]result ;
  //wire result;
  input Re,CLK,en;
  
  wire [0:6]J;
  wire  [0:6]K;
  assign J[0] = ~Re & en;
  assign K[0] = ~Re & en;
  JKFF jk1(result[0],J[0],K[0],CLK,Re);
  assign J[1] = ~Re & result[0] & en;
  assign K[1] = ~Re & result[0] & en;
  JKFF jk2(result[1],J[1],K[1],CLK,Re);
  assign J[2] = ~Re & result[0] & result[1] & en;
  assign K[2] = ~Re & result[0] & result[1] & en;
  JKFF jk3(result[2],J[2],K[2],CLK,Re);
  assign J[3] = ~Re & result[0] & result[1] & result[2] & en;
  assign K[3] = ~Re & result[0] & result[1] & result[2] & en;
  JKFF jk4(result[3],J[3],K[3],CLK,Re);
  assign J[4] = ~Re & result[0] & result[1] & result[2] & result[3] & en;
  assign K[4] = ~Re & result[0] & result[1] & result[2] & result[3] & en;
  JKFF jk5(result[4],J[4],K[4],CLK,Re);
  assign J[5] = ~Re & result[0] & result[1] & result[2] & result[3] & result[4] & en;
  assign K[5] = ~Re & result[0] & result[1] & result[2] & result[3] & result[4] & en;
  JKFF jk6(result[5],J[5],K[5],CLK,Re);
  assign J[6] = ~Re & result[0] & result[1] & result[2] & result[3] & result[4] & result[5] & en;
  assign K[6] = ~Re & result[0] & result[1] & result[2] & result[3] & result[4] & result[5] & en;
  JKFF jk7(result[6],J[6],K[6],CLK,Re);
  
  endmodule
  
  module combin_al(al,r,ap,bp,a,b);
    output al;
    input r,ap,bp,a,b;
  
    assign al = r | (~r & ap) | (~r & ~ap & ~bp & a & ~b);
  endmodule
  
  module combin_bl(al,r,ap,bp,a,b);
    output al;
    input r,ap,bp,a,b;
  
    assign al = (~r & ~ap & bp) | (~r & ~ap & ~bp & ~a & b);
  endmodule
  
  
module E_comparator(A,B0,B1,B2,B3,B4,B5,B6,En,Equal);
  input [6:0] A;
  
   input En,B1,B2,B3,B4,B5,B6,B0;
   output Equal;
    
   assign #(5) Equal =  En &~(A[0]^B0) & ~(A[1]^B1) & ~(A[2]^B2) & ~(A[3]^B3) & ~(A[4]^B4) & ~(A[5]^B5) & ~(A[6]^B6) ;
endmodule


module decoder (A,B,D);
   input A,B;
   output [0:3] D;
   assign D[0] = (~A & ~B ),
          D[1] = (~A & B ),
          D[2] = (A & ~B ),
          D[3] = (A & B );
endmodule



module combin_A (r,ap,bp,bt,b,at,a);
  input r,ap,bp,bt,b,at;
  output a ;
  assign a = r | ~r & (ap | (~ap & ~bp & ( (~at & ~bt &~b) | (at &~bt) | ( bt & at& ~b) ) ));
endmodule


module combin_B (r,ap,bp,bt,a,at,b);
  input r,ap,bp,bt,a,at;
  output b ;
  assign b =  ~r & ~ap & (bp | (~bp & ( (bt & at & a) | (~at &~bt & a) | (~at& bt) )) );
endmodule


module traffic_light_control_system(CLK,R,A,B,A_Traffic,B_Traffic,en,A_Time_L,A_Time_H,B_Time_L,B_Time_H,A_Light,B_Light);
  input CLK,R,A,B,A_Traffic,B_Traffic,en;
  output [3:0]A_Time_L,A_Time_H,B_Time_L,B_Time_H;
  output A_Light,B_Light;
  wire [2:0]e ;
  wire [6:0]countnum ;
  wire [6:0] Aone;
  wire [6:0] Bone;
  
  wire [0:3]choose;
  wire  d_clk , answer_A , answer_B ,dec,a,b,real_a_traffic,real_b_traffic,A_ok,B_ok,A_or_B_ok;
  reg x ;
  assign dec = choose [3] | choose [0];

  always @(e[0] or e[1] or e[2] or en)
    if(e[0] || e[1] || e[2] || ~en)
      assign x = 1'b1;
    else  assign x = 1'b0;

  BCounter mainCounter(countnum,x | A | B | R | A_or_B_ok ,CLK,en);
  
  assign Z1 = countnum;
  E_comparator e3(countnum,1'b1,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,dec,e[0]);
  E_comparator e4(countnum,1'b0,1'b1,1'b1,1'b1,1'b1,1'b0,1'b0,choose[1],e[1]);
  E_comparator e5(countnum,1'b0,1'b1,1'b0,1'b1,1'b1,1'b0,1'b1,choose[2] ,e[2]);
  assign M1 = e[0];
  assign M2 = e[1];
  assign M3 = e[2];
  //assign Z2 = x;
  
  assign d_clock  = ( x | A | B | R | A_or_B_ok);
  assign Z3 = d_clock;
  DFF A_DFF(answer_A,a,d_clock,1'b0);  
  DFF B_DFF(answer_B,b,d_clock,1'b0);
  assign Z4 = answer_A & en;
  assign Z5 = answer_B & en;
  combin_A a_maker(R,A,B,real_b_traffic,answer_B & en,real_a_traffic,a);
  combin_B b_maker(R,A,B,real_b_traffic,answer_A & en,real_a_traffic,b);
  combin_al al_maker(A_Light,R,A,B,answer_A & en, answer_B & en );
  combin_bl bl_maker(B_Light,R,A,B,answer_A & en, answer_B & en);
  decoder dec1(answer_A & en,answer_B & en,choose);
  /*reg x2,x3;
  always@(A_Traffic or B_Traffic)
    if(A_Traffic & ~B_Traffic)
       x2 = 1'b1;
  always@(A_Traffic or B_Traffic)
    if(A_Traffic & ~B_Traffic)
       x3 = 1'b0;
  always@(A_Traffic or B_Traffic)
    if(~A_Traffic & B_Traffic)
       x2 = 1'b0;
  always@(A_Traffic or B_Traffic)
    if(~A_Traffic & B_Traffic)
       x3 = 1'b1;
    */ 
    
  BCounter Counter_a(Aone,~A_Traffic | B_Traffic | A_ok ,CLK,A_Traffic | B_Traffic);
  BCounter Counter_b(Bone,A_Traffic | ~B_Traffic | B_ok ,CLK,A_Traffic | B_Traffic);
  
  E_comparator e1(Aone,1'b1,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,(A_Traffic & ~B_Traffic),A_ok);
  E_comparator e2(Bone,1'b1,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,(~A_Traffic & B_Traffic),B_ok);
  assign Z2 = real_a_traffic;
  assign Z6 = real_b_traffic;
  
  assign A_or_B_ok = A_ok | B_ok;
  assign n1 = Aone;
  assign n2 = Bone;
  assign real_a_traffic = (A_or_B_ok & A_Traffic);
  assign real_b_traffic = (A_or_B_ok & B_Traffic);
  //wire[3:0] one ,ten;
  //binaryToBcd MZ2( countnum , ten , one , CLK );
 
    
  assign A_Time_L[0] = countnum[0] | A | B;
  assign A_Time_L[1] = countnum[1] | A | B;
  assign A_Time_L[2] = countnum[2] | A | B;
  assign A_Time_L[3] = countnum[3] | A | B;
  assign A_Time_H[0] = countnum[4] | A | B;
  assign A_Time_H[1] = countnum[5] | A | B;
  assign A_Time_H[2] = countnum[6] | A | B;
  assign A_Time_H[3] = A | B;
  
  
  assign B_Time_L[0] = countnum[0] | A | B;
  assign B_Time_L[1] = countnum[1] | A | B;
  assign B_Time_L[2] = countnum[2] | A | B;
  assign B_Time_L[3] = countnum[3] | A | B;
  assign B_Time_H[0] = countnum[4] | A | B;
  assign B_Time_H[1] = countnum[5] | A | B;
  assign B_Time_H[2] = countnum[6] | A | B;
  assign B_Time_H[3] = A | B;


endmodule

module binaryToBcd ( binary , ten , one , clk ) ;
  
  input [7:0] binary ; 
  input clk;
  output [3:0] one ; 
  output  [3:0] ten ;
  reg [3:0] ones ;
  reg [3:0] tens;
  
  integer i ;
  
  always @(posedge clk or binary)
  begin 
    if  (  binary == 8'b11111111)
      begin
	  ones = 4'b1111;
	  tens = 4'b1111;
	  end
	  else 
	  begin
			ones = 4'd0;
			tens = 4'd0;
    
			for ( i = 7 ; i>=0; i = i-1)
    
			begin
      
			if( tens >= 5)
        
				tens = tens + 3;
				if ( ones >= 5)

				ones = ones + 3; 
          
				tens = tens << 1;
				tens[0] = ones[3];
				ones = ones << 1;
				ones [0] = binary[i];
			end
		end
	end
    endmodule
    
   

module test;
reg clock,R,A,B,A_Traffic,B_Traffic,x;
wire [0:3]A_Time_L,A_Time_H,B_Time_L,B_Time_H;
wire A_Light,B_Light;
//reg B0,B1,B2,B3,B4,B5,B6,En;
//reg [6:0]A;
//wire Equal;
//reg clk , j ,k;
//reg reset;
//wire q;
//wire [6:0] result;
traffic_light_control_system MZ(clock,R,A,B,A_Traffic,B_Traffic,x,A_Time_L,A_Time_H,B_Time_L,B_Time_H,A_Light,B_Light);
initial
  
   begin
     
      clock = 0'b0;
      repeat (1000)
      #50 clock = ~clock;
   end

initial
  begin
    x = 0'b0;
    R = 0'b0;
    A = 0'b0;
    B = 0'b0;
    A_Traffic = 0'b0;
    B_Traffic = 0'b0;
    #100
    x = 0'b1;
    R = 0'b0;
    A = 0'b0;
    B = 0'b0;
    A_Traffic = 0'b0;
    B_Traffic = 0'b0;
    #10000
    x = 0'b1;
    R = 0'b0;
    A = 0'b0;
    B = 0'b0;
    A_Traffic = 0'b1;
    B_Traffic = 0'b0;
    
    #25000 $stop;
  end
/*  

BCounter m(result,reset,clk);

initial
   begin
      clk = 0'b0;
      repeat (1000)
      #50 clk = ~clk;
   end


   begin
      //reset = 1'b1;
      //#100
      reset = 1'b0;
      #1000 $stop;
      end
  /*    
JKFF jk(q,j,k,clk,reset);
initial
   begin
      clk = 0'b0;
      repeat (1000)
      #50 clk = ~clk;
   end
   
   initial
   begin
     j = 1'b1;
     k = 1'b0;
     reset = 1'b1;
     #100
     j = 1'b0;
     k = 1'b0;
     reset = 1'b0;
     #100
      j = 1'b1;
     k = 1'b0;
     #100
   
   j = 1'b0;
     k = 1'b1;
     #100
   j = 1'b1;
     k = 1'b1;
     #100 $stop;
 end
*/
endmodule