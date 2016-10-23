----------------------------------------------------------------------------
-- Entity:        Lab07_xps5001_kmr5802
-- Written By:    Saw Xue Zheng
-- Date Created:  10/19/2016
-- Description:   Component to get a scan code from PS/2 Keyboard
--
-- Revision History (date, initials, description):
-- 	19 Oct 16, xps5001, file created.

-- Dependencies:
--		ScanCodeReaderFSM
--		ScanCodeDataPath
----------------------------------------------------------------------------


library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use XPS5001_Library.XPS5001_Components.ALL;

entity Lab07_xps5001_kmr5802 is
    Port ( CLK 		: in  STD_LOGIC;
           BTNC 		: in  STD_LOGIC;
           ps2_data 	: in  STD_LOGIC;
           ps2_clk 	: in  STD_LOGIC;
           ANODE 		: out  STD_LOGIC_VECTOR (7 downto 0);
           SEGMENT 	: out  STD_LOGIC_VECTOR (0 to 6);
           LED 		: out  STD_LOGIC_VECTOR (15 downto 0));
end Lab07_xps5001_kmr5802;

architecture Behavioral of Lab07_xps5001_kmr5802 is
	
	component PS2KBD_ScanCodeReader is
    Port ( CLK 			: in  STD_LOGIC;
           RESET 			: in  STD_LOGIC;
           KB_DAT 		: in  STD_LOGIC;
           KB_CLK 		: in  STD_LOGIC;
           CODE_READY 	: out  STD_LOGIC;
           SCAN_CODE 	: out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	signal pulse_400hz 		: STD_LOGIC;
	signal pulse_200khz 		: STD_LOGIC;
	
	signal KB_DAT_db 			: STD_LOGIC;
	signal KB_CLK_db 			: STD_LOGIC;
	
	signal code_ready_int 	: STD_LOGIC;
	
	signal scan_code_int		: STD_LOGIC_VECTOR(7 downto 0);
	
	signal reset_int 			: STD_LOGIC;
	
	signal word_int			: STD_LOGIC_VECTOR(31 downto 0);
	
	signal scan_code			: STD_LOGIC_VECTOR(7 downto 0);
begin
	
		--400hz Pulse
	pulse_gen_400hz : PulseGenerator generic map( n => 18, maxCount => 249999)
		port map(
					EN 	=> '1',
					CLK	=> CLK,
					CLR	=> '0',
					PULSE => pulse_400hz--internal pulse
				);
	
	--2khz Pulse
	pulse_gen_200khz : PulseGenerator generic map( n => 9, maxCount => 499)
		port map(
					EN 	=> '1',
					CLK	=> CLK,
					CLR	=> '0',
					PULSE => pulse_200khz--internal pulse
				);
	
	
	
	
	reset_int <= BTNC;

	
	db_KB_dat : Debounce port map(
		D 			=> ps2_data,
		SAMPLE   => pulse_200khz,
		CLK 		=> CLK,
		Q 		   => KB_DAT_db
	
	);
	
	db_KB_clk : Debounce port map(
		D 			=> ps2_clk,
		SAMPLE   => pulse_200khz,
		CLK 		=> CLK,
		Q 		   => KB_CLK_db
	
	);
	
	scr : PS2KBD_ScanCodeReader port map(
		 CLK 			=> CLK,
	    RESET 		=> reset_int,
	    KB_DAT 		=> KB_DAT_db,
	    KB_CLK 		=> KB_CLK_db,
	    CODE_READY => code_ready_int,
	    SCAN_CODE 	=> scan_code_int
	);
	
	word_int <= x"000000" & scan_code;
		
	sevseg : WordTo8dig7seg port map(
				WORD 	 	=> word_int,
				STROBE 	=> pulse_400hz,
				CLK 		=> CLK,
				DIGIT_EN => "00000011",
				ANODE 	=> ANODE,
		      SEGMENT 	=> SEGMENT
	);		
	
	LED(15 downto 1) <= (others => '0');
	LED(0) 			  <= code_ready_int;
	
	rg : Reg generic map ( n => 8 ) port map(
		D 		=> scan_code_int,
	   LOAD 	=> code_ready_int,
	   CLK 	=> CLK,
	   CLR 	=> reset_int,
	   Q 		=> scan_code
	);
	
end Behavioral;

