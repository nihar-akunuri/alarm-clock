`timescale 1ms/1us  // Time unit = 1 ms, precision = 1 us

module tb_aclk_timegen;

    // Inputs
    reg clk = 0;
    reg reset = 0;
    reg reset_count = 0;
    reg fastwatch = 0;

    // Outputs
    wire one_minute;
    wire one_second;

    // Instantiate the module
    aclk_timegen uut (
        .clk(clk),
        .reset(reset),
        .reset_count(reset_count),
        .fastwatch(fastwatch),
        .one_minute(one_minute),
        .one_second(one_second)
    );

    // Clock generation: 256 Hz (3.90625 ms period)
    always begin
        #2 clk = ~clk;  // Toggle clk every 2 ms (Period = 3.90625 ms ~ 256 Hz)
    end

    // Simulation duration: Let the clock run for 2 minutes (120 seconds)
    initial begin
        // Run simulation for 120 seconds (120000 ms)
        #120000;  // 120000 ms = 120 seconds = 2 minutes

        // Finish the simulation after 2 minutes
        $finish;
    end

endmodule
