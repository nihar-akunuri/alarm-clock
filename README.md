# Digital Alarm Clock in Verilog

A modular Verilog project for a digital clock with keypad-based time entry, alarm-time storage, display selection, and an alarm indication. The design is split into separate time-generation, control, counter, register, and display modules.

> **Project status:** This is an evolving RTL project. The repository includes module-level and top-level testbenches, but it does not include a unified automated regression or a build script. Check timing and alarm behavior in simulation before treating the design as a complete clock implementation.

## Features represented in the RTL

- Current-time storage in four decimal digits: tens/ones of hours and minutes.
- Alarm-time register with a load control.
- Four-digit key buffer that shifts in keypad values.
- Controller states for showing the current time or alarm, collecting key input, and setting time/alarm values.
- Time-generation pulses and a fast-watch mode.
- Display selection among current time, alarm time, and in-progress key entry.
- An alarm output driven by comparison between the displayed digits and stored alarm digits.

## Architecture

| File | Purpose |
|---|---|
| `rtl/alarm_clk_rtl.v` | Top-level module connecting the controller, time generator, key buffer, current-time counter, alarm register, and display/alarm logic. |
| `rtl/aclk_timegen.v` | Generates second/minute enable pulses from clock counters and supports a fast-watch input. |
| `rtl/aclk_controller.v` | FSM controlling display mode, keypad entry, and requests to load current or alarm time. |
| `rtl/aclk_counter.v` | Stores and increments current time in four decimal digits, with rollover at 23:59. |
| `rtl/aclk_areg.v` | Stores the four digits of the configured alarm time. |
| `rtl/aclk_keyreg.v` | Shifts keypad digits into a four-digit input buffer. |
| `rtl/aclk_lcd_driver.v` | Selects which four-digit time is presented at the display outputs and generates the alarm indication. |
| `testbench/tb_alarm_clk_rtl.v` | Applies keypad, reset, alarm-button, time-button, and fast-watch stimulus to the top level. |
| `testbench/tb_aclk_areg.v` | Exercises alarm-register loading. |
| `testbench/tb_aclk_counter.v` | Exercises current-time counter reset and minute increment. |
| `testbench/tb_aclk_keyreg.v` | Exercises shifting digits into the key buffer. |
| `testbench/tb_aclk_timegen.v` | Runs the time generator for an extended simulation interval. |

## Top-level interface

Module: `alarm_clk_rtl`

Inputs:
- `clk`, `reset`
- `fastwatch`
- `alarm_button`, `time_button`
- `key[3:0]` — keypad digit input; the controller uses value 10 as the no-key marker.

Outputs:
- `sound_alarm`
- `display_ms_hr[3:0]`, `display_ls_hr[3:0]`
- `display_ms_min[3:0]`, `display_ls_min[3:0]`

The display outputs are four individual decimal digits rather than a directly driven LCD segment bus.

## Simulation

Compile all files in `rtl/` together with the relevant testbench in `testbench/`. For an integrated simulation, select `tb_alarm_clk_rtl` as the top. The module-level testbenches can be selected individually to inspect register, counter, key-buffer, and time-generator behavior.

No Makefile or simulator-specific build script is included. The testbenches provide stimulus and waveform exploration; they do not form a complete automated pass/fail regression.

## Notes and possible improvements

- Review the connections between controller outputs and the time generator.
- Verify counter divisors against the intended board clock frequency.
- Define alarm-clear behavior and ensure the alarm output is registered and reset deterministically.
- Add self-checking tests for 23:59 rollover, setting the current time, setting an alarm, and matching the alarm time.

## Tools

- Verilog HDL
- Event-driven digital logic simulation
