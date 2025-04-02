module Top_Module(
    input clk, // FPGA clock
    input sw, // switch[0] to enable the clock
    input btnC, // reset the clock
    input btnU, // hour increment
    input btnR, // min increment
    output [6:0] seg,
    output [3:0] an,
    output [7:0] led // display seconds
);

wire [3:0] s1, s2, m1, m2, h1, h2;
reg hrup, minup;

wire btnCclr, btnUclr, btnRclr;
reg btnCclr_prev, btnUclr_prev, btnRclr_prev;

debounce dbC(clk, btnC, btnCclr);
debounce dbU(clk, btnU, btnUclr); // hour up
debounce dbR(clk, btnR, btnRclr); // min up

// Instantiate seven-segment driver and digital clock modules
sevenseg_driver seg7(clk, 1'b0, h2, h1, m2, m1, seg, an); // HH:MM
digital_clock clock(clk, sw, btnCclr, hrup, minup, s1, s2, m1, m2, h1, h2);

// Setting up the logic for the clock, hrup, and minup using the pushbuttons
always @(posedge clk)
begin
    btnUclr_prev <= btnUclr; // hrup
    btnRclr_prev <= btnRclr; // minup

    if (btnUclr_prev == 1'b0 && btnUclr == 1'b1) 
        hrup <= 1'b1; 
    else 
        hrup <= 1'b0;
    // hrup button is zero and clr button is high then hrup is pressed, active

    if (btnRclr_prev == 1'b0 && btnRclr == 1'b1) 
        minup <= 1'b1; 
    else 
        minup <= 1'b0;
    // minup button is zero and clr button is high then minup is pressed, active
end

assign led[7:0] = {s2, s1};

endmodule
