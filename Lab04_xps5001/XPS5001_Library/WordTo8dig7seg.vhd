----------------------------------------------------------------------------
-- Entity:        WordTo8dig7seg
-- Written By:    Saw Xue Zheng
-- Date Created:  9/24/2016
-- Description:   Convert 32-bit word to 8 digit 7 seven segment
--						display driver

-- Revision History (date, initials, description):
-- 	21 September 2016, xps5001, file created.

-- Dependencies:
--		None
----------------------------------------------------------------------
library IEEE;
library XPS5001_Library;

use XPS5001_Library.XPS5001_Components.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity WordTo8dig7seg is
    Port ( WORD 		: in  STD_LOGIC_VECTOR (31 downto 0);
           STROBE 	: in  STD_LOGIC;
           CLK 		: in  STD_LOGIC;
           DIGIT_EN 	: in  STD_LOGIC_VECTOR (7 downto 0);
           ANODE 		: out  STD_LOGIC_VECTOR (7 downto 0);
           SEGMENT 	: out  STD_LOGIC_VECTOR (0 to 6));
end WordTo8dig7seg;

architecture Structural of WordTo8dig7seg is

	signal mux_sel    : STD_LOGIC_VECTOR (2 downto 0);
	signal hex_int    : STD_LOGIC_VECTOR (3 downto 0);
	signal count_int  : STD_LOGIC_VECTOR (2 downto 0);
	signal decode_int : STD_LOGIC_VECTOR (7 downto 0);
	signal anode_mask : STD_LOGIC_VECTOR (7 downto 0);
	
begin
	
	mux_sel <= count_int;
	
	
	--counter: counts up to 8
	--depending on the incoming pulse
	count	 : Counter generic map( n => 3) port map (
					EN  => STROBE,
					CLK => CLK,
					CLR => '0',
					Q	 => count_int
	);
	
	--8 to 1 mux
	with mux_sel select
		hex_int <= WORD(31 downto 28) when "111",
					  WORD(27 downto 24) when "110",
					  WORD(23 downto 20) when "101",
					  WORD(19 downto 16) when "100",
					  WORD(15 downto 12) when "011",
					  WORD(11 downto 8) when "010",
					  WORD(7 downto 4) when "001",
					  WORD(3 downto 0) when "000",
					  (others => '0') when others;
					  
	
	H27 : HexToSevenSeg port map(
			HEX 		=> hex_int,
			SEGMENT 	=> SEGMENT
	);
	
	D3to8 : Decoder3to8 port map(
			X	=> count_int,
			EN	=> CLK,
			Y	=> decode_int
	);

	
	anode_mask <= ("11111111" xor decode_int) or (DIGIT_EN xor "11111111");
	
	ANODE <= anode_mask;

end Structural;

