--CODE FOR MULTIPLICATION OPERATION OF FLLOATING POINT 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.IEEE754.all;

entity FP_Mul is
  Port ( A, B : in std_logic_vector(SINGLE_PRECISION-1 downto 0);
         Prod : out std_logic_vector(SINGLE_PRECISION-1 downto 0));
end FP_Mul;

architecture Behavioral of FP_Mul is
  signal signA, signB, signProd: std_logic;
  signal expA, expB: std_logic_vector(S_EXP_BITS-1 downto 0);
  signal fracA, fracB: std_logic_vector(S_FRAC_BITS downto 0);
  signal fracProd: unsigned(2*S_FRAC_BITS+1 downto 0);
  signal expProd_tmp: unsigned(S_EXP_BITS downto 0);
  signal expProd: std_logic_vector(S_EXP_BITS-1 downto 0);
begin
  -- Extract fields from inputs
  signA <= A(31);
  signB <= B(31);
  expA <= A(30 downto 23);
  expB <= B(30 downto 23);
  fracA <= '1' & A(22 downto 0);  -- Add implicit leading 1
  fracB <= '1' & B(22 downto 0);  -- Add implicit leading 1

  process(A, B)
  begin
    -- Calculate product sign
    signProd <= signA xor signB;

    -- Calculate temporary product exponent
    expProd_tmp <= unsigned('0' & expA) + unsigned('0' & expB) - 127;

    -- Calculate product fraction
    fracProd <= unsigned(fracA) * unsigned(fracB);

    -- Normalize result
    if fracProd(2*S_FRAC_BITS+1) = '1' then
      expProd <= std_logic_vector(expProd_tmp + 1);
      fracProd <= fracProd(2*S_FRAC_BITS downto 1);
    else
      expProd <= std_logic_vector(expProd_tmp(S_EXP_BITS-1 downto 0));  -- Truncate to S_EXP_BITS
      fracProd <= fracProd(2*S_FRAC_BITS-1 downto 0);  -- No shift needed
    end if;

    -- Compose the result
    Prod <= signProd & expProd & std_logic_vector(fracProd(S_FRAC_BITS downto 1));
  end process;
end Behavioral;
