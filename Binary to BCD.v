module Binary_to_BCD(
    input [11:0] binary,// 12 bit input data that would come in
    output reg [3:0] thos, // output thousands
    output reg [3:0] huns,// hundreds
    output reg [3:0] tens,// tens
    output reg [3:0] ones
     );

    
    
    reg [11:0] bcd_data=0;
    
    always @(binary) 
    begin
    bcd_data=binary; // 1250
    thos=bcd_data/1000; // 1250/1000=1
    bcd_data=bcd_data%1000; //1250/1000 =250
    huns=bcd_data/100; // 250/100=2
    bcd_data=bcd_data%100; // remainder =50
    tens=bcd_data/10; // 50/10=5
    ones=bcd_data%10;
    end
endmodule
