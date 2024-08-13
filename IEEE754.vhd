library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package IEEE754 is
  constant SINGLE_PRECISION: integer := 32;

  -- Single-precision constants
  constant S_EXP_BITS: integer := 8;
  constant S_FRAC_BITS: integer := 23;

  type opcode_t is (ADD, SUB, MUL, DIV);
end IEEE754;
