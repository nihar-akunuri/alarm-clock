`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2025 20:15:49
// Design Name: 
// Module Name: aclk_keyreg
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


module aclk_keyreg(clk, reset, key, shift,
                   key_buffer_ms_hr, key_buffer_ls_hr, key_buffer_ms_min, key_buffer_ls_min);
input clk, reset, shift;
input [3:0]key;
output reg [3:0]key_buffer_ms_hr;
output reg [3:0]key_buffer_ms_min;
output reg [3:0]key_buffer_ls_hr;
output reg [3:0]key_buffer_ls_min;

always @(posedge clk or posedge reset)
begin
if(reset) begin
key_buffer_ms_hr = 4'b0;
key_buffer_ms_min = 4'b0; 
key_buffer_ls_hr = 4'b0; 
key_buffer_ls_min = 4'b0;
end
else if(shift) begin
key_buffer_ms_hr = key_buffer_ls_hr;
key_buffer_ls_hr = key_buffer_ms_min;
key_buffer_ms_min = key_buffer_ls_min;  
key_buffer_ls_min = key;
end
end


endmodule
