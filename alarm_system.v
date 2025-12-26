`timescale 1ns / 1ps

module alarm_system(
    input [5:0]t_s, t_m,
    input [4:0]t_h,
    output reg [5:0]a_s, a_m,
    output reg [4:0]a_h,
    input [2:0]set_alarm,
    input [2:0]set_time,
    input clk, reset,
    input clk_1Hz,
    input set_signal,
    input btn_long_signal,
    output reg led_alarm
);
    reg [5:0]alarm_timer;
    reg trigger_alarm;
    reg [5:0]alarm_timer_st;
    
    parameter ALARM_TIME= 6'd10;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            a_s <= 6'b0;
            a_m <= 6'b0;
            a_h <= 5'b0;
        end else if (set_signal || btn_long_signal) begin
            case (set_alarm)
                3'b001:begin
                    if(a_s < 59) begin
                        a_s <= a_s + 6'd1; 
                    end else begin
                        a_s <= 0; 
                    end
                end
                3'b010:begin
                    if(a_m < 59) begin
                        a_m <= a_m + 1; 
                    end else begin
                        a_m <= 0; 
                    end
                end
                3'b100:begin
                    if(a_h < 23) begin
                        a_h <= a_h + 1;
                    end else begin
                        a_h <= 0;
                    end
                end
            endcase
        end
    end
    
    always@(posedge clk_1Hz or posedge reset)begin
        if (reset) begin
            alarm_timer <= 6'd0;
        end else begin
            alarm_timer <= alarm_timer+1;
        end 
    end
    
    always@(posedge clk or posedge reset) begin
        if (reset) begin
            trigger_alarm <= 0;
            led_alarm <= 1'b0;
        end else begin
            if (((t_s == a_s) && (t_m == a_m) && (t_h == a_h) && !set_alarm && !set_time) || trigger_alarm) begin        
                if(!trigger_alarm)begin
                    alarm_timer_st <= alarm_timer; 
                    trigger_alarm <= 1;
                    led_alarm <= 1'b1;
                end else if(alarm_timer == alarm_timer_st+ALARM_TIME)begin
                    led_alarm <= 1'b0;
                    trigger_alarm <= 0;
                end else begin
                    trigger_alarm <= 1;
                end
            end else begin
                led_alarm <= 1'b0;
            end
        end
    end

    
endmodule
