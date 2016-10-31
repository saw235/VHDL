
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SR_FF is
    Port ( S 		: in  STD_LOGIC;
           R 		: in  STD_LOGIC;
			  RESET	: in  STD_LOGIC;
           CLK 	: in  STD_LOGIC;
           Q		: out  STD_LOGIC;
			  Q_bar	: out STD_LOGIC);
end SR_FF;

architecture Behavioral of SR_FF is

begin
	process (CLK, RESET) is begin
		if (RESET = '1') then
			Q 		<= '0';
			Q_bar	<= '1';
		elsif (CLK'event and CLK = '1') then
			if (S /= R) then
				Q <= S;
				Q_bar	<= R;
			elsif ( S = '1' and R = '1') then
				Q <= 'Z';
				Q_bar	<= 'Z';
			end if;
		end if;
	end process;
end Behavioral;

