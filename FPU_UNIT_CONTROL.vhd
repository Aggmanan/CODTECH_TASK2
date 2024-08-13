-- UNIT CONTROL FOR CONTROLLING ALL THE OPERATIONS AND PERFORMING SPECIFIC OPERATION DESRIED BY THE USER 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.IEEE754.all;

entity FPU is
  Port ( A, B : in std_logic_vector(SINGLE_PRECISION-1 downto 0);
         Opcode : in opcode_t;
         Result : out std_logic_vector(SINGLE_PRECISION-1 downto 0));
end FPU;

architecture Behavioral of FPU is
  signal AddResult, SubResult, MulResult, DivResult: std_logic_vector(SINGLE_PRECISION-1 downto 0);
begin
  U1: entity work.FP_Add
    port map (
      A => A,
      B => B,
      Sum => AddResult
    );

  U2: entity work.FP_Sub
    port map (
      A => A,
      B => B,
      Diff => SubResult
    );

  U3: entity work.FP_Mul
    port map (
      A => A,
      B => B,
      Prod => MulResult
    );

  U4: entity work.FP_Div
    port map (
      A => A,
      B => B,
      Quot => DivResult
    );

  process (A, B, Opcode)
  begin
    case Opcode is
      when ADD =>
        Result <= AddResult;
      when SUB =>
        Result <= SubResult;
     when MUL =>
        Result <= MulResult;
      when DIV =>
        Result <= DivResult;
      when others =>
        Result <= (others => '0'); -- Default case
    end case;
  end process;
end Behavioral;
