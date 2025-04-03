# Digital Clock System in Verilog

## Overview
This project implements a digital clock system using Verilog HDL. The design consists of multiple modules including:
- **Binary to BCD Converter**
- **7-Segment Display Decoder**
- **7-Segment Display Driver**
- **Debounce Circuit for Push Button Inputs**
- **Digital Clock Module**

Each of these modules works together to create a fully functional digital clock that displays time in `HH:MM:SS` format.

---

## Project Structure

### 1. Binary to BCD Converter (`binarytoBCD`)
**Purpose:** Converts a 12-bit binary input into Binary-Coded Decimal (BCD) format.

**Inputs:**
- `binary` (12-bit) - Input binary value

**Outputs:**
- `thos` (4-bit) - Thousands place digit
- `hund` (4-bit) - Hundreds place digit
- `tens` (4-bit) - Tens place digit
- `ones` (4-bit) - Ones place digit

**Functionality:**
- Uses integer division and modulo operations to extract individual decimal digits from a binary number.

---

### 2. 7-Segment Display Decoder (`Decoder_7_segment`)
**Purpose:** Converts a 4-bit BCD input into a 7-bit output that can drive a 7-segment display.

**Inputs:**
- `in` (4-bit) - BCD input

**Outputs:**
- `seg` (7-bit) - 7-segment display output (for a common anode display)

**Functionality:**
- Uses a `case` statement to determine the correct segment configuration for digits `0-9`.

---

### 3. 7-Segment Display Driver (`sevenseg_driver`)
**Purpose:** Multiplexes four 7-segment displays to show the complete time.

**Inputs:**
- `clk` - System clock
- `clr` - Clear/reset signal
- `in1, in2, in3, in4` (4-bit each) - BCD inputs for four displays

**Outputs:**
- `seg` (7-bit) - Segment outputs
- `an` (4-bit) - Active anode control

**Functionality:**
- Implements a time-multiplexing scheme to display digits sequentially at a high frequency.
- Uses a state machine to cycle through the four digits.

---

### 4. Push Button Debounce (`debounce`)
**Purpose:** Debounces mechanical push buttons to generate clean input signals.

**Inputs:**
- `clk_in` - System clock
- `pb` - Raw push button input

**Outputs:**
- `pb_out` - Debounced output signal

**Functionality:**
- Uses a counter to ignore transient noise and stabilize the button input.
- Generates a single-cycle pulse for button presses.

---

### 5. Digital Clock Module (`digital_clock`)
**Purpose:** Maintains the real-time clock functionality.

**Inputs:**
- `clk` - System clock (e.g., 100 MHz FPGA clock)
- `en` - Enable signal
- `rst` - Reset signal
- `hrup` - Hour increment button
- `minup` - Minute increment button

**Outputs:**
- `s1, s2` (4-bit each) - Seconds display
- `m1, m2` (4-bit each) - Minutes display
- `h1, h2` (4-bit each) - Hours display

**Functionality:**
- Increments time every second.
- Allows manual hour and minute adjustments using `hrup` and `minup`.
- Rolls over correctly at `59 seconds`, `59 minutes`, and `23 hours`.
- Uses the `binarytoBCD` module to convert binary time to BCD format for display.

---

## Simulation and Testing
To verify the functionality:
1. **Simulate each module separately** in Xilinx Vivado or ModelSim.
2. **Test the binary-to-BCD conversion** by providing different binary values and checking the outputs.
3. **Verify the 7-segment display decoder** to ensure correct digit representation.
4. **Use a testbench for the digital clock** to simulate time progression and manual adjustments.
5. **Test debounce logic** by applying noisy signals and observing the stabilized output.

---

## Possible Enhancements
- Implement **AM/PM format** instead of 24-hour format.
- Add **adjustable clock speed** for faster simulations.
- Implement an **alarm feature** with additional logic.
- Integrate a **real-time clock (RTC) module** for accurate timekeeping even after power loss.

---

## Conclusion
This project demonstrates a digital clock system using fundamental Verilog concepts such as:
- **Sequential logic**
- **Combinational logic**
- **Modular design**

The system can be expanded for real-world FPGA applications, making it a great learning experience for digital design enthusiasts.

---

### 🚀 Happy Coding! 🚀
