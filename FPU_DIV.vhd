-- CODE FOR DIVISON OPERATION FOR FLOATING POINT OPERATION

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.IEEE754.all;

entity FP_Div is
  Port ( A, B : in std_logic_vector(SINGLE_PRECISION-1 downto 0);
         Quot  : out std_logic_vector(SINGLE_PRECISION-1 downto 0));
end FP_Div;

architecture Behavioral of FP_Div is
  constant EXT_WIDTH: integer := (S_FRAC_BITS + 1) * 2;
  signal signA, signB, signQuot: std_logic;
  signal expA, expB, expQuot: std_logic_vector(S_EXP_BITS-1 downto 0);
  signal fracA, fracB: std_logic_vector(S_FRAC_BITS downto 0);
  signal fracA_ext, fracB_ext: unsigned(EXT_WIDTH-1 downto 0);  -- Extended size for division
  signal quotient: unsigned(S_FRAC_BITS+1 downto 0);  -- Extended quotient
  signal fracQuot: std_logic_vector(S_FRAC_BITS-1 downto 0);
begin
  -- Extract fields from inputs
  signA <= A(31);
  signB <= B(31);
  expA <= A(30 downto 23);
  expB <= B(30 downto 23);
  fracA <= "1" & A(22 downto 0);  -- Add implicit leading 1
  fracB <= "1" & B(22 downto 0);  -- Add implicit leading 1

  process(A, B)
  begin
    -- Initialize extended fractions
    fracA_ext <= unsigned(fracA) & to_unsigned(0, EXT_WIDTH - fracA'length);
    fracB_ext <= unsigned(fracB) & to_unsigned(0, EXT_WIDTH - fracB'length);

    -- Calculate quotient sign
    signQuot <= signA xor signB;

    -- Calculate quotient exponent
    expQuot <= std_logic_vector(unsigned(expA) - unsigned(expB) + 127);

    -- Calculate quotient fraction
    if fracB_ext /= 0 then
      quotient <= fracA_ext / fracB_ext;
    else
      quotient <= to_unsigned(0, quotient'length);  -- Handle division by zero
    end if;

    -- Set fraction quotient and normalize if necessary
    fracQuot <= std_logic_vector(quotient(quotient'length-2 downto quotient'length-1-S_FRAC_BITS));

    -- Normalize result
    if fracQuot(S_FRAC_BITS-1) = '0' and expQuot /= "00000000" then
      expQuot <= std_logic_vector(unsigned(expQuot) - 1);
      fracQuot <= std_logic_vector(shift_left(unsigned(fracQuot), 1));
    end if;

    -- Compose the result
    Quot <= signQuot & expQuot & fracQuot;
  end process;
end Behavioral;
