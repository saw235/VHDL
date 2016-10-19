----------------------------------------------------------------------------
-- Entity:        CandyBarFSM
-- Written By:    Saw Xue Zheng
-- Date Created:  10/9/2016
-- Description:   Finite State Machine for a CandyBarMachine.

-- Revision History (date, initials, description):
-- 	4 October 16, xps5001, file created.

-- Dependencies: None
----------------------------------------------------------------------------



library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

entity CandyBarFSM is
	    Port	( 	STATUS_in 	: in  STD_LOGIC_VECTOR (0 to 6);
					CLK 			: in  STD_LOGIC;
					RESET 		: in  STD_LOGIC;
					CONTROL_out : out  STD_LOGIC_VECTOR (0 to 6);
					DEBUG_out 	: out  STD_LOGIC_VECTOR (3 downto 0));
end CandyBarFSM;

architecture Behavioral of CandyBarFSM is

	--defines all the states
	type STATE_TYPE is (RESETSTATE, CHECKN, CHECKD, CHECKQ, INC_N, INC_D, INC_Q,
							 CHECKPURCHASE, CHECKCR, CHECKCANDY, CHECKCREDIT, SALES,
							 COINRETURN);
							 
	signal presentState : STATE_TYPE;
	signal nextState	  : STATE_TYPE;
	
	--inputs for FSM
	alias N 					is Status_in(0);
	alias D 					is Status_in(1);
	alias Q 					is Status_in(2);
	
	alias Purchase 		is Status_in(3);
	
	alias CR 				is Status_in(4);
	
	alias hasCandy 		is Status_in(5);
	alias enoughCredit 	is Status_in(6);
	
	--outputs for FSM
	alias DEC_80 			is CONTROL_out(0);
	alias INC_CRED 		is CONTROL_out(1 to 2);
	alias DEC_CANDY 		is CONTROL_out(3);
	alias INC_SALES_80 	is CONTROL_out(4);
	alias CLR_CREDIT		is CONTROL_out(5);
	alias PURCHASE_return is CONTROL_out(6);
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
				
				DEC_80 			<= '0';
				INC_CRED 		<= "00";
				DEC_CANDY 		<= '0';
				INC_SALES_80	<= '0';
				CLR_CREDIT		<= '0';
				PURCHASE_return <= '0';
				DEBUG_out		<= x"0";

				nextState 		<= CHECKN;
			when CHECKN	=>

				DEC_80 			<= '0';
				INC_CRED 		<= "00";
				DEC_CANDY 		<= '0';
				INC_SALES_80	<= '0';
				CLR_CREDIT		<= '0';
				PURCHASE_return <= '0';
				DEBUG_out		<= x"1";
				
				if ( N = '1') then
					nextState 		<= INC_N;
				else
					nextState		<= CHECKD;
				end if;
					
					
			when CHECKD =>
				DEC_80 			<= '0';
				INC_CRED 		<= "00";
				DEC_CANDY 		<= '0';
				INC_SALES_80	<= '0';
				CLR_CREDIT		<= '0';
				PURCHASE_return <= '0';
				DEBUG_out		<= x"2";		

				if ( D = '1') then
					nextState 		<= INC_D;
				else
					nextState		<= CHECKQ;
				end if;				
				
			when CHECKQ =>

				DEC_80 			<= '0';
				INC_CRED 		<= "00";
				DEC_CANDY 		<= '0';
				INC_SALES_80	<= '0';
				CLR_CREDIT		<= '0';
				PURCHASE_return <= '0';
				DEBUG_out		<= x"3";		

				if ( Q = '1') then
					nextState 		<= INC_Q;
				else
					nextState		<= CHECKPURCHASE;
				end if;				
				
			when INC_N 	=>
				DEC_80 			<= '0';
				INC_CRED 		<= "01";
				DEC_CANDY 		<= '0';
				INC_SALES_80	<= '0';
				CLR_CREDIT		<= '0';
				PURCHASE_return <= '0';
				DEBUG_out		<= x"A";			
			
				nextState 		<= CHECKD;			
			
			when INC_D	=>
				DEC_80 			<= '0';
				INC_CRED 		<= "10";
				DEC_CANDY 		<= '0';
				INC_SALES_80	<= '0';
				CLR_CREDIT		<= '0';
				PURCHASE_return <= '0';
				DEBUG_out		<= x"B";
				
				nextState 		<= CHECKQ;
			
			when INC_Q 	=>
				DEC_80 			<= '0';
				INC_CRED 		<= "11";
				DEC_CANDY 		<= '0';
				INC_SALES_80	<= '0';
				CLR_CREDIT		<= '0';
				PURCHASE_return <= '0';
				DEBUG_out		<= x"C";

				nextState 		<= CHECKPURCHASE;
			
			when CHECKPURCHASE =>
				DEC_80 			<= '0';
				INC_CRED 		<= "00";
				DEC_CANDY 		<= '0';
				INC_SALES_80	<= '0';
				CLR_CREDIT		<= '0';
				PURCHASE_return <= '0';
				DEBUG_out		<= x"4";	
				
				if ( N = '0' and D = '0' and Q = '0' and
					  Purchase = '1' and CR = '0') then
					  nextState 		<= CHECKCANDY;
				else
					  nextState 		<= CHECKCR;
				end if;
			
			when CHECKCR =>
				DEC_80 			<= '0';
				INC_CRED 		<= "00";
				DEC_CANDY 		<= '0';
				INC_SALES_80	<= '0';
				CLR_CREDIT		<= '0';
				PURCHASE_return <= '0';
				DEBUG_out		<= x"F";
				
				if (Purchase = '0' and CR = '1') then
						nextState 		<= COINRETURN;
				else
						nextState 		<= CHECKN;
				end if;		
				
			
			when CHECKCANDY =>
				DEC_80 			<= '0';
				INC_CRED 		<= "00";
				DEC_CANDY 		<= '0';
				INC_SALES_80	<= '0';
				CLR_CREDIT		<= '0';
				PURCHASE_return <= '1';
				
				DEBUG_out		<= x"5";
				
				if ( hasCandy = '1') then
					nextState 		<= CHECKCREDIT;
				else
					nextState 		<= CHECKN;
				end if;
				
			when CHECKCREDIT =>
				DEC_80 			<= '0';
				INC_CRED 		<= "00";
				DEC_CANDY 		<= '0';
				INC_SALES_80	<= '0';
				CLR_CREDIT		<= '0';
				PURCHASE_return <= '0';
				DEBUG_out		<= x"6";
				
				if ( enoughCredit = '1') then
					nextState 		<= SALES;
				else
					nextState 		<= CHECKN;
				end if;				
				
			when SALES =>
				DEC_80 			<= '1';
				INC_CRED 		<= "00";
				DEC_CANDY 		<= '1';
				INC_SALES_80	<= '1';
				CLR_CREDIT		<= '0';
				PURCHASE_return <= '0';
				DEBUG_out		<= x"8";			
				
				nextState 		<= CHECKN;
			
			when COINRETURN =>
				DEC_80 			<= '0';
				INC_CRED 		<= "00";
				DEC_CANDY 		<= '0';
				INC_SALES_80	<= '0';
				CLR_CREDIT		<= '1';
				PURCHASE_return <= '0';
				DEBUG_out		<= x"7";		

				nextState 		<= CHECKN;

		end case;
	end process;

				
end Behavioral;

