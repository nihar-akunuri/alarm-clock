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


module tb_aclk_keyreg();

reg clk = 1'b0;
reg reset = 1'b0;
reg shift = 1'b0;
reg [3:0]key; 
wire [3:0]key_buffer_ms_hr;
wire [3:0]key_buffer_ms_min;
wire [3:0]key_buffer_ls_hr;
wire [3:0]key_buffer_ls_min;

aclk_keyreg uut (clk,reset,key,shift,
              key_buffer_ms_hr, key_buffer_ms_min, key_buffer_ls_hr, key_buffer_ls_min         
              );

always begin
#2 clk = ~clk;
end

initial begin
key = 4'd0;
#30;
shift = 1'b1;
#4;
shift = 1'b0;
#10;
key = 4'd9;
#30;
shift = 1'b1;
#4;
shift = 1'b0;
#10;
key = 4'd3;
#30;
shift = 1'b1;
#4;
shift = 1'b0;
#10;
key = 4'd0;
#30;
shift = 1'b1;
#4;
shift = 1'b0;
#10;
$finish;
end
endmodule
