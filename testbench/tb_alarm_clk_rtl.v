`timescale 1ms / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 11:38:23
// Design Name: 
// Module Name: tb_alarm_clk_rtl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_alarm_clk_rtl();

reg clk, reset, fastwatch, alarm_button, time_button;
reg [3:0] key;
wire sound_alarm;
wire [3:0] display_ms_hr,display_ls_hr,display_ms_min,display_ls_min;

initial {clk,reset,fastwatch,alarm_button,time_button} = 0;
initial key = 4'd10;

alarm_clk_rtl uut(clk, reset, fastwatch, alarm_button, time_button, key, sound_alarm, 
                  display_ms_hr,display_ls_hr,display_ms_min,display_ls_min);
                  
always #1.953125 clk = ~clk;

initial begin 
@(negedge clk)
reset = 1;
#10;
@(negedge clk)
reset = 0;
#2;

@ (negedge clk)
key = 4'd0;
@ (negedge clk)
@ (negedge clk)
@ (negedge clk)
key = 4'd10; 
#50;
@ (negedge clk)
key = 4'd2;
@ (negedge clk)
@ (negedge clk)
@ (negedge clk)
key = 4'd10; 
#50;
@ (negedge clk)
key = 4'd3;
@ (negedge clk)
@ (negedge clk)
@ (negedge clk)
key = 4'd10; 
#50;
@ (negedge clk)
key = 4'd5;
@ (negedge clk)
@ (negedge clk)
@ (negedge clk)
key = 4'd10; 
#50;
@ (negedge clk)
alarm_button = 1;
#50;
alarm_button = 0;
#50;
alarm_button = 1;
#50;
alarm_button = 0;
#50;
fastwatch = 1;


 


end                   

endmodule
