# Timer_on_basys3
This project implements a multi-functional Digital Timer and Alarm System on the Xilinx Basys3 FPGA development board.
## Key Features
- Advanced Button Detection: Supports multiple click patterns including single, double, triple, and quadruple clicks, as well as long-press detection.
- Time & Alarm Management: Independent configuration for hours, minutes, and seconds. Triggers a 10-second LED alert when the current time matches the alarm setting.
- Dynamic Display Control: Managed by a Finite State Machine (FSM), allowing users to toggle between "Hour:Minute" and "Minute:Second" views on the 7-segment display.
## Module Architecture
- btn_system.v: Handles complex button behaviors and signal debouncing.
- FSM_set_toa.v: The master controller FSM that manages system modes and setting states.
- alarm_system.v: Core logic for real-time clock counting and alarm trigger comparison.
- seg_ctr.v & display_ctrl.v: Drives the 4-digit 7-segment display and handles data multiplexing.
- bin2bcd.v & add3.v: Converts binary time data into BCD format for accurate decimal display.
- basys3.xdc: Hardware constraint file defining pin assignments (e.g., W5 for clock, U16 for LED).

## Quick Start
Open Xilinx Vivado and create a new project targeting the Basys3 board.
1. Import all .v source files into the project.
2. Add basys3.xdc as the design constraint.
3. Run Synthesis, Implementation, and Generate Bitstream.
4. Program the device via Hardware Manager.

## License & Disclaimer
This project is licensed under the MIT License.
Copyright (c) 2025 masterfeng123
Disclaimer: This project is specifically designed for the Basys3 development board. Please verify pin assignments and voltage standards before deploying on other hardware to prevent damage.
