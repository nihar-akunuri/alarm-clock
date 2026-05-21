module aclk_lcd_driver(
input show_a,
input show_new_time,
input [3:0]alarm_ms_hr, alarm_ls_hr, alarm_ms_min, alarm_ls_min,
input [3:0]current_time_ms_hr, current_time_ls_hr, current_time_ms_min, current_time_ls_min,
input [3:0]key_buffer_ms_hr,key_buffer_ls_hr,key_buffer_ms_min,key_buffer_ls_min,
output reg [3:0]display_ms_hr,display_ls_hr,display_ms_min,display_ls_min,
output reg sound_alarm
    );
    
wire atime;

assign atime = ((display_ms_hr==alarm_ms_hr) && 
                (display_ls_hr==alarm_ls_hr) &&
                (display_ms_min==alarm_ms_min) &&
                (display_ls_min==alarm_ls_min));    
    
always @(*)
begin
    if(show_a)begin 
    display_ms_hr= alarm_ms_hr;
    display_ls_hr= alarm_ls_hr;
    display_ms_min= alarm_ms_min;
    display_ls_min= alarm_ls_min;
    end
    else if(show_new_time) begin  
    display_ms_hr= key_buffer_ms_hr;
    display_ls_hr= key_buffer_ls_hr;
    display_ms_min= key_buffer_ms_min;
    display_ls_min= key_buffer_ls_min;
    end 
    else begin 
    display_ms_hr= current_time_ms_hr;
    display_ls_hr= current_time_ls_hr;
    display_ms_min= current_time_ms_min;
    display_ls_min= current_time_ls_min;
    end  
end

always @(posedge atime) begin
if(atime)
    sound_alarm = 1;
end  

always @(*) begin
if(sound_alarm) begin
    if(show_a)
        sound_alarm = 0;
end 
end 

    
endmodule
