----------------------------------------------------------------------------
-- Entity:        PS2KBD_ScanCodeReader
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



entity PS2KBD_ScanCodeReader is
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           KB_DAT : in  STD_LOGIC;
           KB_CLK : in  STD_LOGIC;
           CODE_READY : out  STD_LOGIC;
           SCAN_CODE : out  STD_LOGIC_VECTOR (7 downto 0));
end PS2KBD_ScanCodeReader;

architecture Structural of PS2KBD_ScanCodeReader is
	
	component ScanCodeReadFSM is
		 Port ( STATUS_in 	: in  STD_LOGIC_VECTOR (1 downto 0);
				  CLK 			: in  STD_LOGIC;
				  RESET 			: in  STD_LOGIC;
				  CONTROL_out 	: out  STD_LOGIC_VECTOR (3 downto 0);
				  DEBUG_out 	: out  STD_LOGIC_VECTOR (3 downto 0));
	end component;

	component ScanCodeReadDataPath is
    Port ( CONTROL_in : in  STD_LOGIC_VECTOR (3 downto 0);
           KBDATA 	 : in  STD_LOGIC;
           CLK 		 : in  STD_LOGIC;
			  RESET		 : in  STD_LOGIC;
           STATUS_out : out  STD_LOGIC;
           SCAN_CODE  : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;


	signal fsm_status_in_int 	: std_logic_vector (0 to 1);
	signal fsm_control_out_int : std_logic_vector (0 to 3);
	
	signal dp_status_out_int 	: std_logic;

	alias CNT_LES_10 is dp_status_out_int;

	alias INIT_COUNT		is fsm_control_out_int(0);
	alias CODE_READY_OUT	is fsm_control_out_int(1);
	alias LOAD_BIT_OUT	is fsm_control_out_int(2);
	alias INC_COUNT 		is fsm_control_out_int(3);

begin

	
	fsm_status_in_int <= KB_CLK & CNT_LES_10;
	
	scrFSM : ScanCodeReadFSM port map(
			STATUS_in 	=> fsm_status_in_int,
	      CLK 			=> CLK,
	      RESET 		=> RESET,
	      CONTROL_out => fsm_control_out_int,
	      DEBUG_out 	=> open
	);

	scfDP	: ScanCodeReadDataPath port map(
			CONTROL_in => fsm_control_out_int,
			KBDATA	  => KB_DAT,
			CLK		  => CLK,
			RESET		  => RESET,
			STATUS_out => dp_status_out_int,
			SCAN_CODE  => SCAN_CODE
	);
	
	CODE_READY <= CODE_READY_OUT;


end Structural;

