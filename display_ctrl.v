`timescale 1ns / 1ps

module display_ctrl(
    input [5:0] t_s, t_m, a_s, a_m,
    input [4:0] t_h, a_h,
    input sel_moh,
    input sel_toa,
    output [7:0] display_bcd_r, display_bcd_l,
    output [5:0] led
);
    wire [5:0]display_s, display_m; 
    wire [4:0]display_h;
    // sel_toa =1 顯示鬧鐘 | =0 顯示時間
    assign display_s = (sel_toa)?a_s:t_s;
    assign display_m = (sel_toa)?a_m:t_m;
    assign display_h = (sel_toa)?a_h:t_h;
    // sel_moh =1 顯示時分 | =0 顯示分秒
    assign led = (sel_moh)?display_s:{1'd0, display_h};
    assign display_bcd_r = (sel_moh)?{2'b00, display_m}:{2'b00, display_s};
    assign display_bcd_l = (sel_moh)?{3'b000, display_h}:{2'b00, display_m};
endmodule
