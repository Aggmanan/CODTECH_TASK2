-- CODE FOR ADDITON OPERATION FOR FLOATING POINT UNIT 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.IEEE754.all;

entity FP_Add is
  Port ( A, B : in std_logic_vector(SINGLE_PRECISION-1 downto 0);
         Sum  : out std_logic_vector(SINGLE_PRECISION-1 downto 0));
end FP_Add;

architecture Behavioral of FP_Add is
  -- Internal signal declarations
  signal signA, signB, signSum: std_logic;
  signal expA, expB, expSum: std_logic_vector(S_EXP_BITS-1 downto 0);
  signal fracA, fracB, fracSum: std_logic_vector(S_FRAC_BITS downto 0);
  signal aligned_fracA, aligned_fracB: std_logic_vector(S_FRAC_BITS+1 downto 0);
  signal unsigned_fracSum: unsigned(S_FRAC_BITS+1 downto 0);
begin
  -- Extract fields from inputs
  signA <= A(31);
  signB <= B(31);
  expA <= A(30 downto 23);
  expB <= B(30 downto 23);
  fracA <= "1" & A(22 downto 0); -- Add implicit leading 1
  fracB <= "1" & B(22 downto 0);

  process(A, B)
  begin
    -- Align exponents by shifting the fraction of the smaller exponent
    if unsigned(expA) > unsigned(expB) then
      expSum <= expA;
      aligned_fracA <= fracA & '0'; -- Extend the fraction to accommodate shifting
      aligned_fracB <= std_logic_vector(shift_right(unsigned(fracB & '0'), to_integer(unsigned(expA) - unsigned(expB))));
    else
      expSum <= expB;
      aligned_fracA <= std_logic_vector(shift_right(unsigned(fracA & '0'), to_integer(unsigned(expB) - unsigned(expA))));
      aligned_fracB <= fracB & '0'; -- Extend the fraction to accommodate shifting
    end if;

    -- Perform addition or subtraction based on signs
    if signA = signB then
      unsigned_fracSum <= unsigned(aligned_fracA) + unsigned(aligned_fracB);
      signSum <= signA;
    else
      if unsigned(aligned_fracA) > unsigned(aligned_fracB) then
        unsigned_fracSum <= unsigned(aligned_fracA) - unsigned(aligned_fracB);
        signSum <= signA;
      else
        unsigned_fracSum <= unsigned(aligned_fracB) - unsigned(aligned_fracA);
        signSum <= signB;
      end if;
    end if;

    -- Normalize the result
    if unsigned_fracSum(S_FRAC_BITS+1) = '1' then
      expSum <= std_logic_vector(unsigned(expSum) + 1);
      unsigned_fracSum <= shift_right(unsigned_fracSum, 1);
    end if;

    -- Compose the result
    fracSum <= std_logic_vector(unsigned_fracSum(S_FRAC_BITS downto 0));
    Sum <= signSum & expSum & fracSum(S_FRAC_BITS-1 downto 0);
  end process;
end Behavioral;
