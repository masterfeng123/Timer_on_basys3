# Timer_on_basys3
本專案在 Xilinx Basys3 開發板上實現了一個多功能計時與鬧鐘系統。

## 核心功能
- 多功能按鍵偵測：支援單擊、雙擊、三擊、四擊及長按 。
- 時間與鬧鐘管理：可分別設定時、分、秒，並在時間吻合時觸發 10 秒的 LED 警報 。
- 靈活切換顯示：透過主狀態機控制，可在七段顯示器上切換顯示「時分」或「分秒」 。

## 模組架構
- btn_system.v：處理複雜按鍵行為與除彈跳 。
- FSM_set_toa.v：系統主控狀態機，管理設定模式切換 。
- alarm_system.v：負責計時邏輯與鬧鐘觸發判斷 。
- seg_ctr.v & display_ctrl.v：驅動七段顯示器並處理顯示內容選擇 。
- bin2bcd.v & add3.v：將數值轉為 BCD 碼以便顯示 。
- basys3.xdc：定義硬體腳位（如 W5 為時脈、U16 為 LED 等） 。

## 快速使用
1. 使用 Vivado 開啟專案並匯入所有 .v 原始碼 。
2. 加入 basys3.xdc 約束檔 。
3. 進行 Synthesis、Implementation 並產生 Bitstream 燒錄至 Basys3 。
