----------------------------------------------------------------------------
-- Entity:        Reg_SIPO
-- Written By:    Saw Xue Zheng
-- Date Created:  9/21/2016
-- Description:   n-bit shift register serial in parallel out
--
-- Revision History (date, initials, description):
-- 	21 September 2016, xps5001, file created.

-- Dependencies:
--		None
----------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Reg_SIPO is
	 Generic ( n : integer := 8;
				  clrto : std_logic := '0');
    Port ( D 			: in  STD_LOGIC;
           SHIFT_EN 	: in  STD_LOGIC;
           CLK 		: in  STD_LOGIC;
           CLR 		: in  STD_LOGIC;
           Q 			: out  STD_LOGIC_VECTOR (n-1 downto 0) := (others => clrto));
end Reg_SIPO;

architecture Behavioral of Reg_SIPO is

	--internal signal
	signal internal : STD_LOGIC_VECTOR (n-1 downto 0);
	
begin

	process (CLK) is
	begin
		if (CLK'EVENT and CLK = '1') then
			if (CLR = '1') then
					internal <= (others => clrto);
			elsif (SHIFT_EN = '1') then
					internal <= D & internal(internal'LEFT downto 1);
			end if;
		end if;
	end process;

	Q <= internal;
	
end Behavioral;

