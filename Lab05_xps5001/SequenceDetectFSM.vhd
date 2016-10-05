----------------------------------------------------------------------------
-- Entity:        SequenceDetectFSM
-- Written By:    Saw Xue Zheng
-- Date Created:  10/4/2016
-- Description:   Finite State Machine for a sequence detector.
--						Detects LCR, CCU, CCR
-- Revision History (date, initials, description):
-- 	4 October 16, xps5001, file created.

-- Dependencies: None
----------------------------------------------------------------------------



library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

entity SequenceDetectFSM is
    Port ( STATUS_in 	: in  STD_LOGIC_VECTOR (0 to 3);
           CLK 			: in  STD_LOGIC;
           RESET 			: in  STD_LOGIC;
           CONTROL_out 	: out  STD_LOGIC_VECTOR (0 to 2);
           DEBUG_out 	: out  STD_LOGIC_VECTOR (3 downto 0));
end SequenceDetectFSM;

architecture Behavioral of SequenceDetectFSM is

	--defines all the states
	type STATE_TYPE is (RESETSTATE, START, L_STATE, LC_STATE, LCR_STATE, C_STATE, CC_STATE, CCU_STATE, CCR_STATE);
	
	signal presentState : STATE_TYPE;
	signal nextState	  : STATE_TYPE;
	
	--inputs for FSM
	alias L is STATUS_in(0);
	alias R is STATUS_in(1);
	alias C is STATUS_in(2);
	alias U is STATUS_in(3);
	
	--outputs for FSM
	alias SEQ1 is CONTROL_OUT(0);
	alias SEQ2 is CONTROL_OUT(1);
	alias SEQ3 is CONTROL_OUT(2);
	
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
				SEQ1 <= '0';
				SEQ2 <= '0';
				SEQ3 <= '0';
				nextState <= START;
				DEBUG_out <= x"F";
				
			when START => 
				SEQ1 <= '0';
				SEQ2 <= '0';
				SEQ3 <= '0';
				DEBUG_out <= x"0";
				
				if (L = '1' and R = '0' and C = '0' and U = '0') then
						nextState <= L_STATE;
				elsif (L = '0' and R = '0' and C = '1' and U = '0') then
						nextState <= C_STATE;
				else 
				nextState <= START;
				end if;
				
			when L_STATE =>
				SEQ1 <= '0';
				SEQ2 <= '0';
				SEQ3 <= '0';
				DEBUG_out <= x"1";

				if ( L = '0' and R = '0' and C = '1' and U = '0') then
						nextState <= LC_STATE;
				elsif ((L = '0' and R = '0' and C = '0' and U = '0') or
						 (L = '1' and R = '0' and C = '0' and U = '0')) then
						 nextState <= L_STATE;
				else 	  --any other inputs
						nextState <= START;
				end if;

				
			when LC_STATE => 
				SEQ1 <= '0';
				SEQ2 <= '0';
				SEQ3 <= '0';
				DEBUG_out <= x"2";

				if (L = '1' and R = '0' and C = '0' and U = '0') then
						nextState <= L_STATE;
				elsif (L = '0' and R = '1' and C = '0' and U = '0') then
						nextState <= LCR_STATE;
				elsif (L = '0' and R = '0' and C = '1' and U = '0') then
						nextState <= CC_STATE;
				elsif (L = '0' and R = '0' and C = '0' and U = '0') then
						nextState <= LC_STATE;
				else 	  --any other inputs
						nextState <= START;
				end if;			
				
			when LCR_STATE => 
				SEQ1 <= '1';
				SEQ2 <= '0';
				SEQ3 <= '0';
				DEBUG_out <= x"A";	
				
				if (L = '0' and R = '0' and C = '1' and U = '0') then
						nextState <= C_STATE;
				elsif (L = '1' and R = '0' and C = '0' and U = '0') then
						nextState <= L_STATE;
				elsif (L = '0' and R = '0' and C = '0' and U = '0') then
						nextState <= LCR_STATE;
				else 	  --any other inputs
						nextState <= START;
				end if;
				
			when C_STATE =>
				SEQ1 <= '0';
				SEQ2 <= '0';
				SEQ3 <= '0';
				DEBUG_out <= x"3";
				
				if (L = '0' and R = '0' and C = '1' and U = '0') then
						nextState <= CC_STATE;
				elsif (L = '1' and R = '0' and C = '0' and U = '0') then
						nextState <= L_STATE;
				elsif (L = '0' and R = '0' and C = '0' and U = '0') then
						nextState <= C_STATE;
				else 	  --any other inputs
						nextState <= START;
				end if;				
				
			when CC_STATE =>
				SEQ1 <= '0';
				SEQ2 <= '0';
				SEQ3 <= '0';
				DEBUG_out <= x"4";	
				
				if (L = '0' and R = '0' and C = '0' and U = '1') then
						nextState <= CCU_STATE;
				elsif(L = '0' and R = '1' and C = '0' and U = '0') then
						nextState <= CCR_STATE;		
				elsif (L = '1' and R = '0' and C = '0' and U = '0') then
						nextState <= L_STATE;
				elsif ((L = '0' and R = '0' and C = '0' and U = '0') or
						 (L = '0' and R = '0' and C = '1' and U = '0')) then
						nextState <= CC_STATE;
				else 	  --any other inputs
						nextState <= START;
				end if;	
				
			when CCU_STATE =>
				SEQ1 <= '0';
				SEQ2 <= '1';
				SEQ3 <= '0';
				DEBUG_out <= x"B";	
				
				if (L = '0' and R = '0' and C = '1' and U = '0') then
						nextState <= C_STATE;
				elsif (L = '1' and R = '0' and C = '0' and U = '0') then
						nextState <= L_STATE;
				elsif (L = '0' and R = '0' and C = '0' and U = '0')then
						nextState <= CCU_STATE;
				else 	  --any other inputs
						nextState <= START;
				end if;
			when CCR_STATE =>
				SEQ1 <= '0';
				SEQ2 <= '0';
				SEQ3 <= '1';
				DEBUG_out <= x"C";	
				
				if (L = '0' and R = '0' and C = '1' and U = '0') then
						nextState <= C_STATE;
				elsif (L = '1' and R = '0' and C = '0' and U = '0') then
						nextState <= L_STATE;
				elsif (L = '0' and R = '0' and C = '0' and U = '0')then
						nextState <= CCR_STATE;
				else 	  --any other inputs
						nextState <= START;
				end if;				
		end case;
	end process;
				
				

end Behavioral;

