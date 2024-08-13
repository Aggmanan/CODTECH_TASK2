library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.IEEE754.all;

entity FP_Sub is
  Port ( A, B : in std_logic_vector(SINGLE_PRECISION-1 downto 0);
         Diff : out std_logic_vector(SINGLE_PRECISION-1 downto 0));
end FP_Sub;

architecture Behavioral of FP_Sub is
  signal B_neg: std_logic_vector(SINGLE_PRECISION-1 downto 0);
begin
  -- Negate B and use FP_Add
  B_neg <= B(31) & not B(30 downto 0);

  U1: entity work.FP_Add
    port map (
      A => A,
      B => B_neg,
      Sum => Diff
    );
end Behavioral;
