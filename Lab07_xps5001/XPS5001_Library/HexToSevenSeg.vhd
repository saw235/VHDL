----------------------------------------------------------------------------
-- Entity:        HexToSevenSeg
-- Written By:    Saw Xue Zheng
-- Date Created:  9/4/2016
-- Description:   Driver to convert hexadecimals to Seven Segment Display output 
--
-- Revision History (date, initials, description):
-- 	4 September 16, xps5001, file created.

-- Dependencies:
-- None
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity HexToSevenSeg is
    Port ( HEX 	 : in  STD_LOGIC_VECTOR (3 downto 0);
           SEGMENT : out  STD_LOGIC_VECTOR (0 to 6));
end HexToSevenSeg;

architecture Behavioral of HexToSevenSeg is

begin

with HEX select			--Flip the bits--
	SEGMENT <= "1111110" xor "1111111" when "0000", -- '0'
				  "0110000" xor "1111111" when "0001", -- '1'
				  "1101101" xor "1111111" when "0010", -- '2'
				  "1111001" xor "1111111" when "0011", -- '3'
				  "0110011" xor "1111111" when "0100", -- '4'
				  "1011011" xor "1111111" when "0101", -- '5'
				  "1011111" xor "1111111" when "0110", -- '6'
				  "1110000" xor "1111111" when "0111", -- '7'
				  "1111111" xor "1111111" when "1000", -- '8'
				  "1111011" xor "1111111" when "1001", -- '9'
				  "1110111" xor "1111111" when "1010", -- 'A'
				  "0011111" xor "1111111" when "1011", -- 'b'
				  "1001110" xor "1111111" when "1100", -- 'C'
				  "0111101" xor "1111111" when "1101", -- 'd'
				  "1001111" xor "1111111" when "1110", -- 'E'
				  "1000111" xor "1111111" when "1111", -- 'F'
				  "0000000" xor "1111111" when others;
						  

end Behavioral;

