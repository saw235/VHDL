----------------------------------------------------------------------------
-- Entity:        PS2KBFSM
-- Written By:    Saw Xue Zheng
-- Date Created:  10/22/2016
-- Description:   Finite State Machine for a PS2KBProcessor.

-- Revision History (date, initials, description):
-- 	23 October 16, xps5001, file created.

-- Dependencies: None
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PS2KBFSM is
    Port ( STATUS_in 	: in  STD_LOGIC_VECTOR (0 to 8);
           CLK 			: in  STD_LOGIC;
           RESET 			: in  STD_LOGIC;
           CONTROL_out 	: out  STD_LOGIC_VECTOR (0 to 10);
           DEBUG_out 	: out  STD_LOGIC_VECTOR (7 downto 0));
end PS2KBFSM;

architecture Behavioral of PS2KBFSM is

	--defines all the states
	type STATE_TYPE is (RESETSTATE, IDLE, CHECKBUF_0, 
							  CHECKKEYPRESSED, CHECKKEYRELEASED, 
							  UPKEYPRESSED, UPKEYRELEASED,
							  DOWNKEYPRESSED, DOWNKEYRELEASED,
							  LEFTKEYPRESSED, LEFTKEYRELEASED,
							  RIGHTKEYPRESSED, RIGHTKEYRELEASED,
							  SHIFTKEYPRESSED, SHIFTKEYRELEASED,
							  WAIT_1, WAIT_2,
							  SHIFTBUF_0, SHIFTBUF_1, SHIFTBUF_2);
							 
	signal presentState : STATE_TYPE;
	signal nextState	  : STATE_TYPE;
	
	--inputs for FSM
	alias CODEREADY		is Status_in(0);
	alias SCANCODE			is Status_in(1 to 8);

	--outputs for FSM
	alias SHIFTBYTE		is CONTROL_out(0);
	
	alias UPPRESSED		is CONTROL_out(1);
	alias UPRELEASED		is CONTROL_out(2);
	
	alias DOWNPRESSED 	is CONTROL_out(3);
	alias DOWNRELEASED	is CONTROL_out(4);
	
	alias LEFTPRESSED 	is CONTROL_out(5);
	alias LEFTRELEASED	is CONTROL_out(6);
	
	alias RIGHTPRESSED 	is CONTROL_out(7);
	alias RIGHTRELEASED	is CONTROL_out(8);
	
	alias SHIFTPRESSED	is CONTROL_out(9);
	alias SHIFTRELEASED	is CONTROL_out(10);
	

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
			when RESETSTATE =>
				
				SHIFTBYTE		<= '0';
				UPPRESSED		<= '0';
				UPRELEASED		<= '0';
				DOWNPRESSED 	<= '0';
				DOWNRELEASED	<= '0';
				LEFTPRESSED 	<= '0';
				LEFTRELEASED	<= '0';
				RIGHTPRESSED 	<= '0';
				RIGHTRELEASED	<= '0';
				SHIFTPRESSED	<= '0';
				SHIFTRELEASED	<= '0';
				
				nextState <= IDLE;
				
			when IDLE =>
				SHIFTBYTE		<= '0';
				UPPRESSED		<= '0';
				UPRELEASED		<= '0';
				DOWNPRESSED 	<= '0';
				DOWNRELEASED	<= '0';
				LEFTPRESSED 	<= '0';
				LEFTRELEASED	<= '0';
				RIGHTPRESSED 	<= '0';
				RIGHTRELEASED	<= '0';
				SHIFTPRESSED	<= '0';
				SHIFTRELEASED	<= '0';
				
				if (CODEREADY = '1') then
					nextState <= SHIFTBUF_0;
				else
					nextState <= IDLE;
				end if;
			
			when CHECKBUF_0 =>
				SHIFTBYTE		<= '0';
				UPPRESSED		<= '0';
				UPRELEASED		<= '0';
				DOWNPRESSED 	<= '0';
				DOWNRELEASED	<= '0';
				LEFTPRESSED 	<= '0';
				LEFTRELEASED	<= '0';
				RIGHTPRESSED 	<= '0';
				RIGHTRELEASED	<= '0';
				SHIFTPRESSED	<= '0';
				SHIFTRELEASED	<= '0';	
				
				if (SCANCODE = x"E0") then
					nextState <= WAIT_1;
				elsif (SCANCODE = x"F0") then
					nextState <= WAIT_2;
				elsif (SCANCODE = x"75") then
					nextState <= UPKEYPRESSED;
				elsif (SCANCODE = x"72") then
					nextState <= DOWNKEYPRESSED;
				elsif (SCANCODE = x"6b") then
					nextState <= LEFTKEYPRESSED;
				elsif (SCANCODE = x"74") then
					nextState <= RIGHTKEYPRESSED;
				elsif (SCANCODE = x"12") then
					nextState <= SHIFTKEYPRESSED;		
				else
					nextState <= IDLE;
				end if;					
				
			when CHECKKEYPRESSED =>
				SHIFTBYTE		<= '0';
				UPPRESSED		<= '0';
				UPRELEASED		<= '0';
				DOWNPRESSED 	<= '0';
				DOWNRELEASED	<= '0';
				LEFTPRESSED 	<= '0';
				LEFTRELEASED	<= '0';
				RIGHTPRESSED 	<= '0';
				RIGHTRELEASED	<= '0';
				SHIFTPRESSED	<= '0';
				SHIFTRELEASED	<= '0';	
			
				if (SCANCODE = x"75") then
					nextState <= UPKEYPRESSED;
				elsif (SCANCODE = x"72") then
					nextState <= DOWNKEYPRESSED;
				elsif (SCANCODE = x"6b") then
					nextState <= LEFTKEYPRESSED;
				elsif (SCANCODE = x"74") then
					nextState <= RIGHTKEYPRESSED;
				elsif (SCANCODE = x"12") then
					nextState <= SHIFTKEYPRESSED;
				elsif (SCANCODE = x"F0") then
					nextState <= WAIT_2;					
				else
					nextState <= IDLE;
				end if;					
			
			when CHECKKEYRELEASED =>
				SHIFTBYTE		<= '0';
				UPPRESSED		<= '0';
				UPRELEASED		<= '0';
				DOWNPRESSED 	<= '0';
				DOWNRELEASED	<= '0';
				LEFTPRESSED 	<= '0';
				LEFTRELEASED	<= '0';
				RIGHTPRESSED 	<= '0';
				RIGHTRELEASED	<= '0';
				SHIFTPRESSED	<= '0';
				SHIFTRELEASED	<= '0';
			
				if (SCANCODE = x"75") then
					nextState <= UPKEYRELEASED;
				elsif (SCANCODE = x"72") then
					nextState <= DOWNKEYRELEASED;
				elsif (SCANCODE = x"6b") then
					nextState <= LEFTKEYRELEASED;
				elsif (SCANCODE = x"74") then
					nextState <= RIGHTKEYRELEASED;
				elsif (SCANCODE = x"12") then
					nextState <= SHIFTKEYRELEASED;					
				else
					nextState <= IDLE;
				end if;				
			
			when UPKEYPRESSED =>
				SHIFTBYTE		<= '0';
				UPPRESSED		<= '1';
				UPRELEASED		<= '0';
				DOWNPRESSED 	<= '0';
				DOWNRELEASED	<= '0';
				LEFTPRESSED 	<= '0';
				LEFTRELEASED	<= '0';
				RIGHTPRESSED 	<= '0';
				RIGHTRELEASED	<= '0';
				SHIFTPRESSED	<= '0';
				SHIFTRELEASED	<= '0';
				
				nextState <= IDLE;				
			
			when UPKEYRELEASED =>
				SHIFTBYTE		<= '0';
				UPPRESSED		<= '0';
				UPRELEASED		<= '1';
				DOWNPRESSED 	<= '0';
				DOWNRELEASED	<= '0';
				LEFTPRESSED 	<= '0';
				LEFTRELEASED	<= '0';
				RIGHTPRESSED 	<= '0';
				RIGHTRELEASED	<= '0';
				SHIFTPRESSED	<= '0';
				SHIFTRELEASED	<= '0';
			
				nextState <= IDLE;
			
			when DOWNKEYPRESSED =>
				SHIFTBYTE		<= '0';
				UPPRESSED		<= '0';
				UPRELEASED		<= '0';
				DOWNPRESSED 	<= '1';
				DOWNRELEASED	<= '0';
				LEFTPRESSED 	<= '0';
				LEFTRELEASED	<= '0';
				RIGHTPRESSED 	<= '0';
				RIGHTRELEASED	<= '0';
				SHIFTPRESSED	<= '0';
				SHIFTRELEASED	<= '0';
				
				nextState <= IDLE;				
				
			when DOWNKEYRELEASED =>
				SHIFTBYTE		<= '0';
				UPPRESSED		<= '0';
				UPRELEASED		<= '0';
				DOWNPRESSED 	<= '0';
				DOWNRELEASED	<= '1';
				LEFTPRESSED 	<= '0';
				LEFTRELEASED	<= '0';
				RIGHTPRESSED 	<= '0';
				RIGHTRELEASED	<= '0';
				SHIFTPRESSED	<= '0';
				SHIFTRELEASED	<= '0';
			
				nextState <= IDLE;
				
			when LEFTKEYPRESSED =>
				SHIFTBYTE		<= '0';
				UPPRESSED		<= '0';
				UPRELEASED		<= '0';
				DOWNPRESSED 	<= '0';
				DOWNRELEASED	<= '0';
				LEFTPRESSED 	<= '1';
				LEFTRELEASED	<= '0';
				RIGHTPRESSED 	<= '0';
				RIGHTRELEASED	<= '0';
				SHIFTPRESSED	<= '0';
				SHIFTRELEASED	<= '0';

				nextState <= IDLE;				
				
			when LEFTKEYRELEASED =>
				SHIFTBYTE		<= '0';
				UPPRESSED		<= '0';
				UPRELEASED		<= '0';
				DOWNPRESSED 	<= '0';
				DOWNRELEASED	<= '0';
				LEFTPRESSED 	<= '0';
				LEFTRELEASED	<= '1';
				RIGHTPRESSED 	<= '0';
				RIGHTRELEASED	<= '0';
				SHIFTPRESSED	<= '0';
				SHIFTRELEASED	<= '0';

				nextState <= IDLE;
				
			when RIGHTKEYPRESSED =>
				SHIFTBYTE		<= '0';
				UPPRESSED		<= '0';
				UPRELEASED		<= '0';
				DOWNPRESSED 	<= '0';
				DOWNRELEASED	<= '0';
				LEFTPRESSED 	<= '0';
				LEFTRELEASED	<= '0';
				RIGHTPRESSED 	<= '1';
				RIGHTRELEASED	<= '0';
				SHIFTPRESSED	<= '0';
				SHIFTRELEASED	<= '0';

				nextState <= IDLE;

			when RIGHTKEYRELEASED =>
				SHIFTBYTE		<= '0';
				UPPRESSED		<= '0';
				UPRELEASED		<= '0';
				DOWNPRESSED 	<= '0';
				DOWNRELEASED	<= '0';
				LEFTPRESSED 	<= '0';
				LEFTRELEASED	<= '0';
				RIGHTPRESSED 	<= '0';
				RIGHTRELEASED	<= '1';
				SHIFTPRESSED	<= '0';
				SHIFTRELEASED	<= '0';

				nextState <= IDLE;

			when SHIFTKEYPRESSED =>
				SHIFTBYTE		<= '0';
				UPPRESSED		<= '0';
				UPRELEASED		<= '0';
				DOWNPRESSED 	<= '0';
				DOWNRELEASED	<= '0';
				LEFTPRESSED 	<= '0';
				LEFTRELEASED	<= '0';
				RIGHTPRESSED 	<= '0';
				RIGHTRELEASED	<= '0';
				SHIFTPRESSED	<= '1';
				SHIFTRELEASED	<= '0';

				nextState <= IDLE;
				
			when SHIFTKEYRELEASED =>
				SHIFTBYTE		<= '0';
				UPPRESSED		<= '0';
				UPRELEASED		<= '0';
				DOWNPRESSED 	<= '0';
				DOWNRELEASED	<= '0';
				LEFTPRESSED 	<= '0';
				LEFTRELEASED	<= '0';
				RIGHTPRESSED 	<= '0';
				RIGHTRELEASED	<= '0';
				SHIFTPRESSED	<= '0';
				SHIFTRELEASED	<= '1';
			
				nextState <= IDLE;

			when WAIT_1 =>
				SHIFTBYTE		<= '0';
				UPPRESSED		<= '0';
				UPRELEASED		<= '0';
				DOWNPRESSED 	<= '0';
				DOWNRELEASED	<= '0';
				LEFTPRESSED 	<= '0';
				LEFTRELEASED	<= '0';
				RIGHTPRESSED 	<= '0';
				RIGHTRELEASED	<= '0';
				SHIFTPRESSED	<= '0';
				SHIFTRELEASED	<= '0';

				if (CODEREADY = '1') then
					nextState <= SHIFTBUF_1;
				else
					nextState <= WAIT_1;
				end if;				


			
			when WAIT_2 =>
				SHIFTBYTE		<= '0';
				UPPRESSED		<= '0';
				UPRELEASED		<= '0';
				DOWNPRESSED 	<= '0';
				DOWNRELEASED	<= '0';
				LEFTPRESSED 	<= '0';
				LEFTRELEASED	<= '0';
				RIGHTPRESSED 	<= '0';
				RIGHTRELEASED	<= '0';
				SHIFTPRESSED	<= '0';
				SHIFTRELEASED	<= '0';
				
				if (CODEREADY = '1') then
					nextState <= SHIFTBUF_2;
				else
					nextState <= WAIT_2;
				end if;								


			when SHIFTBUF_0 =>
				SHIFTBYTE		<= '1';
				UPPRESSED		<= '0';
				UPRELEASED		<= '0';
				DOWNPRESSED 	<= '0';
				DOWNRELEASED	<= '0';
				LEFTPRESSED 	<= '0';
				LEFTRELEASED	<= '0';
				RIGHTPRESSED 	<= '0';
				RIGHTRELEASED	<= '0';
				SHIFTPRESSED	<= '0';
				SHIFTRELEASED	<= '0';
			
				nextState <= CHECKBUF_0;
			
			
			when SHIFTBUF_1 =>
				SHIFTBYTE		<= '1';
				UPPRESSED		<= '0';
				UPRELEASED		<= '0';
				DOWNPRESSED 	<= '0';
				DOWNRELEASED	<= '0';
				LEFTPRESSED 	<= '0';
				LEFTRELEASED	<= '0';
				RIGHTPRESSED 	<= '0';
				RIGHTRELEASED	<= '0';
				SHIFTPRESSED	<= '0';
				SHIFTRELEASED	<= '0';
			
				nextState <= CHECKKEYPRESSED;
			
			
			when SHIFTBUF_2 =>
				SHIFTBYTE		<= '1';
				UPPRESSED		<= '0';
				UPRELEASED		<= '0';
				DOWNPRESSED 	<= '0';
				DOWNRELEASED	<= '0';
				LEFTPRESSED 	<= '0';
				LEFTRELEASED	<= '0';
				RIGHTPRESSED 	<= '0';
				RIGHTRELEASED	<= '0';
				SHIFTPRESSED	<= '0';
				SHIFTRELEASED	<= '0';
			
				nextState <= CHECKKEYRELEASED;

				
		end case;
	end process;

end Behavioral;

