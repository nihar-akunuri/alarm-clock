`timescale 1ms / 1us
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.05.2025 11:21:11
// Design Name: 
// Module Name: tb_aclk_counter
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


module tb_aclk_counter();

reg clk = 1'b0; 
reg reset = 1'b0; 
reg one_minute = 1'b0; 
reg load_new_c = 1'b0;
reg [3:0]new_current_ms_hr = 4'b0; 
reg [3:0]new_current_ms_min = 4'b0; 
reg [3:0]new_current_ls_hr = 4'b0; 
reg [3:0]new_current_ls_min = 4'b0;

wire [3:0]current_time_ms_hr = 4'b0; 
wire [3:0]current_time_ms_min = 4'b0; 
wire [3:0]current_time_ls_hr = 4'b0; 
wire [3:0]current_time_ls_min = 4'b0;

aclk_counter uut (clk, reset, one_minute, load_new_c,
new_current_ms_hr, new_current_ms_min, new_current_ls_hr, new_current_ls_min,
current_time_ms_hr, current_time_ms_min, current_time_ls_hr, current_time_ls_min);

always begin
#2 clk=~clk;
end

initial begin 
reset = 1'b1;
#4;
reset = 1'b0;
#60000;
one_minute =1'b1;
#4;
one_minute=1'b0;
#60000;
end 


endmodule
