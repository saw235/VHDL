----------------------------------------------------------------------------
-- Entity:        ScanCodeReadDataPath
-- Written By:    Saw Xue Zheng
-- Date Created:  10/22/2016
-- Description:   DataPath for PS2 keyboard scancode reader

-- Revision History (date, initials, description):
-- 	22 October 16, xps5001, file created.

-- Dependencies: None
----------------------------------------------------------------------------


library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use XPS5001_Library.XPS5001_Components.ALL;



entity ScanCodeReadDataPath is
    Port ( CONTROL_in : in  STD_LOGIC_VECTOR (0 to 3);
           KBDATA 	 : in  STD_LOGIC;
           CLK 		 : in  STD_LOGIC;
			  RESET		 : in  STD_LOGIC;
           STATUS_out : out  STD_LOGIC;
           SCAN_CODE  : out  STD_LOGIC_VECTOR (7 downto 0));
end ScanCodeReadDataPath;

architecture Structural of ScanCodeReadDataPath is
	
	alias INIT_COUNT		is CONTROL_in(0);
	alias CODE_READY_OUT	is CONTROL_in(1);
	alias LOAD_BIT_OUT	is CONTROL_in(2);
	alias INC_COUNT 		is CONTROL_in(3);
	
	
	alias CNT_LES_10 is STATUS_out;
	
	signal reg_reset_int : STD_LOGIC;
	signal counter_in 	: STD_LOGIC_VECTOR(3 downto 0);
	signal reg_out_int 	: STD_LOGIC_VECTOR(9 downto 0);
	
begin

	reg_reset_int <= '1' when (INIT_COUNT = '1' or RESET = '1') else
					     '0';
	
	
	
	reg : Reg_SIPO generic map (n => 10, clrto => '0') port map(
		 D 			=> KBDATA,			
		 SHIFT_EN 	=> LOAD_BIT_OUT,
		 CLK 			=> CLK,
		 CLR 			=> reg_reset_int,
		 Q 			=> reg_out_int
	);
	
	
	
	cnt : Counter generic map ( n => 4) port map(
			 EN 	=> INC_COUNT, 	 
	       CLK  => CLK,
	       CLR  => reg_reset_int,
	       Q 	=> counter_in
	);
	
	CNT_LES_10 <= '1' when ( unsigned(counter_in) < 10) else '0';

	SCAN_CODE <= reg_out_int(7 downto 0);
	
end Structural;

