----------------------------------------------------------------------------
-- Entity:        Lab07_xps5001_kmr5802
-- Written By:    Saw Xue Zheng
-- Date Created:  10/24/2016
-- Description:   Component to process the scan codes from PS2 Keyboards.
--
-- Revision History (date, initials, description):
-- 	24 Oct 16, xps5001, file created.

-- Dependencies:
--		PS2KBFSM
--		PS2KBDP
----------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ScanCodeProcessor is
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
end ScanCodeProcessor;

architecture Structural of ScanCodeProcessor is

	component PS2KBFSM is
		 Port ( STATUS_in 	: in  STD_LOGIC_VECTOR (0 to 8);
				  CLK 			: in  STD_LOGIC;
				  RESET 			: in  STD_LOGIC;
				  CONTROL_out 	: out  STD_LOGIC_VECTOR (0 to 10);
				  DEBUG_out 	: out  STD_LOGIC_VECTOR (7 downto 0));
	end component;

	component PS2KBDP is
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
	end component;	
	
	signal dp_status_out_int 	: STD_LOGIC_VECTOR (0 to 8);
	signal fsm_control_out_int : STD_LOGIC_VECTOR (0 to 10);	
	
begin
	
	ps2fsm : PS2KBFSM port map(
		STATUS_in 	=> dp_status_out_int,
		CLK 			=> CLK,
	   RESET 		=> RESET,
	   CONTROL_out => fsm_control_out_int,
	   DEBUG_out 	=> open
	);
	
	ps2dp : PS2KBDP port map(
		CLK			  => CLK,
		RESET			  => RESET,
	   CODEREADY_in  => CodeReady_in,
	   Control_in 	  => fsm_control_out_int,
	   ScanCode_in	  => ScanCode_in,
	   Status_out 	  => dp_status_out_int,
	   Last4ScanCode => Last4ScanCode,
	   UP				  => UP,
		DOWN			  => DOWN,
		LEFT			  => LEFT,
		RIGHT			  => RIGHT,
		SHIFT			  => SHIFT
	);
	

end Structural;

