----------------------------------------------------------------------------
-- Entity:        FilterFSM
-- Written By:    Saw Xue Zheng
-- Date Created:  11/25/2016
-- Description:   Finite State Machine for a 3x3 Kernel Filter.

-- Revision History (date, initials, description):
-- 	25 November 16, xps5001, file created.

-- Dependencies: None
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FilterFSM is
    Port ( STATUS_in 	: in  STD_LOGIC_VECTOR (0 to 4);
           CLK 			: in  STD_LOGIC;
           RESET 			: in  STD_LOGIC;
           CONTROL_out 	: out  STD_LOGIC_VECTOR (0 to 8);
           DEBUG_out 	: out  STD_LOGIC_VECTOR (3 downto 0));
end FilterFSM;

architecture Behavioral of FilterFSM is

	--defines all the states
	type STATE_TYPE is (RESETSTATE, INIT, IDLE,
							  CHK_PXCNT_0, CHK_PXCNT_1, CHK_HCNT,
							  INC_0, INC_1, INC_2, INC_3,
							  SHIFT_PRE,
							  SHIFT_0, SHIFT_1, SHIFT_2, SHIFT_3,
							  CONV_STATE,
							  CONV_LOAD, BUF_STATE, FRAME_OK);
							 
	signal presentState : STATE_TYPE;
	signal nextState	  : STATE_TYPE;
	
	--inputs for FSM
	alias FRAMESTART		is Status_in(0);
	alias ISENOUGHPX		is Status_in(1);
	alias ISENOUGHHPX		is Status_in(2);
	alias TOTALPXREACHED is Status_in(3);
	alias CONV_OK			is Status_in(4);

	--outputs for FSM
	alias SHIFTPX			is CONTROL_out(0);
	
	alias INC_CNT			is CONTROL_out(1);
	alias INC_H				is CONTROL_out(2);
	
	alias LOAD_PX		 	is CONTROL_out(3);
	
	alias CLR_H				is CONTROL_out(4);
	alias CLR_PXCNT	 	is CONTROL_out(5);
	alias CLR_KNL			is CONTROL_out(6);
	
	alias FRAMEDONE	 	is CONTROL_out(7);
	alias CONV_START		is CONTROL_out(8);
	

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
				
				SHIFTPX	 <= '0';
				INC_CNT	 <= '0';
				INC_H		 <= '0';
				LOAD_PX	 <= '0';
				CLR_H		 <= '0';
				CLR_PXCNT <= '0';
				CLR_KNL	 <= '0';
				FRAMEDONE <= '0';
				CONV_START <= '0';
				
				DEBUG_OUT <= x"F";
				
				nextState <= INIT;
				
			when INIT =>
				
				SHIFTPX	 <= '0';
				INC_CNT	 <= '0';
				INC_H		 <= '0';
				LOAD_PX	 <= '0';
				CLR_H		 <= '1';
				CLR_PXCNT <= '1';
				CLR_KNL	 <= '1';
            FRAMEDONE <= '0';
				CONV_START <= '0';				
				
				
				DEBUG_OUT <= x"D";				
				
				nextState <= IDLE;
				
			when IDLE =>
			
				SHIFTPX	 <= '0';
			   INC_CNT	 <= '0';
			   INC_H		 <= '0';
			   LOAD_PX	 <= '0';
			   CLR_H		 <= '0';
			   CLR_PXCNT <= '0';
			   CLR_KNL	 <= '0';
			   FRAMEDONE <= '0';
				CONV_START <= '0';

				
				DEBUG_OUT <= x"E";
				
				if (FRAMESTART = '1') then
					nextState <= SHIFT_PRE;
				else
					nextState <= IDLE;
				end if;
			
			when CHK_PXCNT_0 =>
			
				SHIFTPX	 <= '0';
				INC_CNT	 <= '0';
				INC_H		 <= '0';
				LOAD_PX	 <= '0';
				CLR_H		 <= '0';
				CLR_PXCNT <= '0';
				CLR_KNL	 <= '0';
				FRAMEDONE <= '0';
				CONV_START <= '0';
		
				DEBUG_OUT <= x"7";
				
				if (ISENOUGHPX = '1') then
					nextState <= CONV_STATE;
				else
					nextState <= SHIFT_0;
				end if;				
				
				
			when CHK_PXCNT_1 =>
			
				SHIFTPX	 <= '0';
				INC_CNT	 <= '0';
				INC_H		 <= '0';
				LOAD_PX	 <= '0';
				CLR_H		 <= '0';
				CLR_PXCNT <= '0';
				CLR_KNL	 <= '0';
				FRAMEDONE <= '0';
				CONV_START <= '0';
	
				DEBUG_OUT <= x"8";
				
				if (TOTALPXREACHED = '1') then
					nextState <= FRAME_OK;
				else
					nextState <= CHK_HCNT;
				end if;				
				
			when CHK_HCNT =>
			
				SHIFTPX	 <= '0';
				INC_CNT	 <= '0';
				INC_H		 <= '0';
				LOAD_PX	 <= '0';
				CLR_H		 <= '0';
				CLR_PXCNT <= '0';
				CLR_KNL	 <= '0';
				FRAMEDONE <= '0';
				CONV_START <= '0';				
				
				
				DEBUG_OUT <= x"9";
				
				if (ISENOUGHHPX = '1') then
					nextState <= CONV_STATE;
				else
					nextState <= SHIFT_2;
				end if;				
			
			when INC_0 =>
			
				SHIFTPX	 <= '0';
				INC_CNT	 <= '1';
				INC_H		 <= '1';
				LOAD_PX	 <= '0';
				CLR_H		 <= '0';
				CLR_PXCNT <= '0';
				CLR_KNL	 <= '0';
				FRAMEDONE <= '0';
				CONV_START <= '0';				
				
			
				DEBUG_OUT <= x"0";
			
				nextState <= CHK_PXCNT_0;
			
			when INC_1 =>
			
				SHIFTPX	 <= '0';
				INC_CNT	 <= '1';
				INC_H		 <= '1';
				LOAD_PX	 <= '0';
				CLR_H		 <= '0';
				CLR_PXCNT <= '0';
				CLR_KNL	 <= '0';
				FRAMEDONE <= '0';
				CONV_START <= '0';			
			
				DEBUG_OUT <= x"0";
			
				nextState <= CHK_PXCNT_1;

			when INC_2 =>
			
				SHIFTPX	 <= '0';
				INC_CNT	 <= '1';
				INC_H		 <= '1';
				LOAD_PX	 <= '0';
				CLR_H		 <= '0';
				CLR_PXCNT <= '0';
				CLR_KNL	 <= '0';
				FRAMEDONE <= '0';
				CONV_START <= '0';			
			
			
				DEBUG_OUT <= x"0";
			
				nextState <= BUF_STATE;


			when INC_3 =>
			
				SHIFTPX	 <= '0';
				INC_CNT	 <= '1';
				INC_H		 <= '1';
				LOAD_PX	 <= '0';
				CLR_H		 <= '0';
				CLR_PXCNT <= '0';
				CLR_KNL	 <= '0';
				FRAMEDONE <= '0';
				CONV_START <= '0';				
				
			
				DEBUG_OUT <= x"0";
			
				nextState <= CONV_STATE;				
			
			when SHIFT_PRE =>
			
				SHIFTPX	 <= '1';
				INC_CNT	 <= '0';
				INC_H		 <= '0';
				LOAD_PX	 <= '0';
				CLR_H		 <= '0';
				CLR_PXCNT <= '0';
				CLR_KNL	 <= '0';
				FRAMEDONE <= '0';
				CONV_START <= '0';				
				
				
				DEBUG_OUT <= x"1";
				
				nextState <= CHK_PXCNT_0;
 
			when SHIFT_0 =>
			
				SHIFTPX	 <= '1';
				INC_CNT	 <= '0';
				INC_H		 <= '0';
				LOAD_PX	 <= '0';
				CLR_H		 <= '0';
				CLR_PXCNT <= '0';
				CLR_KNL	 <= '0';
				FRAMEDONE <= '0';
				CONV_START <= '0';				
				
				
				DEBUG_OUT <= x"1";
				
				nextState <= INC_0;

			when SHIFT_1 =>
			
				SHIFTPX	 <= '1';
				INC_CNT	 <= '0';
				INC_H		 <= '0';
				LOAD_PX	 <= '0';
				CLR_H		 <= '0';
				CLR_PXCNT <= '0';
				CLR_KNL	 <= '0';
				FRAMEDONE <= '0';
				CONV_START <= '0';				
				
				
				DEBUG_OUT <= x"1";
				
				nextState <= INC_1;
				
			when SHIFT_2 =>
			
				SHIFTPX	 <= '1';
				INC_CNT	 <= '0';
				INC_H		 <= '0';
				LOAD_PX	 <= '0';
				CLR_H		 <= '0';
				CLR_PXCNT <= '0';
				CLR_KNL	 <= '0';
				FRAMEDONE <= '0';
				CONV_START <= '0';				
				
				
				DEBUG_OUT <= x"1";
				
				nextState <= INC_2;
				
			when SHIFT_3 =>
			
				SHIFTPX	 <= '1';
				INC_CNT	 <= '0';
				INC_H		 <= '0';
				LOAD_PX	 <= '0';
				CLR_H		 <= '0';
				CLR_PXCNT <= '0';
				CLR_KNL	 <= '0';
				FRAMEDONE <= '0';
				CONV_START <= '0';				
				
				
				DEBUG_OUT <= x"1";
				
				nextState <= INC_3;
				
			when CONV_STATE =>
			
				SHIFTPX	 <= '0';
				INC_CNT	 <= '0';
				INC_H		 <= '0';
				LOAD_PX	 <= '0';
				CLR_H		 <= '0';
				CLR_PXCNT <= '0';
				CLR_KNL	 <= '0';
				FRAMEDONE <= '0';		
				CONV_START <= '1';				
				

				if (CONV_OK = '1') then
					nextState <= CONV_LOAD;
				else
					nextState <= CONV_STATE;
				end if;				

			when CONV_LOAD =>
			
				SHIFTPX	 <= '0';
				INC_CNT	 <= '0';
				INC_H		 <= '0';
				LOAD_PX	 <= '1';
				CLR_H		 <= '0';
				CLR_PXCNT <= '0';
				CLR_KNL	 <= '0';
				FRAMEDONE <= '0';
				CONV_START <= '0';
				

				DEBUG_OUT <= x"B";

				nextState <= SHIFT_1;
				
				
				
			when BUF_STATE =>
			
				SHIFTPX	 <= '0';
				INC_CNT	 <= '0';
				INC_H		 <= '0';
				LOAD_PX	 <= '0';
				CLR_H		 <= '0';
				CLR_PXCNT <= '0';
				CLR_KNL	 <= '0';
				FRAMEDONE <= '0';
				CONV_START <= '0';				
				
				
				DEBUG_OUT <= x"4";
				
				nextState <= SHIFT_3;

			when FRAME_OK =>
			
				SHIFTPX	 <= '0';
				INC_CNT	 <= '0';
				INC_H		 <= '0';
				LOAD_PX	 <= '0';
				CLR_H		 <= '0';
				CLR_PXCNT <= '0';
				CLR_KNL	 <= '0';
				FRAMEDONE <= '1';
				CONV_START <= '0';				
				
				
				DEBUG_OUT <= x"A";
				
				nextState <= INIT;
				
		end case;
	end process;

end Behavioral;

