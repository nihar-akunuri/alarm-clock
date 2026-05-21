module aclk_controller(input clk, reset, one_second, alarm_button, time_button,
                       input [3:0]key,
                       output reset_count, load_new_c, show_new_time, show_a, 
                       load_new_a, shift);
                       
parameter SHOW_TIME = 3'd0;
parameter SHOW_ALARM = 3'd1;
parameter KEY_STORED = 3'd2;
parameter KEY_WAITED = 3'd3;
parameter SET_ALARM_TIME = 3'd4;
parameter SET_CURRENT_TIME = 3'd5;
parameter KEY_ENTRY = 3'd6;   
parameter NOKEY = 10;   

reg [2:0] ps,ns;
reg timeout;
reg [11:0]counter;

always @(posedge clk)
begin
if(reset) begin 
ps = SHOW_TIME;
counter = 0;
end 
else
ps = ns;
end   

always @(posedge clk) begin
if(counter == 2560)
timeout = 1;
else begin
timeout = 0;
counter = counter + 1;
end 

end                

always @(*) begin
case(ps)
SHOW_TIME: begin
if(alarm_button)
ns = SHOW_ALARM;
else if(key != 10)
ns = KEY_STORED;
else
ns = SHOW_TIME;
end

SHOW_ALARM: begin
if(!alarm_button)
ns = SHOW_TIME;
else
ns = SHOW_ALARM;
end 

KEY_STORED: begin
ns = KEY_WAITED;
end 

KEY_WAITED: begin
if(timeout)
ns = SHOW_TIME;
else if(key == 10)
ns = KEY_ENTRY;
else
ns = KEY_WAITED;
end

SET_ALARM_TIME: begin
ns = SHOW_TIME;
end

SET_CURRENT_TIME: begin
ns = SHOW_TIME;
end

KEY_ENTRY: begin
if(timeout)
ns = SHOW_TIME;
else if(alarm_button)
ns = SET_ALARM_TIME;
else if(time_button)
ns = SET_CURRENT_TIME;
else if(key != 10)
ns = KEY_STORED;
else
ns = KEY_ENTRY;
end   

endcase 
end 

assign show_new_time = ((ps==KEY_ENTRY)||(ps==KEY_STORED)||(ps==KEY_WAITED));
assign show_a = (ps == SHOW_ALARM);
assign load_new_a = (ps == SET_ALARM_TIME);
assign load_new_c = (ps == SET_CURRENT_TIME);
assign reset_count = (ps == SET_CURRENT_TIME);
assign shift = ((ps == KEY_STORED) && (key !=10));

endmodule   
