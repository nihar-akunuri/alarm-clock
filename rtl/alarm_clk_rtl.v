module alarm_clk_rtl(input clk, reset, fastwatch, alarm_button, time_button,
                     input [3:0]key,
                     output sound_alarm,
                     output [3:0] display_ms_hr,display_ls_hr,display_ms_min,display_ls_min);

wire one_minute, one_second;

wire reset_count, load_new_c, show_new_time, show_a, load_new_a, shift;

wire [3:0] key_buffer_ms_hr, key_buffer_ls_hr, key_buffer_ms_min, key_buffer_ls_min;

wire [3:0] current_time_ms_hr, current_time_ls_hr, current_time_ms_min, current_time_ls_min;

wire [3:0] alarm_ms_hr, alarm_ls_hr, alarm_ms_min, alarm_ls_min;

aclk_timegen tgen(clk,reset,reset,fastwatch,one_minute,one_second);

aclk_controller ctrlr(clk,reset,one_second,alarm_button,time_button,key,
                      reset_count,load_new_c,show_new_time,show_a,load_new_a,shift);
                
aclk_keyreg kreg(clk,reset,key,shift,
                 key_buffer_ms_hr, key_buffer_ls_hr, key_buffer_ms_min, key_buffer_ls_min);        
            
aclk_counter ctr(clk,reset,one_minute,load_new_c,
                 key_buffer_ms_hr, key_buffer_ls_hr, key_buffer_ms_min, key_buffer_ls_min,
              current_time_ms_hr, current_time_ls_hr, current_time_ms_min, current_time_ls_min);                    

aclk_areg areg(clk,reset,load_new_a,
               key_buffer_ms_hr, key_buffer_ls_hr, key_buffer_ms_min, key_buffer_ls_min,
               alarm_ms_hr, alarm_ls_hr, alarm_ms_min, alarm_ls_min);
          
aclk_lcd_driver lcd(show_a,show_new_time,
                    alarm_ms_hr, alarm_ls_hr, alarm_ms_min, alarm_ls_min,
               current_time_ms_hr, current_time_ls_hr, current_time_ms_min, current_time_ls_min,
                    key_buffer_ms_hr,key_buffer_ls_hr,key_buffer_ms_min,key_buffer_ls_min,
                    display_ms_hr,display_ls_hr,display_ms_min,display_ls_min, sound_alarm);          

endmodule