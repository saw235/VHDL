

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CompareLES_4bit is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           LES : out  STD_LOGIC);
end CompareLES_4bit;

architecture Behavioral of CompareLES_4bit is

begin

LES <= '1' when (unsigned(A) < unsigned(B)) else '0';


end Behavioral;


