----------------------------------------------------------------------------
-- Entity:        Counter
-- Written By:    Saw Xue Zheng
-- Date Created:  9/21/2016
-- Description:   n-bit counter
--						counts up to 2^n numbers

-- Revision History (date, initials, description):
-- 	21 September 2016, xps5001, file created.

-- Dependencies:
--		None
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter is
	 Generic ( n : integer := 8);
    Port ( EN 	 : in  STD_LOGIC;
           CLK  : in  STD_LOGIC;
           CLR  : in  STD_LOGIC;
           Q 	 : out  STD_LOGIC_VECTOR (n-1 downto 0));
end Counter;

architecture Behavioral of Counter is
	
	--internal signal
	signal Q_int : std_logic_vector (n-1 downto 0) := (others => '0');
	
begin

	process (CLK) is 
	begin
		if (CLK'event and CLK = '1') then
		
			if (CLR = '1') then Q_int <= (others => '0');
			elsif (EN = '1') then Q_int <= STD_LOGIC_VECTOR(unsigned(Q_int) + 1);
			end if;
		
		end if;
	end process;

	Q <= Q_int;
	
end Behavioral;

