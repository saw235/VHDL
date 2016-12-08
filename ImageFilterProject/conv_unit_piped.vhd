library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use XPS5001_Library.XPS5001_Components.all;


entity conv_unit_piped is
	Generic (
				 constant DATA_WIDTH 		: positive := 4;
				 constant SUM_BIT_WIDTH 	: positive := 9;
				 constant ceil					: positive := 15;
				 constant floor 				: integer  := 0
				 );
	PORT	(
           CLK 		  	: in  STD_LOGIC;
			  RESET	  		: in  STD_LOGIC;
			  Q0 				: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q1 				: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q2 				: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q3 				: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q4 				: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q5 				: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q6 				: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q7 				: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q8 				: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
			  CONV_START	: in 	STD_LOGIC;			  
			  SEL				: in  STD_LOGIC_VECTOR (3 downto 0);
			  Q 				: out  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
			  CONV_OK		: out STD_LOGIC
	);
	

end conv_unit_piped;

architecture Structural of conv_unit_piped is



	component conv_unit_fsm is
    Port ( STATUS_in 	: in  STD_LOGIC_VECTOR (0 to 2);
           CLK 			: in  STD_LOGIC;
           RESET 			: in  STD_LOGIC;
           CONTROL_out 	: out  STD_LOGIC_VECTOR (0 to 14)
			 );
	end component;

	component conv_unit_dp is
	Generic (
				 constant DATA_WIDTH 		: positive := 4;
				 constant SUM_BIT_WIDTH 	: positive := 9;
				 constant ceil					: positive := 15;
				 constant floor 				: integer  := 0
				 );
    Port ( CONTROL_in 	: in  STD_LOGIC_VECTOR (0 to 14);
           CLK 		  	: in  STD_LOGIC;
			  RESET	  		: in  STD_LOGIC;
			  Q0 				: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q1 				: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q2 				: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q3 				: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q4 				: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q5 				: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q6 				: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q7 				: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q8 				: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
			  SEL				: in  STD_LOGIC_VECTOR (3 downto 0);
			  CONV_START_in: in 	STD_LOGIC;			  
			  Q 				: out  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           STATUS_out 	: out STD_LOGIC_VECTOR (0 to 2));
			  
	end component;


	signal dp_status_out_int 	: STD_LOGIC_VECTOR (0 to 2);
	signal fsm_control_out_int : STD_LOGIC_VECTOR (0 to 14);	
	
begin

	CONV_OK <= fsm_control_out_int(14);

	convfsm : conv_unit_fsm port map(
		STATUS_in 	=> dp_status_out_int,
	   CLK 			=> CLK,
	   RESET 		=> RESET,
	   CONTROL_out => fsm_control_out_int
	);

	convdp : conv_unit_dp generic map(
		DATA_WIDTH 		=> DATA_WIDTH,
	   SUM_BIT_WIDTH 	=> SUM_BIT_WIDTH,
	   ceil				=> ceil,
	   floor 			=> floor ) port map(
		CONTROL_in 		=> fsm_control_out_int,	
		CLK 		  		=> CLK,
		RESET	  			=> RESET,
		Q0 				=> Q0,
		Q1 				=> Q1,
		Q2 				=> Q2,
		Q3 				=> Q3,
		Q4 				=> Q4,
		Q5 				=> Q5,
		Q6 				=> Q6,
		Q7 				=> Q7,
		Q8 				=> Q8,
		SEL				=> SEL,
		CONV_START_in	=> CONV_START,
		Q 					=> Q,
		STATUS_out 		=> dp_status_out_int
	);
	
end Structural;

