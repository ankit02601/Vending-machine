
module Top_Module(
input clk,
input btnu, // reset
input btnc, // buy
input btnr, //25 cents
input btnl, // 100 cents
input[7:0] sw, // first four switches for selecting the product,remainder of switches to load the product
output [7:0] led,
output[6:0] seg,
output [3:0] an
    );
    wire [11:0] money;
    wire deb_btnc, deb_btnr,deb_btnl;
    
    Debounce dbnc(clk,btnc,deb_btnc); // buy
    Debounce dbnr(clk,btnr,deb_btnr); //quarter
    Debounce dbnl(clk,btnl,deb_btnl);// dollar
    
    wire[3:0] thos, huns, tens, ones;
    
    Binary_to_BCD BCD(money,thos,huns,tens,ones);
    Seven_Seg_Driver SSD(clk,deb_btnc,thos, huns, tens,ones,seg,an);
    
    
    vending_machine VM(clk,btnu,deb_btnr,deb_btnl, sw[3:0],deb_btnc,sw[7:4],money,led[3:0],led[7:4]);
    
endmodule
