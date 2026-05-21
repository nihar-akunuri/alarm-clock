`timescale 1ms / 1us
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2025 10:35:11
// Design Name: 
// Module Name: tb_aclk_areg
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


module tb_aclk_areg();

reg clk = 1'b0;
reg reset = 1'b0;
reg load_new_a = 1'b0;
reg [3:0]new_alarm_ms_hr; 
reg [3:0]new_alarm_ms_min; 
reg [3:0]new_alarm_ls_hr; 
reg [3:0]new_alarm_ls_min;
wire [3:0]alarm_time_ms_hr;
wire [3:0]alarm_time_ms_min;
wire [3:0]alarm_time_ls_hr;
wire [3:0]alarm_time_ls_min;

aclk_areg uut (clk,reset,load_new_a,
              new_alarm_ms_hr,new_alarm_ms_min,new_alarm_ls_hr,new_alarm_ls_min,
              alarm_time_ms_hr, alarm_time_ms_min, alarm_time_ls_hr, alarm_time_ls_min         
              );

always begin
#2 clk = ~clk;
end

initial begin
new_alarm_ms_hr = 4'd0;
new_alarm_ms_min = 4'd6;
new_alarm_ls_hr = 4'd3;
new_alarm_ls_min = 4'd0;
#30;
load_new_a = 1'b1;
#2;
load_new_a = 1'b0;
#20;
new_alarm_ms_hr = 4'd1;
new_alarm_ms_min = 4'd2;
new_alarm_ls_hr = 4'd4;
new_alarm_ls_min = 4'd5;
#30;
load_new_a = 1'b1;
#2;
load_new_a = 1'b0;
#20;
$finish;
end
endmodule
