module Debounce(
input pb,clk_in,
output led
    );
    
    wire clk_out;
    wire Q1,Q2,Q2_bar;
    
    slow_Clock_4Hz u1(clk_in, clk_out);
    D_FF d1(clk_out, pb,Q1);
    D_FF d2(clk_out,Q1,Q2);
    
    assign Q2_bar =~Q2;
    assign led = Q1&Q2_bar;
   
    
endmodule

module slow_Clock_4Hz(
input clk_in, // input clock of the board
output reg clk_out // 4Hz slow clock
    );
    
    reg[25:0] count=0;
    //reg clk_out;
    
    always @(posedge clk_in)
    begin
    count<=count+1;
    if(count==12_500_000)
    begin
    count<=0;
    clk_out<=~clk_out;
    end
    end
endmodule

module D_FF(
input clk,// input clock, slow clock
input D, // pushbutton
output reg Q,
output reg Qbar
    );
