
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Decoder3to8 is
    Port ( X : in  STD_LOGIC_VECTOR (2 downto 0);
           EN : in  STD_LOGIC;
           Y : out  STD_LOGIC_VECTOR (7 downto 0));
end Decoder3to8;

architecture Behavioral of Decoder3to8 is

begin
	
	Y <= 	(0 => '1' , others => '0') when ( EN = '1' and X = "000") else
			(1 => '1' , others => '0') when ( EN = '1' and X = "001") else
			(2 => '1' , others => '0') when ( EN = '1' and X = "010") else
			(3 => '1' , others => '0') when ( EN = '1' and X = "011") else
			(4 => '1' , others => '0') when ( EN = '1' and X = "100") else
			(5 => '1' , others => '0') when ( EN = '1' and X = "101") else
			(6 => '1' , others => '0') when ( EN = '1' and X = "110") else
			(7 => '1' , others => '0') when ( EN = '1' and X = "111") else
			(others => '0');

end Behavioral;

