----------------------------------------------------------------------------
-- Entity:        ScanCodeReadFSM
-- Written By:    Saw Xue Zheng
-- Date Created:  10/22/2016
-- Description:   Finite State Machine for a ScanCodeReader.

-- Revision History (date, initials, description):
-- 	22 October 16, xps5001, file created.

-- Dependencies: None
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ScanCodeReadFSM is
    Port ( STATUS_in 	: in  STD_LOGIC_VECTOR (0 to 2);
           CLK 			: in  STD_LOGIC;
           RESET 	    	: in  STD_LOGIC;
           CONTROL_out 	: out  STD_LOGIC_VECTOR (0 to 5);
           DEBUG_out 	: out  STD_LOGIC_VECTOR (3 downto 0));
end ScanCodeReadFSM;

architecture Behavioral of ScanCodeReadFSM is

	--defines all the states
	type STATE_TYPE is (RESETSTATE, IDLE, INIT, COMPARE, WAIT_1, WAIT_2, LOAD_BIT,
							  CLR_TIMEOUT_1, CLR_TIMEOUT_2, INC_CNT, CODE_READY);
							 
	signal presentState   : STATE_TYPE;
	signal nextState	  : STATE_TYPE;
	
	--inputs for FSM
	alias KB_CLK			is Status_in(0);
	alias CNT_LES_10		is Status_in(1);
	alias TIMEOUT		   is Status_in(2);
	
	--outputs for FSM
	alias INIT_COUNT		is CONTROL_out(0);
	alias CODE_READY_OUT	is CONTROL_out(1);
	alias LOAD_BIT_OUT	is CONTROL_out(2);
	alias INC_COUNT 		is CONTROL_out(3);
   alias TIMEOUT_EN 		is CONTROL_out(4);
	alias TIMEOUT_CLR		is CONTROL_out(5);

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
				INIT_COUNT 		<= '0';
				CODE_READY_OUT	<= '0';				
				LOAD_BIT_OUT 	<= '0';
				INC_COUNT   	<= '0';
				TIMEOUT_EN   	<= '0';
				TIMEOUT_CLR 	<= '0';
				
				nextState <= IDLE;
				
				
			when IDLE =>
			   INIT_COUNT 		<= '0';
			   CODE_READY_OUT	<= '0';	
			   LOAD_BIT_OUT 	<= '0';
			   INC_COUNT      <= '0';
			   TIMEOUT_EN   	<= '0';
				TIMEOUT_CLR 	<= '0';				
				
				if (KB_CLK = '0') then
					nextState <= INIT;
				else
					nextState <= IDLE;
				end if;
				
			when INIT =>
				INIT_COUNT 		<= '1';
				CODE_READY_OUT	<= '0';	
				LOAD_BIT_OUT 	<= '0';
				INC_COUNT   	<= '0';
				TIMEOUT_EN   	<= '0';
				TIMEOUT_CLR 	<= '0';
				
				nextState <= COMPARE;
				
			when COMPARE =>
			   INIT_COUNT 		<= '0';
			   CODE_READY_OUT	<= '0';	
			   LOAD_BIT_OUT 	<= '0';
			   INC_COUNT   	<= '0';
			   TIMEOUT_EN   	<= '0';
				TIMEOUT_CLR 	<= '0';				
			
				if (CNT_LES_10 = '1') then
					nextState <= CLR_TIMEOUT_1;
				else
					nextState <= CODE_READY;
				end if;
				
			when CLR_TIMEOUT_1 =>
				INIT_COUNT 		<= '0';
			   CODE_READY_OUT	<= '0';	
			   LOAD_BIT_OUT 	<= '0';
			   INC_COUNT   	<= '0';
			   TIMEOUT_EN   	<= '0';
				TIMEOUT_CLR 	<= '1';
				
				nextState <= WAIT_1;
			
			when WAIT_1 =>
				INIT_COUNT 		<= '0';
				CODE_READY_OUT	<= '0';	
				LOAD_BIT_OUT 	<= '0';
			   INC_COUNT  		<= '0';
			   TIMEOUT_EN   	<= '1';
				TIMEOUT_CLR 	<= '0';
				
				if (KB_CLK = '1') then
					nextState <= CLR_TIMEOUT_2;
				elsif (KB_CLK = '0'and TIMEOUT = '1') then
					nextState <= IDLE;
				else 
				    nextState <= WAIT_1;
				end if;
			
			
			when CLR_TIMEOUT_2 =>
				INIT_COUNT 		<= '0';
				CODE_READY_OUT	<= '0';	
				LOAD_BIT_OUT 	<= '0';
			   INC_COUNT  		<= '0';
			   TIMEOUT_EN   	<= '0';
				TIMEOUT_CLR 	<= '1';				
			
				nextState <= WAIT_2;
				
			when WAIT_2 =>
			   INIT_COUNT	 	<= '0';
			   CODE_READY_OUT	<= '0';	
			   LOAD_BIT_OUT 	<= '0';
			   INC_COUNT 	   <= '0';
			   TIMEOUT_EN   	<= '1';
				TIMEOUT_CLR 	<= '0';				
			
				if (KB_CLK = '0') then
					nextState <= LOAD_BIT;
				elsif (KB_CLK = '1'and TIMEOUT = '1') then
					nextState <= IDLE;
				else
				    nextState <= WAIT_2;
				end if;

			
			when LOAD_BIT =>
			   INIT_COUNT	 	<= '0';
			   CODE_READY_OUT	<= '0';	
			   LOAD_BIT_OUT 	<= '1';
			   INC_COUNT  	   <= '0';
			   TIMEOUT_EN   	<= '0';
				TIMEOUT_CLR 	<= '0';				
			
				nextState <= INC_CNT;
			
			
			when INC_CNT =>
			   INIT_COUNT 		<= '0';
			   CODE_READY_OUT	<= '0';	
			   LOAD_BIT_OUT 	<= '0';
			   INC_COUNT  	   <= '1';
			   TIMEOUT_EN   	<= '0';
				TIMEOUT_CLR 	<= '0';				
			
				nextState <= COMPARE;
			
			when CODE_READY =>
				INIT_COUNT 		<= '0';
				CODE_READY_OUT	<= '1';	
				LOAD_BIT_OUT 	<= '0';
			    INC_COUNT   	<= '0';
			    TIMEOUT_EN   	<= '0';
				TIMEOUT_CLR 	<= '0';				 
				
				if (KB_CLK = '1') then
					nextState <= IDLE;
				else
					nextState <= CODE_READY;
				end if;
				
		end case;
	end process;

end Behavioral;

