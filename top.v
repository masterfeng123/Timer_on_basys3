`timescale 1ns / 1ps
////////////////////////////
module top(
    input wire clk,
    input wire btn_reset,
    input wire btn_set,
    output wire [6:0]seg_led,
    output wire [3:0]An,
    output wire [5:0] led_t,
    output wire state_moh,
    output wire state_toa
);
    

    wire bt_short, bt_long, bt_double, bt_triple, bt_four, btn_long;
    wire led_alarm;
    wire clk_1hz, clk_display;
    wire [5:0]s;
    wire [5:0]m;
    wire [4:0]h;
    wire [5:0]a_s, a_m;
    wire [4:0]a_h;
    wire [3:0] s_l, s_h;
    wire [3:0] m_l, m_h;
    wire switch_clk;
    wire switch_clk_alarm;
    wire [2:0] set_time;
    wire [2:0] set_alarm;
    wire reset;
    wire blinking;
    wire clk_long;
    wire [7:0]display_bcd_r,display_bcd_l;
    wire dis_toa;
    wire dis_moh;
    assign switch_clk = (set_time[2:0])?(btn_long)?clk_long:clk:clk_1hz;
    assign switch_clk_alarm = (btn_long)?clk_long:clk;
    assign state_moh = dis_moh;
    assign state_toa = dis_toa;

    de_clk m0(
        .clk_sourecs(clk),
        .rest(reset),
        .clk_1hz(clk_1hz),
        .clk_display(clk_display),
        .clk_blinking(blinking),
        .clk_long(clk_long)//hz[20]
    );
    
    /*wire one_bt_long, one_bt_double, one_set_dis;
    debounce m1_1(
    .clr(1'b0),
    .clk(clk),
    .inp(btn_reset),
    .out_1p(reset)
    );*/
    assign reset= btn_reset;

    display_ctrl m4_2(
        .t_s(s[5:0]), .t_m(m[5:0]), .a_s(a_s[5:0]), .a_m(a_m[5:0]),
        .t_h(h[4:0]), .a_h(a_h[4:0]),
        .sel_moh(dis_moh),
        .sel_toa(dis_toa),
        .display_bcd_r(display_bcd_r[7:0]), .display_bcd_l(display_bcd_l[7:0]),
        .led(led_t[5:0])
    );
    
    binary_to_BCD m4(
        .A(display_bcd_r[7:0]),
        .ONES(s_l),
        .TENS(s_h)
    );
    binary_to_BCD m5(
        .A(display_bcd_l[7:0]),
        .ONES(m_l),
        .TENS(m_h)
    );
    
    seg_ctr m2(
    .data0(s_l),
    .data1(s_h),
    .data2(m_l),
    .data3(m_h),
    .rest(reset),
    .clk(clk_display),
    .clk_1hz(clk_1hz),
    .seg_led(seg_led[6:0]),
    .An(An[3:0]),
    .blinking(blinking),
    .dis_moh(dis_moh),
    .set_time(set_time[2:0]),
    .set_alarm(set_alarm[2:0]),
    .led_alarm(led_alarm)
    );  
    
    top_time m3(
    .clk(switch_clk),
    .reset(reset),
    .set_signal(bt_short),
    .set_s(set_time[0]), .set_m(set_time[1]), .set_h(set_time[2]),
    .s(s[5:0]),
    .m(m[5:0]),
    .h(h[4:0]),
    .btn_long_signal(btn_long),
    .clk_long(clk_long)//hz[20]
    );

    FSM_set_toa m6(
        .clk(clk),
        .reset(reset),
        .set_long(bt_long),
        .set_double(bt_double),
        .set_short(bt_short),
        .set_triple(bt_triple),
        .set_four(bt_four),
        .set_time(set_time[2:0]),
        .set_alarm(set_alarm[2:0]),
        .dis_toa(dis_toa),
        .dis_moh(dis_moh)
    );
    
    alarm_system m7(
    .t_s(s[5:0]), 
    .t_m(m[5:0]),
    .t_h(h[4:0]),
    .a_s(a_s[5:0]), 
    .a_m(a_m[5:0]),
    .a_h(a_h[4:0]),
    .set_alarm(set_alarm[2:0]),
    .set_time(set_time[2:0]),
    .clk(switch_clk_alarm), 
    .reset(reset),
    .clk_1Hz(clk_1hz),
    .set_signal(bt_short),
    .btn_long_signal(btn_long),
    .led_alarm(led_alarm)
    );
    
    btn_system m8(
        .clk(clk), 
        .reset(reset),
        .btn(btn_set),
        .flag_short(bt_short), 
        .flag_long(bt_long), 
        .flag_double(bt_double),
        .flag_triple(bt_triple),
        .flag_four(bt_four),
        .btn_long(btn_long)
    );
    
endmodule
