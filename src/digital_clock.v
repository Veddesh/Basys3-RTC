module digital_clock(
    input clk,
    input en,
    input rst,
    input hrup,
    input minup,
    output [3:0] s1,
    output [3:0] s2,
    output [3:0] m1,
    output [3:0] m2,
    output [3:0] h1,
    output [3:0] h2
    );
    
    reg [5:0] hour=0,min=0,sec=0; //[60] is max count so 6 bits required-64 that is 0-63
    integer clkc=0;
    localparam onesec=100_000_000;
     always @(posedge clk)
     begin
    
     if (rst==1'b1)
     begin
     hour<=0;
     min<=0;
     sec<=0;
     end
     
     else if (minup==1'b1)
     begin
     if (min==6'd59)
     begin
     min<=0;
     end
     else
     begin
     min<=min+1'd1;
     end
     end
     
     
     else if (hrup==1'b1)
     begin
     if (hour==23)
     begin
     hour<=0;
     end
     else
     begin
     hour<=hour+1'd1;
     end
     end
     
     
     else if (en==1'b1)
        if (clkc==onesec)
        begin 
        clkc<=0;
        if (sec==6'd59)
        begin
    sec<=0;
    if (min==6'd59)
    begin min<=0;
    if (hour==6'd23)
    hour<=0;
     else
        hour<=hour+1'd1;
    end
    else
    min<=min+1'd1;
    end
    else
    sec<=sec+1'd1;
    end
    else
    clkc<=clkc+1;
    end
    

binarytoBCD secs(.binary(sec),.thos(),.hund(),.tens(s2),.ones(s1));
binarytoBCD mins(.binary(min),.thos(),.hund(),.tens(m2),.ones(m1));
binarytoBCD hours(.binary(hour),.thos(),.hund(),.tens(h2),.ones(h1));


    
    
endmodule
