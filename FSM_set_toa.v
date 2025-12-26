`timescale 1ns / 1ps

module FSM_set_toa(
    input clk,
    input reset,
    input set_long,
    input set_double,
    input set_short,
    input set_triple,
    input set_four,
    output reg dis_toa,
    output reg dis_moh,
    output reg [2:0]set_time,
    output reg [2:0]set_alarm
);

    parameter IDLE = 4'b0000;
    parameter SET_TS = 4'b0001;
    parameter SET_TM = 4'b0011;
    parameter SET_TH = 4'b0010;

    parameter SET_AS = 4'b0100;
    parameter SET_AM = 4'b0110;
    parameter SET_AH = 4'b0101;
    

    parameter DIS_H = 4'b0111;
    parameter SEE_ALARM = 4'b1000;
    parameter SEE_ALARM_H = 4'b1001;    

    reg [3:0]state, next_state;
    always@(posedge clk or posedge reset)begin
        if(reset)begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end

    always@(*)begin
        case(state)
            IDLE: begin
                if(set_long) next_state = SET_TS;
                else if(set_double) next_state = SET_AS;
                else if(set_short) next_state = DIS_H;
                else if(set_four) next_state = SEE_ALARM; 
                else next_state = IDLE;
            end
            DIS_H: begin
                if(set_long) next_state = SET_TS;
                else if(set_double) next_state = SET_AS;
                else if(set_short) next_state = IDLE;
                else if(set_four) next_state = SEE_ALARM;                 
                else next_state = DIS_H;
            end
            SET_TS: begin
                if(set_long) next_state = SET_TM;
                else if(set_triple) next_state = IDLE;
                else next_state = SET_TS;
            end
            
            SET_TM: begin
                if(set_long) next_state = SET_TH;
                else if(set_triple) next_state = IDLE;                
                else next_state = SET_TM;
            end
            
            SET_TH: begin
                if(set_long) next_state = IDLE;  
                else if(set_triple) next_state = IDLE;                               
                else next_state = SET_TH;
            end
            
            SET_AS: begin
                if(set_long) next_state = SET_AM;
                else if(set_triple) next_state = IDLE;                
                else next_state = SET_AS;
            end
            
            SET_AM: begin
                if(set_long) next_state = SET_AH;
                else if(set_triple) next_state = IDLE;                
                else next_state = SET_AM;
            end
            
            SET_AH: begin
                if(set_long) next_state = IDLE;
                else if(set_triple) next_state = IDLE;                  
                else next_state = SET_AH;
            end
            SEE_ALARM: begin
                if(set_four) next_state = IDLE; 
                else if(set_short) next_state = SEE_ALARM_H;                
                else next_state = SEE_ALARM; 
            end
            SEE_ALARM_H: begin
                if(set_four) next_state = IDLE; 
                else if(set_short) next_state = SEE_ALARM; 
                else next_state = SEE_ALARM_H;                 
            end
            default: next_state = IDLE; 
        endcase
    end 

    always@(*) begin
        case(state)
            IDLE:begin
                set_time = 3'b000;
                set_alarm = 3'b000; 
                dis_toa = 1'b0;
                dis_moh = 1'b0;
            end
            SET_TS:begin 
                set_alarm = 3'b000;
                set_time = 3'b001; 
                dis_toa = 1'b0;//time or alarm
                dis_moh = 1'b0;//minute or hour
            end
            SET_TM:begin 
                set_alarm = 3'b000;
                set_time = 3'b010; 
                dis_toa = 1'b0;
                dis_moh = 1'b0;
            end
            SET_TH:begin
                set_alarm = 3'b000;
                set_time = 3'b100; 
                dis_toa = 1'b0;
                dis_moh = 1'b1;
            end
            SET_AS:begin 
                set_time = 3'b000;
                set_alarm = 3'b001; 
                dis_toa = 1'b1;
                dis_moh = 1'b0;
            end
            SET_AM:begin
                set_time = 3'b000;
                set_alarm = 3'b010; 
                dis_toa = 1'b1;
                dis_moh = 1'b0;
            end
            SET_AH:begin
                set_time = 3'b000;
                set_alarm = 3'b100; 
                dis_toa = 1'b1;
                dis_moh = 1'b1;
            end
            DIS_H:begin
                set_time = 3'b000;
                set_alarm = 3'b000;
                dis_toa = 1'b0;
                dis_moh = 1'b1;
            end
            SEE_ALARM:begin
                set_time = 3'b000;
                set_alarm = 3'b000;
                dis_toa = 1'b1;
                dis_moh = 1'b0;
            end
            SEE_ALARM_H:begin
                set_time = 3'b000;
                set_alarm = 3'b000;
                dis_toa = 1'b1;
                dis_moh = 1'b1;
            end            
            default:begin
                set_time = 3'b000;
                set_alarm = 3'b000;
                dis_toa = 1'b0;
                dis_moh = 1'b0;
            end 
        endcase
    end
endmodule
