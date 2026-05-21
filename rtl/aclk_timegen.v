module aclk_timegen(
clk, reset, reset_count, fastwatch, one_minute, one_second
);
input clk, reset, reset_count, fastwatch;
output reg one_minute, one_second;

reg [13:0]minute_count = 14'b0;
reg [7:0]second_count = 8'b0;

always @(posedge clk or posedge reset)
begin
if(reset) begin
one_minute <= 1'b0;
minute_count[13:0] <= 14'd0;
end
else if(reset_count) begin
one_minute <= 1'b0;
minute_count[13:0] <= 14'd0;
end
else if (minute_count[13:0] == 14'd15000) begin
minute_count <= 14'b0;
one_minute <= 1'b1;
end
else begin
one_minute <= 1'b0;
minute_count <= minute_count + 1;
end
end

always @(posedge clk or posedge reset)
begin
if(reset) begin
one_second <= 1'b0;
second_count <= 8'd0;
end
else if(reset_count) begin
one_second <= 1'b0;
second_count <= 8'd0;
end
else if (second_count[7:0] == 8'd249) begin
second_count <= 8'b0;
one_second <= 1'b1;
end
else begin
one_second <= 1'b0;
second_count <= second_count + 1;
end
end

always @(*)
begin
if(fastwatch) 
one_minute = one_second;
end


endmodule