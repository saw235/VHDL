
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity conv_unit_fsm is
    Port ( STATUS_in 	: in  STD_LOGIC_VECTOR (0 to 2);
           CLK 			: in  STD_LOGIC;
           RESET 			: in  STD_LOGIC;
           CONTROL_out 	: out  STD_LOGIC_VECTOR (0 to 14)
			 );
end conv_unit_fsm;

architecture Behavioral of conv_unit_fsm is

	--defines all the states
	type STATE_TYPE is (RESETSTATE, WAIT_0,
							  MULTIPLIES,
							  ADD_0, ADD_1, ADD_2,
							  ADD_3, ADD_4, ADD_5,
							  ADD_6, ADD_7,
							  DIVIDE,
							  CHECK,
							  OFLOW, NGTIVE, TRU,
							  CONV_OK_STATE);
							
	signal presentState : STATE_TYPE;
	signal nextState	  : STATE_TYPE;
	
	--inputs for FSM
	alias CONV_START		is Status_in(0);
	alias ISOVERFLOW		is Status_in(1);
	alias ISNEGATIVE		is Status_in(2);

	--outputs for FSM
	alias CLR_REG			is CONTROL_out(0);
	
	alias LOAD_MULT		is CONTROL_out(1);
	alias LOAD_ADD : STD_LOGIC_VECTOR(0 to 7)	is CONTROL_out(2 to 9);
	
	alias LOAD_DIV		 	is CONTROL_out(10);
	
	alias Q_SEL	: STD_LOGIC_VECTOR(1 downto 0) is CONTROL_out(11 to 12);
	alias LOAD_Q_SEL	 	is CONTROL_out(13);
	alias CONV_OK			is CONTROL_out(14);
	
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
			
				CLR_REG		<= '0';
			   LOAD_MULT	<= '0';
            LOAD_ADD		<= "00000000";
            LOAD_DIV		<= '0';
            Q_SEL			<= "00";
            LOAD_Q_SEL	<= '0';
            CONV_OK		<= '0';
				
				nextState <= WAIT_0;
	
			when WAIT_0 =>

				CLR_REG		<= '1';
			   LOAD_MULT	<= '0';
            LOAD_ADD		<= "00000000";
            LOAD_DIV		<= '0';
            Q_SEL			<= "00";
            LOAD_Q_SEL	<= '0';
            CONV_OK		<= '0';
			
				if (CONV_START = '1') then
					nextState <= MULTIPLIES;
				else
					nextState <= WAIT_0;
				end if;
			
			when MULTIPLIES =>

				CLR_REG		<= '0';
			   LOAD_MULT	<= '1';
            LOAD_ADD		<= "00000000";
            LOAD_DIV		<= '0';
            Q_SEL			<= "00";
            LOAD_Q_SEL	<= '0';
            CONV_OK		<= '0';
				
				nextState <= ADD_0;
				
			when ADD_0 =>
			
				CLR_REG		<= '0';
			   LOAD_MULT	<= '0';
            LOAD_ADD		<= "10000000";
            LOAD_DIV		<= '0';
            Q_SEL			<= "00";
            LOAD_Q_SEL	<= '0';
            CONV_OK		<= '0';
				
				nextState <= ADD_1;
				
			when ADD_1 =>
			
				CLR_REG		<= '0';
			   LOAD_MULT	<= '0';
            LOAD_ADD		<= "01000000";
            LOAD_DIV		<= '0';
            Q_SEL			<= "00";
            LOAD_Q_SEL	<= '0';
            CONV_OK		<= '0';
				
				nextState <= ADD_2;
				
			when ADD_2 =>
			
				CLR_REG		<= '0';
			   LOAD_MULT	<= '0';
            LOAD_ADD		<= "00100000";
            LOAD_DIV		<= '0';
            Q_SEL			<= "00";
            LOAD_Q_SEL	<= '0';
            CONV_OK		<= '0';			
				
				nextState <= ADD_3;
			
			when ADD_3 =>
			
				CLR_REG		<= '0';
			   LOAD_MULT	<= '0';
            LOAD_ADD		<= "00010000";
            LOAD_DIV		<= '0';
            Q_SEL			<= "00";
            LOAD_Q_SEL	<= '0';
            CONV_OK		<= '0';
				
				nextState <= ADD_4;
				
			when ADD_4 =>
			
				CLR_REG		<= '0';
			   LOAD_MULT	<= '0';
            LOAD_ADD		<= "00001000";
            LOAD_DIV		<= '0';
            Q_SEL			<= "00";
            LOAD_Q_SEL	<= '0';
            CONV_OK		<= '0';			
			
				nextState <= ADD_5;
			when ADD_5 =>
			
				CLR_REG		<= '0';
			   LOAD_MULT	<= '0';
            LOAD_ADD		<= "00000100";
            LOAD_DIV		<= '0';
            Q_SEL			<= "00";
            LOAD_Q_SEL	<= '0';
            CONV_OK		<= '0';			
			
				nextState <= ADD_6;
				
			when ADD_6 =>
			
				CLR_REG		<= '0';
			   LOAD_MULT	<= '0';
            LOAD_ADD		<= "00000010";
            LOAD_DIV		<= '0';
            Q_SEL			<= "00";
            LOAD_Q_SEL	<= '0';
            CONV_OK		<= '0';			
			
				nextState <= ADD_7;
				
			when ADD_7 =>
			
				CLR_REG		<= '0';
			   LOAD_MULT	<= '0';
            LOAD_ADD		<= "00000001";
            LOAD_DIV		<= '0';
            Q_SEL			<= "00";
            LOAD_Q_SEL	<= '0';
            CONV_OK		<= '0';
				
				nextState <= DIVIDE;
				
			when DIVIDE =>

				CLR_REG		<= '0';
			   LOAD_MULT	<= '0';
            LOAD_ADD		<= "00000000";
            LOAD_DIV		<= '1';
            Q_SEL			<= "00";
            LOAD_Q_SEL	<= '0';
            CONV_OK		<= '0';
				
				nextState <= CHECK;
				
			when CHECK =>
			
				CLR_REG		<= '0';
			   LOAD_MULT	<= '0';
            LOAD_ADD		<= "00000000";
            LOAD_DIV		<= '0';
            Q_SEL			<= "00";
            LOAD_Q_SEL	<= '0';
            CONV_OK		<= '0';			
			
				if (ISOVERFLOW = '0' and ISNEGATIVE = '1') then
					nextState <= NGTIVE;
				elsif (ISOVERFLOW = '1' and ISNEGATIVE = '0') then
					nextState <= OFLOW;
				else
					nextState <= TRU;
				end if;
			
			when OFLOW =>
			
				CLR_REG		<= '0';
			   LOAD_MULT	<= '0';
            LOAD_ADD		<= "00000000";
            LOAD_DIV		<= '0';
            Q_SEL			<= "01";
            LOAD_Q_SEL	<= '1';
            CONV_OK		<= '0';			
			
				nextState <= CONV_OK_STATE;
			
			when NGTIVE =>
			
				CLR_REG		<= '0';
			   LOAD_MULT	<= '0';
            LOAD_ADD		<= "00000000";
            LOAD_DIV		<= '0';
            Q_SEL			<= "10";
            LOAD_Q_SEL	<= '1';
            CONV_OK		<= '0';			
				
				nextState <= CONV_OK_STATE;
				
			when TRU =>
			
				CLR_REG		<= '0';
			   LOAD_MULT	<= '0';
            LOAD_ADD		<= "00000000";
            LOAD_DIV		<= '0';
            Q_SEL			<= "00";
            LOAD_Q_SEL	<= '1';
            CONV_OK		<= '0';			

				nextState <= CONV_OK_STATE;
				
			when CONV_OK_STATE =>

				CLR_REG		<= '0';
			   LOAD_MULT	<= '0';
            LOAD_ADD		<= "00000000";
            LOAD_DIV		<= '0';
            Q_SEL			<= "00";
            LOAD_Q_SEL	<= '0';
            CONV_OK		<= '1';			
			
				nextState <= WAIT_0;
				
		end case;
	end process;

end Behavioral;

