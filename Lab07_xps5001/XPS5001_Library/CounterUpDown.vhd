----------------------------------------------------------------------------
-- Entity:        CounterUpDown
-- Written By:    Saw Xue Zheng
-- Date Created:  9/21/2016
-- Description:   n-bit counter
--						counts up/down to 2^n numbers

-- Revision History (date, initials, description):
-- 	21 September 2016, xps5001, file created.

-- Dependencies:
--		None
----------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CounterUpDown is
	 Generic ( n 		  : integer := 8;
				  clrto : STD_LOGIC := '0');
    Port ( EN 		: in  STD_LOGIC;
           UP 		: in  STD_LOGIC;
           DOWN 	: in  STD_LOGIC;
           CLK	 	: in  STD_LOGIC;
           CLR 	: in  STD_LOGIC;
           Q 		: out  STD_LOGIC_VECTOR (n-1 downto 0));
end CounterUpDown;

architecture Behavioral of CounterUpDown is
	
	--internal signal
	signal Q_int : std_logic_vector (n-1 downto 0) := (others => clrto);

begin

	process (CLK) is 
	begin
		if (CLK'event and CLK = '1') then
		
			if (CLR = '1') then Q_int <= (others => clrto);
			elsif (EN = '1' and UP = '1' and DOWN = '0') then Q_int <= STD_LOGIC_VECTOR(unsigned(Q_int) + 1);
			elsif (EN = '1' and DOWN = '1' and UP = '0') then Q_int <= STD_LOGIC_VECTOR(unsigned(Q_int) - 1);
			end if;
		
		end if;
	end process;

	Q <= Q_int;
	
end Behavioral;

