----------------------------------------------------------------------------
-- Entity:        PS2KBDP
-- Written By:    Saw Xue Zheng
-- Date Created:  10/22/2016
-- Description:   Datapath for a PS2KBProcessor.

-- Revision History (date, initials, description):
-- 	23 October 16, xps5001, file created.

-- Dependencies: XPS5001_Library
----------------------------------------------------------------------------

library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use XPS5001_Library.XPS5001_Components.ALL;

entity PS2KBDP is
    Port ( CLK					: in   STD_LOGIC;
			  RESET				: in 	 STD_LOGIC;
			  CODEREADY_in		: in 	 STD_LOGIC;
			  Control_in 		: in   STD_LOGIC_VECTOR (0 to 10);
           ScanCode_in		: in   STD_LOGIC_VECTOR (7 downto 0);
           Status_out 		: out  STD_LOGIC_VECTOR (0 to 8);
           Last4ScanCode 	: out  STD_LOGIC_VECTOR (31 downto 0);
			  UP					: out  STD_LOGIC;
			  DOWN				: out  STD_LOGIC;
			  LEFT				: out  STD_LOGIC;
			  RIGHT				: out  STD_LOGIC;
			  SHIFT				: out  STD_LOGIC);
end PS2KBDP;

architecture Structural of PS2KBDP is

	--inputs for FSM
	alias CODEREADY		is Status_out(0);
	alias SCANCODE			is Status_out(1 to 8);
	
	--outputs for FSM
	alias SHIFTBYTE		is Control_in(0);
	
	alias UPPRESSED		is Control_in(1);
	alias UPRELEASED		is Control_in(2);
	
	alias DOWNPRESSED 	is Control_in(3);
	alias DOWNRELEASED	is Control_in(4);
	
	alias LEFTPRESSED 	is Control_in(5);
	alias LEFTRELEASED	is Control_in(6);
	
	alias RIGHTPRESSED 	is Control_in(7);
	alias RIGHTRELEASED	is Control_in(8);
	
	alias SHIFTPRESSED	is Control_in(9);
	alias SHIFTRELEASED	is Control_in(10);
	
	
	
	signal reg0_int : STD_LOGIC_VECTOR(7 downto 0);
	signal reg1_int : STD_LOGIC_VECTOR(7 downto 0);
	signal reg2_int : STD_LOGIC_VECTOR(7 downto 0);
	signal reg3_int : STD_LOGIC_VECTOR(7 downto 0);
	
begin
	
	CODEREADY <= CODEREADY_in;
	SCANCODE  <= reg0_int;
	
	
	--8 bit register
	reg0 : Reg port map(
		D 	 	=> ScanCode_in,
		LOAD	=> SHIFTBYTE,
		CLK 	=> CLK,
		CLR 	=> RESET,
	   Q 		=> reg0_int
	);
	
		--8 bit register
	reg1 : Reg port map(
		D 	 	=> reg0_int,
		LOAD	=> SHIFTBYTE,
		CLK 	=> CLK,
		CLR 	=> RESET,
	   Q 		=> reg1_int
	);
	
		--8 bit register
	reg2 : Reg port map(
		D 	 	=> reg1_int,
		LOAD	=> SHIFTBYTE,
		CLK 	=> CLK,
		CLR 	=> RESET,
	   Q 		=> reg2_int
	);
	
		--8 bit register
	reg3 : Reg port map(
		D 	 	=> reg2_int,
		LOAD	=> SHIFTBYTE,
		CLK 	=> CLK,
		CLR 	=> RESET,
	   Q 		=> reg3_int
	);
	
	
	uplatch : SR_FF port map(
		S		=> UPPRESSED,
	   R 		=> UPRELEASED,
	   RESET	=> RESET,
	   CLK 	=> CLK,
	   Q		=> UP,
	   Q_bar	=> OPEN
	);
		
	downlatch : SR_FF port map(
		S		=> DOWNPRESSED,
	   R 		=> DOWNRELEASED,
	   RESET	=> RESET,
	   CLK 	=> CLK,
	   Q		=> DOWN,
	   Q_bar	=> OPEN
	);		

	leftlatch : SR_FF port map(
		S		=> LEFTPRESSED,
	   R 		=> LEFTRELEASED,
	   RESET	=> RESET,
	   CLK 	=> CLK,
	   Q		=> LEFT,
	   Q_bar	=> OPEN
	);		

	rightlatch : SR_FF port map(
		S		=> RIGHTPRESSED,
	   R 		=> RIGHTRELEASED,
	   RESET	=> RESET,
	   CLK 	=> CLK,
	   Q		=> RIGHT,
	   Q_bar	=> OPEN
	);

	shiftlatch : SR_FF port map(
		S		=> SHIFTPRESSED,
	   R 		=> SHIFTRELEASED,
	   RESET	=> RESET,
	   CLK 	=> CLK,
	   Q		=> SHIFT,
	   Q_bar	=> OPEN
	);

	
	Last4ScanCode <= reg3_int & reg2_int & reg1_int & reg0_int;
	
	
end Structural;

