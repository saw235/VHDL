----------------------------------------------------------------------------
-- Entity:        TrafficLightController
-- Written By:    Saw Xue Zheng
-- Date Created:  10/4/2016
-- Description:   Finite State Machine for a Traffic Light Controller 
--						has 3 modes -- 1) Normal Operating
--											2)	Blink0 
--											3) Blink1

-- Revision History (date, initials, description):
-- 	4 October 16, xps5001, file created.

-- Dependencies: None
----------------------------------------------------------------------------



library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use XPS5001_Library.XPS5001_Components.ALL;

entity TrafficLightController is
    Port ( STATUS_in 	: in  STD_LOGIC_VECTOR (0 to 6);
           CLK 			: in  STD_LOGIC;
           RESET 			: in  STD_LOGIC;
           CONTROL_out 	: out  STD_LOGIC_VECTOR (0 to 6);
           DEBUG_out 	: out  STD_LOGIC_VECTOR (7 downto 0));
end TrafficLightController;

architecture Behavioral of TrafficLightController is

	--defines all the states
	type STATE_TYPE is (RESETSTATE, START_SEQ1, PRE_0, PRE_1, PRE_2, PRE_3, PRE_4, PRE_5, NORM_0, NORM_1, NORM_2, NORM_3, NORM_4, NORM_5,
											  START_SEQ2, PRE_B0_0, PRE_B0_1, BLINK0_0, BLINK0_1,
											  START_SEQ3, PRE_B1_0, PRE_B1_1, BLINK1_0, BLINK1_1);
	
	signal presentState : STATE_TYPE;
	signal nextState	  : STATE_TYPE;
	
	--inputs for FSM
	alias eq_1s 		is STATUS_in(0);
	alias eq_2s 		is STATUS_in(1);
	alias eq_5s 		is STATUS_in(2);
	alias eq_half_s 	is STATUS_in(3);
	
	alias seq 			is STATUS_in(4 to 6);

	
	--outputs for FSM
	alias CLR_tmr 	is CONTROL_OUT(6);
	alias R_ns 		is CONTROL_OUT(2);
	alias R_ew 		is CONTROL_OUT(5);
	alias Y_ns  	is CONTROL_OUT(1);
	alias Y_ew 		is CONTROL_OUT(4);
	alias G_ns  	is CONTROL_OUT(0);
	alias G_ew 		is CONTROL_OUT(3);
	

begin
	
	--state Register
	process (CLK) is
	begin 
		if (CLK'event and CLK='1') then
			if RESET = '1' then 
				presentState <= RESETSTATE;
			else
				presentState <= nextState;
			end if;
		end if;
	end process;
	
	--nextState Logic
	process (presentState, STATUS_in) is
	begin
		case presentState is 
			when ResetState =>
				CLR_tmr 	<= '0';
				R_ns 			<= '0';
				R_ew 			<= '0';
				Y_ns  		<= '0';
				Y_ew 			<= '0';
				G_ns  		<= '0';
				G_ew 			<= '0';
				nextState 	<= START_SEQ1;
				DEBUG_out	 <= x"FF";
				
			-----start SEQUENCE 1------	
			-- STATES: START_SEQ1, PRE_0, PRE_1, PRE_2, PRE_3, PRE_4, PRE_5,
			--			   			  NORM_0, NORM_1, NORM_2, NORM_3, NORM_4, NORM_5
			when START_SEQ1 => 
				CLR_tmr 	<= '0';
				R_ns 			<= '0';
				R_ew 			<= '0';
				Y_ns  		<= '0';
				Y_ew 			<= '0';
				G_ns  		<= '0';
				G_ew 			<= '0';
				nextState <= PRE_0;
				DEBUG_out 	<= x"AA";
			
			when PRE_0 => 
				CLR_tmr 		<= '1';
				R_ns 			<= '0';
				R_ew 			<= '0';
				Y_ns  		<= '0';
				Y_ew 			<= '0';
				G_ns  		<= '0';
				G_ew 			<= '0';
				nextState <= NORM_0;
				DEBUG_out 	<= x"A0";
			
			when NORM_0 =>
				CLR_tmr 		<= '0';
				R_ns 			<= '1';
				R_ew 			<= '1';
				Y_ns  		<= '0';
				Y_ew 			<= '0';
				G_ns  		<= '0';
				G_ew 			<= '0';
				DEBUG_out 	<= x"10";

				if (eq_1s = '1' and eq_2s = '0' and eq_5s = '0' and eq_half_s = '0') then
						nextState <= PRE_1;
						
				else 	  --any other inputs
						nextState <= NORM_0;
				end if;
				
			when PRE_1 => 
				CLR_tmr 		<= '1';
				R_ns 			<= '0';
				R_ew 			<= '0';
				Y_ns  		<= '0';
				Y_ew 			<= '0';
				G_ns  		<= '0';
				G_ew 			<= '0';
				DEBUG_out 	<= x"A1";
				
				if (seq = "010") then
						nextState <= START_SEQ2;
				elsif (seq = "001") then
						nextState <= START_SEQ3;
				else 	  --any other inputs
						nextState <= NORM_1;
				end if;
				
			when NORM_1 => 
				CLR_tmr		<= '0';
				R_ns 			<= '0';
				R_ew 			<= '1';
				Y_ns  		<= '0';
				Y_ew 			<= '0';
				G_ns  		<= '1';
				G_ew 			<= '0';
				DEBUG_out 	<= x"11";

				if (eq_1s = '0' and eq_2s = '0' and eq_5s = '1' and eq_half_s = '0') then
						nextState <= PRE_2;
				else 	  --any other inputs
						nextState <= NORM_1;
				end if;
				
			when PRE_2 => 
				CLR_tmr 		<= '1';
				R_ns 			<= '0';
				R_ew 			<= '0';
				Y_ns  		<= '0';
				Y_ew 			<= '0';
				G_ns  		<= '0';
				G_ew 			<= '0';
				nextState <= NORM_2;
				DEBUG_out 	<= x"A2";
				
			when NORM_2 => 
				CLR_tmr	 	<= '0';
				R_ns 			<= '0';
				R_ew 			<= '1';
				Y_ns  		<= '1';
				Y_ew 			<= '0';
				G_ns  		<= '0';
				G_ew 			<= '0';
				DEBUG_out 	<= x"12";	
				
				if (eq_1s = '0' and eq_2s = '1' and eq_5s = '0' and eq_half_s = '0') then
						nextState <= PRE_3;
				else 	  --any other inputs
						nextState <= NORM_2;
				end if;
			
			when PRE_3 => 
				CLR_tmr 		<= '1';
				R_ns 			<= '0';
				R_ew 			<= '0';
				Y_ns  		<= '0';
				Y_ew 			<= '0';
				G_ns  		<= '0';
				G_ew 			<= '0';
				nextState <= NORM_3;
				DEBUG_out 	<= x"A3";
				
			when NORM_3 =>
				CLR_tmr 		<= '0';
				R_ns 			<= '1';
				R_ew 			<= '1';
				Y_ns  		<= '0';
				Y_ew 			<= '0';
				G_ns  		<= '0';
				G_ew 			<= '0';
				DEBUG_out 	<= x"13";
				
				if (eq_1s = '1' and eq_2s = '0' and eq_5s = '0' and eq_half_s = '0') then
						nextState <= PRE_4;
				else 	  --any other inputs
						nextState <= NORM_3;
				end if;
				
			when PRE_4 => 
				CLR_tmr 		<= '1';
				R_ns 			<= '0';
				R_ew 			<= '0';
				Y_ns  		<= '0';
				Y_ew 			<= '0';
				G_ns  		<= '0';
				G_ew 			<= '0';
				DEBUG_out 	<= x"A4";
				
				if (seq = "010") then
						nextState <= START_SEQ2;
				elsif (seq = "001") then
						nextState <= START_SEQ3;
				else 	  --any other inputs
						nextState <= NORM_4;
				end if;
			
			when NORM_4 =>
				CLR_tmr 		<= '0';
				R_ns 			<= '1';
				R_ew 			<= '0';
				Y_ns  		<= '0';
				Y_ew 			<= '0';
				G_ns  		<= '0';
				G_ew 			<= '1';
				DEBUG_out 	<= x"14";
				
				if (eq_1s = '0' and eq_2s = '0' and eq_5s = '1' and eq_half_s = '0') then
						nextState <= PRE_5;
				else 	  --any other inputs
						nextState <= NORM_4;
				end if;
			

			when PRE_5 => 
				CLR_tmr 		<= '1';
				R_ns 			<= '0';
				R_ew 			<= '0';
				Y_ns  		<= '0';
				Y_ew 			<= '0';
				G_ns  		<= '0';
				G_ew 			<= '0';
				nextState <= NORM_5;
				DEBUG_out 	<= x"A5";		
				
			when NORM_5 =>
				CLR_tmr 		<= '0';
				R_ns 			<= '1';
				R_ew 			<= '0';
				Y_ns  		<= '0';
				Y_ew 			<= '1';
				G_ns  		<= '0';
				G_ew 			<= '0';
				DEBUG_out 	<= x"15";
				
				if (eq_1s = '0' and eq_2s = '1' and eq_5s = '0' and eq_half_s = '0') then
						nextState <= PRE_0;
				else 	  --any other inputs
						nextState <= NORM_5;
				end if;
			----- End SEQUENCE 1------	
			-----start SEQUENCE 2------	
			--STATES: START_SEQ2, PRE_B0_0, PRE_B0_1, BLINK0_0, BLINK0_1
			when START_SEQ2 => 
				CLR_tmr 		<= '0';
				R_ns 			<= '0';
				R_ew 			<= '0';
				Y_ns  		<= '0';
				Y_ew 			<= '0';
				G_ns  		<= '0';
				G_ew 			<= '0';
				nextState <= PRE_B0_0;
				DEBUG_out 	<= x"BB";
			
			when PRE_B0_0 => 
				CLR_tmr 		<= '1';
				R_ns 			<= '0';
				R_ew 			<= '0';
				Y_ns  		<= '0';
				Y_ew 			<= '0';
				G_ns  		<= '0';
				G_ew 			<= '0';

				DEBUG_out 	<= x"B0";
				
				if (seq = "100") then
						nextState <= START_SEQ1;
				else 	  --any other inputs
						nextState <= BLINK0_0;
				end if;				
				
			
			when BLINK0_0 =>
				CLR_tmr 		<= '0';
				R_ns 			<= '0';
				R_ew 			<= '1';
				Y_ns  		<= '1';
				Y_ew 			<= '0';
				G_ns  		<= '0';
				G_ew 			<= '0';
				DEBUG_out 	<= x"20";

				if (eq_1s = '0' and eq_2s = '0' and eq_5s = '0' and eq_half_s = '1') then
						nextState <= PRE_B0_1;
						
				else 	  --any other inputs
						nextState <= BLINK0_0;
				end if;
				
			when PRE_B0_1 => 
				CLR_tmr 		<= '1';
				R_ns 			<= '0';
				R_ew 			<= '0';
				Y_ns  		<= '0';
				Y_ew 			<= '0';
				G_ns  		<= '0';
				G_ew 			<= '0';
				nextState <= BLINK0_1;
				DEBUG_out 	<= x"B1";
				
			when BLINK0_1 => 
				CLR_tmr		<= '0';
				R_ns 			<= '0';
				R_ew 			<= '0';
				Y_ns  		<= '0';
				Y_ew 			<= '0';
				G_ns  		<= '0';
				G_ew 			<= '0';
				DEBUG_out 	<= x"21";

				if (eq_1s = '0' and eq_2s = '0' and eq_5s = '0' and eq_half_s = '1') then
						nextState <= PRE_B0_0;
				else 	  --any other inputs
						nextState <= BLINK0_1;
				end if;
			
			----- End SEQUENCE 2------		
			-----start SEQUENCE 3------	
			--STATES: START_SEQ3, PRE_B1_0, PRE_B1_1, BLINK1_0, BLINK1_1
			when START_SEQ3 => 
				CLR_tmr 	<= '0';
				R_ns 			<= '0';
				R_ew 			<= '0';
				Y_ns  		<= '0';
				Y_ew 			<= '0';
				G_ns  		<= '0';
				G_ew 			<= '0';
				nextState <= PRE_B1_0;
				DEBUG_out 	<= x"CC";
			
			when PRE_B1_0 => 
				CLR_tmr 		<= '1';
				R_ns 			<= '0';
				R_ew 			<= '0';
				Y_ns  		<= '0';
				Y_ew 			<= '0';
				G_ns  		<= '0';
				G_ew 			<= '0';
				nextState <= BLINK1_0;
				DEBUG_out 	<= x"C0";
				
				if (seq = "100") then
						nextState <= START_SEQ1;
				else 	  --any other inputs
						nextState <= BLINK1_0;
				end if;				
			
			when BLINK1_0 =>
				CLR_tmr 		<= '0';
				R_ns 			<= '1';
				R_ew 			<= '0';
				Y_ns  		<= '0';
				Y_ew 			<= '1';
				G_ns  		<= '0';
				G_ew 			<= '0';
				DEBUG_out 	<= x"30";

				if (eq_1s = '0' and eq_2s = '0' and eq_5s = '0' and eq_half_s = '1') then
						nextState <= PRE_B1_1;
						
				else 	  --any other inputs
						nextState <= BLINK1_0;
				end if;
				
			when PRE_B1_1 => 
				CLR_tmr 		<= '1';
				R_ns 			<= '0';
				R_ew 			<= '0';
				Y_ns  		<= '0';
				Y_ew 			<= '0';
				G_ns  		<= '0';
				G_ew 			<= '0';
				nextState <= BLINK1_1;
				DEBUG_out 	<= x"C1";
				
			when BLINK1_1 => 
				CLR_tmr		<= '0';
				R_ns 			<= '0';
				R_ew 			<= '0';
				Y_ns  		<= '0';
				Y_ew 			<= '0';
				G_ns  		<= '0';
				G_ew 			<= '0';
				DEBUG_out 	<= x"31";

				if (eq_1s = '0' and eq_2s = '0' and eq_5s = '0' and eq_half_s = '1') then
						nextState <= PRE_B1_0;
				else 	  --any other inputs
						nextState <= BLINK1_1;
				end if;
			
			----- End SEQUENCE 3------				
		end case;
	end process;
				
				

end Behavioral;

