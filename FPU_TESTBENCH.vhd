--TESTBENCH CODE FOR PERFORMING OPERATIONS ON FLOATING POINT 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.IEEE754.all;

entity FPU_tb is
end FPU_tb;

architecture Behavioral of FPU_tb is
  -- Signals to interface with the FPU
  signal A, B: std_logic_vector(SINGLE_PRECISION-1 downto 0);
  signal Opcode: opcode_t;
  signal Result: std_logic_vector(SINGLE_PRECISION-1 downto 0);

  -- Constants for testing
  constant ZERO: std_logic_vector(SINGLE_PRECISION-1 downto 0) := x"00000000"; -- 0.0
  constant ONE: std_logic_vector(SINGLE_PRECISION-1 downto 0) := x"3F800000"; -- 1.0
  constant TWO: std_logic_vector(SINGLE_PRECISION-1 downto 0) := x"40000000"; -- 2.0
  constant THREE: std_logic_vector(SINGLE_PRECISION-1 downto 0) := x"40400000"; -- 3.0
  constant FOUR: std_logic_vector(SINGLE_PRECISION-1 downto 0) := x"40800000"; -- 4.0

  -- Unit Under Test (UUT)
  component FPU is
    Port ( A, B : in std_logic_vector(SINGLE_PRECISION-1 downto 0);
           Opcode : in opcode_t;
           Result : out std_logic_vector(SINGLE_PRECISION-1 downto 0));
  end component;

begin
  -- Instantiate the FPU
  uut: FPU
    port map (
      A => A,
      B => B,
      Opcode => Opcode,
      Result => Result
    );

  -- Test process
  process
  begin
    -- Test addition
    A <= ONE;
    B <= TWO;
    Opcode <= ADD;
    wait for 50 ns;
    assert (Result = x"40400000") report "Addition test failed" severity error; -- 1.0 + 2.0 = 3.0

    -- Test subtraction
    A <= THREE;
    B <= ONE;
    Opcode <= SUB;
    wait for 50 ns;
    assert (Result = x"3F800000") report "Subtraction test failed" severity error; -- 3.0 - 1.0 = 2.0

    -- Test multiplication
    A <= TWO;
    B <= TWO;
    Opcode <= MUL;
    wait for 10 ns;
    assert (Result = x"40800000") report "Multiplication test failed" severity error; -- 2.0 * 2.0 = 4.0

    -- Test division
    A <= FOUR;
    B <= TWO;
    Opcode <= DIV;
    wait for 10 ns;
    assert (Result = x"3F800000") report "Division test failed" severity error; -- 4.0 / 2.0 = 2.0

    -- End of test
    wait;
  end process;
end Behavioral;
