**Name:** MANAN AGGARWAL         

**Company:** CODTECH IT SOLUTIONS

**ID:** CT8VLSI1387

**Domain:** VLSI

**Duration:** JUNE TO AUGUST 2025


###Project: Floating Point Unit which can perform arithmetic operations on floating point numbers according to IEEE 754 standard 


### Overview

This project implements a floating-point arithmetic unit (FPU) in VHDL, based on the IEEE 754 single-precision standard. The FPU supports basic arithmetic operations: addition, subtraction, multiplication, and division. It is designed to handle 32-bit floating-point numbers, adhering to the IEEE 754 format, which consists of a sign bit, an 8-bit exponent, and a 23-bit fraction (mantissa). The project also includes a testbench to verify the correctness of the FPU operations.

### Key Features

- **IEEE 754 Compliance:** Implements single-precision floating-point arithmetic operations according to the IEEE 754 standard.
- **Arithmetic Operations:** Supports addition, subtraction, multiplication, and division of floating-point numbers.
- **Modular Design:** Each arithmetic operation (addition, subtraction, multiplication, division) is implemented as a separate VHDL entity.
- **Control Unit:** A control unit selects the appropriate arithmetic operation based on an opcode.
- **Testbench:** Includes a comprehensive testbench to validate the FPU's functionality.

### Operations

- **Addition (FP_Add):** Adds two single-precision floating-point numbers.
- **Subtraction (FP_Sub):** Subtracts one single-precision floating-point number from another.
- **Multiplication (FP_Mul):** Multiplies two single-precision floating-point numbers.
- **Division (FP_Div):** Divides one single-precision floating-point number by another.

### Technologies Used

- **VHDL:** The entire project is implemented using VHDL, a hardware description language.
- **IEEE 754 Standard:** The project follows the IEEE 754 single-precision floating-point standard.
- **IEEE Libraries:** The project utilizes various IEEE standard libraries such as `std_logic_1164`, `numeric_std`, and custom IEEE754 package.

### Future Use

This FPU can be integrated into larger digital systems requiring floating-point computations, such as digital signal processing (DSP) units, graphics processors, or scientific computation hardware. Future enhancements could include support for double-precision operations, hardware optimizations for better performance, and the inclusion of additional arithmetic functions like square roots or trigonometric functions.

### OUTPUT
![FPU_PROJECT_OUTPUT](https://github.com/user-attachments/assets/277bd1f0-d87c-4e08-8220-02f5fb015c77)
