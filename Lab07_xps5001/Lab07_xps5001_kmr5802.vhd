----------------------------------------------------------------------------
-- Entity:        Lab07_xps5001_kmr5802
-- Written By:    Saw Xue Zheng
-- Date Created:  10/19/2016
-- Description:   Top Level Block for Lab07
--
-- Revision History (date, initials, description):
-- 	19 Oct 16, xps5001, file created.

-- Dependencies:
--		PS2KBD_ScanCodeReader
--		ScanCodeProcessor
--		XPS5001_Library
----------------------------------------------------------------------------


library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use XPS5001_Library.XPS5001_Components.ALL;

entity Lab07_xps5001_kmr5802 is
    Port ( CLK 		: in  STD_LOGIC;
			  SWITCH		: in  STD_LOGIC_VECTOR ( 15 downto 0);
           BTNC 		: in  STD_LOGIC;
			  BTNR		: in  STD_LOGIC;
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
	
	
	component ScanCodeProcessor is
    Port ( CLK					: in  STD_LOGIC;
			  RESET				: in 	STD_LOGIC;
			  CodeReady_in 	: in  STD_LOGIC;
           ScanCode_in 		: in  STD_LOGIC_VECTOR (7 downto 0);
           UP					: out  STD_LOGIC;
			  DOWN				: out  STD_LOGIC;
			  LEFT				: out  STD_LOGIC;
			  RIGHT				: out  STD_LOGIC;
			  SHIFT				: out  STD_LOGIC;
           Last4ScanCode 	: out STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	signal pulse_400hz 		: STD_LOGIC;
	signal pulse_200khz 		: STD_LOGIC;
	signal pulse_10hz			: STD_LOGIC;
	signal pulse_20hz			: STD_LOGIC;	
	signal cord_pulse_int	: STD_LOGIC;
	
	signal KB_DAT_db 			: STD_LOGIC;
	signal KB_CLK_db 			: STD_LOGIC;
	
	signal code_ready_int 	: STD_LOGIC;
	signal code_ready_int_os: STD_LOGIC;
	
	signal scan_code_int		: STD_LOGIC_VECTOR(7 downto 0);
	
	signal reset_int 			: STD_LOGIC;
	signal reset_cord_int	: STD_LOGIC;
	
	signal word_int			: STD_LOGIC_VECTOR(31 downto 0);
	signal digit_en_int		: STD_LOGIC_VECTOR(7 downto 0);
	
	signal scan_code			: STD_LOGIC_VECTOR(7 downto 0);
	
	signal up_int				: STD_LOGIC;
	signal down_int			: STD_LOGIC;
	signal left_int			: STD_LOGIC;
	signal right_int			: STD_LOGIC;
	signal shift_int			: STD_LOGIC;
	
	signal xcord_int			: STD_LOGIC_VECTOR(7 downto 0);
	signal ycord_int			: STD_LOGIC_VECTOR(7 downto 0);
	signal cord_int			: STD_LOGIC_VECTOR(15 downto 0);
	
	signal Last4ScanCode_int: STD_LOGIC_VECTOR(31 downto 0);
	
	
begin
	
		--400hz Pulse
	pulse_gen_400hz : PulseGenerator generic map( n => 18, maxCount => 249999)
		port map(
					EN 	=> '1',
					CLK	=> CLK,
					CLR	=> reset_int,
					PULSE => pulse_400hz--internal pulse
				);
	
	--200khz Pulse
	pulse_gen_200khz : PulseGenerator generic map( n => 9, maxCount => 499)
		port map(
					EN 	=> '1',
					CLK	=> CLK,
					CLR	=> reset_int,
					PULSE => pulse_200khz--internal pulse
				);
	
		--10hz Pulse
	pulse_gen_10hz : PulseGenerator generic map( n => 24, maxCount => 9999999)
		port map(
					EN 	=> '1',
					CLK	=> CLK,
					CLR	=> reset_int,
					PULSE => pulse_10hz--internal pulse
				);
	
	
	pulse_gen_20hz : PulseGenerator generic map( n => 23, maxCount => 4999999)
		port map(
					EN 	=> '1',
					CLK	=> CLK,
					CLR	=> reset_int,
					PULSE => pulse_20hz--internal pulse
				);
	
	
	reset_int <= BTNC;
	reset_cord_int <= BTNR;
	
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
	
	
	osht_CR : OneShot port map(
		D 		=> code_ready_int,
      CLK   => CLK,
      Q 		=> code_ready_int_os
	);
	
	
	scrProcessor : ScanCodeProcessor port map(
		CLK			 	=> CLK,
		RESET			 	=> reset_int,
		CodeReady_in 	=> code_ready_int_os,
		ScanCode_in  	=> scan_code_int,
		UP 				=> up_int,		
		DOWN				=> down_int,
		LEFT				=> left_int,
		RIGHT				=> right_int,
		SHIFT				=> shift_int,
		Last4ScanCode 	=> Last4ScanCode_int
	);
	
	with shift_int select
		cord_pulse_int <= pulse_20hz when '1',
								pulse_10hz when others;
	
	xcord : CounterUpDown port map(
		EN		=> cord_pulse_int,
		UP 	=> right_int,
	   DOWN	=> left_int,
	   CLK	=> CLK,
	   CLR 	=> reset_cord_int,
	   Q 		=> xcord_int
	);

	ycord : CounterUpDown port map(
		EN		=> cord_pulse_int,
		UP 	=> up_int,
	   DOWN	=> down_int,
	   CLK	=> CLK,
	   CLR 	=> reset_cord_int,
	   Q 		=> ycord_int
	);	
	
	
	cord_int <= xcord_int & ycord_int;
	
	
	with SWITCH(0) select 
		word_int <= cord_int & x"0000" when '1',
						Last4ScanCode_int  when '0',
						(others => '0') when others;
	
	with SWITCH(0) select
		digit_en_int <= "11110000" when '1',
							 "11111111" when others;
		
	sevseg : WordTo8dig7seg port map(
				WORD 	 	=> word_int,
				STROBE 	=> pulse_400hz,
				CLK 		=> CLK,
				DIGIT_EN => digit_en_int,
				ANODE 	=> ANODE,
		      SEGMENT 	=> SEGMENT
	);		
	
	LED(15) 				<= up_int;
	LED(14)				<= left_int;
	LED(13)				<= down_int;
	LED(12)				<= right_int;
	LED(11)				<= shift_int;
	LED(10 downto 1) 	<= (others => '0');

	LED(0) 				<= code_ready_int;
	
end Behavioral;

