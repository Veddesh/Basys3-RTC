
module debounce(
    input clk_in, pb,   // FPGA Clock and push button input
    output reg pb_out   // Debounced push button output
);
    reg [19:0] count = 0; 
    reg pb_sync_0, pb_sync_1, pb_stable;

    always @(posedge clk_in) begin
        pb_sync_0 <= pb; // Synchronize to avoid metastability
        pb_sync_1 <= pb_sync_0;

        if (pb_sync_1 == pb_stable)
            count <= 0;  // Reset count if stable
        else begin
            count <= count + 1;
            if (count > 1_000_000) // ~10ms debounce time at 100MHz clock
                pb_stable <= pb_sync_1;
        end
    end

    always @(posedge clk_in) begin
        pb_out <= (pb_sync_1 & ~pb_stable); // Generates a single-cycle pulse
    end
endmodule
