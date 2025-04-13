
module vending_machine(
input clk,
input reset,
input quarter,// 25 rupees
input  dollar, // 100 rupee
input[3:0] select,// there is 4 tray in this machine containing four type of object each 15 item
input buy, // buying product
input [3:0] load,//load trays stock items when you run out of stock
output reg[11:0] money =0, // money that goes into the vending machine
output reg [3:0] products=0,// product that is dispensed([1]25 ruppes for gum [2] 75rupees for choclate [3] 150 rupees for chips [4]200 for drink
output reg[3:0] out_of_stock=0 // initially vending machine is full of stock

    );
    
    reg quarter_prev, dollar_prev;
    reg buy_prev;
    // initially stock is full
    reg[3:0] stock0=4'b1111; // each tray carry 15 items
    reg[3:0] stock1=4'b1111; // each tray carry 15 items
    reg[3:0] stock2=4'b1111; // each tray carry 15 items
    reg[3:0] stock3=4'b1111; // each tray carry 15 items
  
  always @(posedge clk)
  begin
  quarter_prev<=quarter;
  dollar_prev<=dollar;
  buy_prev<=buy;
  
  if(reset==1)// make the display on the segment set to zero
  money<=1'b0;
  
  else if(quarter_prev==1'b0 && quarter==1'b1)
  money<= money+12'd25;
  
    else if(dollar_prev==1'b0 && dollar==1'b1)
  money<= money+12'd100;// money inserted increase by 100

    else if(buy_prev==1'b0 && buy==1'b1)
  // here we decide what product will be buy,how much money return
  case (select)
  4'b0001: //  buy a gum
  
  if(money>=12'd25 && stock0>0)
  begin
  products[0]<=1'b1; // product dispensed
  stock0<=stock0-1'b1; // stock of gum is also decreased by 1
  money<=money-12'd25; // mchine withdraw price of product from the total money
  end
  
   4'b0010: //  buy a choclate
  
  if(money>=12'd75 && stock1>0)
  begin
  products[1]<=1'b1; // product dispensed
  stock1<=stock1-1'b1; // stock of gum is also decreased by 1
  money<=money-12'd75; // mchine withdraw price of product from the total money
  end
  
  4'b0100: //  buy a chips
  
  if(money>=12'd150 && stock2>0)
  begin
  products[2]<=1'b1; // product dispensed
  stock2<=stock2-1'b1; // stock of gum is also decreased by 1
  money<=money-12'd150; // mchine withdraw price of product from the total money
  end
  
  4'b1000: //  buy a drink
  
  if(money>=12'd200 && stock3>0)
  begin
  products[3]<=1'b1; // product dispensed
  stock3<=stock3-1'b1; // stock of gum is also decreased by 1
  money<=money-12'd200; // mchine withdraw price of product from the total money
  end
  endcase
 
 else if(buy_prev==1'b1 && buy==1'b0)// user does not want to buy
 begin
 products[0]<=1'b0;
 products[1]<=1'b0;
 products[2]<=1'b0;
 products[3]<=1'b0;
 end 
 //// when out of stock led goes high
 else begin
 if(stock0==4'b0000)
 out_of_stock[0]<=1'b1;
 else out_of_stock[0] <= 1'b0;
 
 if(stock1==4'b0000)
 out_of_stock[1]<=1'b1;
 else out_of_stock[1] <= 1'b0;
  
  if(stock2==4'b0000)
 out_of_stock[2]<=1'b1;
 else out_of_stock[2] <= 1'b0;
 
 if(stock3==4'b0000)
 out_of_stock[3]<=1'b1;
 else out_of_stock[3] <= 1'b0;
 // loading of stock
 case(load)
 4'b0000: stock0<=4'b1111;
 4'b0010: stock1<=4'b1111;
 4'b0100: stock2<=4'b1111;
 4'b1000: stock3<=4'b1111;
 endcase
 end
  end  
endmodule
