
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Kernel is
	 Generic ( constant imgWidth 	 		: positive := 9;
				  constant DATA_WIDTH 		: positive := 4;
				  constant PxPos_bitwidth 	: positive := 19);
    Port ( PxByte 	: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           ShiftPx 	: in  STD_LOGIC;
           PxCnt 		: in  STD_LOGIC_VECTOR (PxPos_bitwidth - 1 downto 0);
			  CLK			: in  STD_LOGIC;
			  CLR			: in  STD_LOGIC;
			  CONV_START	: in 	STD_LOGIC;			  
			  SEL			: in 	STD_LOGIC_VECTOR ( 3 downto 0);
           Px_Out 	: out  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
			  CONV_OK		: out STD_LOGIC
			  );
end Kernel;

architecture Structural of Kernel is

	component Window
	 Generic ( constant imgWidth 	 		: positive := 9;
				  constant DATA_WIDTH 		: positive := 4;
				  constant PxPos_bitwidth 	: positive := 19);
    Port ( PxByte 		: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           ShiftPx 		: in  STD_LOGIC;
           PxPos 			: in  STD_LOGIC_VECTOR (PxPos_bitwidth - 1 downto 0); 
			  CLK				: in  STD_LOGIC;
			  CLR				: in 	STD_LOGIC;
			  Q0 : out  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q1 : out  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q2 : out  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q3 : out  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q4 : out  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q5 : out  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q6 : out  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q7 : out  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q8 : out  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0)
			  );
    end component;
	
--	component conv_unit 
--	 Generic (
--				 constant DATA_WIDTH 		: positive := 4;
--				 constant SUM_BIT_WIDTH 	: positive := 9;
--				 constant ceil					: positive := 15;
--				 constant floor 				: integer  := 0
--				 );
--				 
--    Port ( Q0 : in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
--           Q1 : in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
--           Q2 : in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
--           Q3 : in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
--           Q4 : in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
--           Q5 : in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
--           Q6 : in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
--           Q7 : in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
--           Q8 : in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
--			 SEL : in  STD_LOGIC_VECTOR (1 downto 0 );
--           Q : out  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0));
--	end component;
	
	component conv_unit_piped is
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
	

	end component;

		signal q0_int : std_logic_vector (DATA_WIDTH - 1 downto 0);
		signal q1_int : std_logic_vector (DATA_WIDTH - 1 downto 0);
		signal q2_int : std_logic_vector (DATA_WIDTH - 1 downto 0);
		signal q3_int : std_logic_vector (DATA_WIDTH - 1 downto 0);
		signal q4_int : std_logic_vector (DATA_WIDTH - 1 downto 0);
		signal q5_int : std_logic_vector (DATA_WIDTH - 1 downto 0);
		signal q6_int : std_logic_vector (DATA_WIDTH - 1 downto 0);
		signal q7_int : std_logic_vector (DATA_WIDTH - 1 downto 0);
		signal q8_int : std_logic_vector (DATA_WIDTH - 1 downto 0);

		
begin

	wdw : Window generic map ( imgWidth => imgWidth , DATA_WIDTH => DATA_WIDTH, PxPos_bitwidth => PxPos_bitwidth )port map (

		PxByte 	=> PxByte, 	
	   ShiftPx 	=> ShiftPx, 	 	
	   PxPos 	=> PxCnt, 		 	
	   CLK 		=> CLK, 		
	   CLR 		=> CLR, 		
	   Q0 		=>	q0_int, 
	   Q1 		=>	q1_int, 
	   Q2 		=>	q2_int, 
	   Q3 		=>	q3_int, 
	   Q4 		=>	q4_int, 
	   Q5 		=>	q5_int, 
	   Q6 		=>	q6_int, 
	   Q7 		=>	q7_int, 
	   Q8 		=>	q8_int
	);
	
--	kernel_3by3 : conv_unit generic map ( 
--		DATA_WIDTH => DATA_WIDTH
--		) port map(
--		Q0 		=>	q0_int, 
--	   Q1 		=>	q1_int, 
--	   Q2 		=>	q2_int, 
--	   Q3 		=>	q3_int, 
--	   Q4 		=>	q4_int, 
--	   Q5 		=>	q5_int, 
--	   Q6 		=>	q6_int, 
--	   Q7 		=>	q7_int, 
--	   Q8 		=>	q8_int,
--		SEL		=> SEL,
--	   Q			=> Px_out
--	);

	kernel_3by3 : conv_unit_piped generic map ( 
		DATA_WIDTH => DATA_WIDTH
		) port map(
		CLK 		  		=> CLK,
		RESET	  			=> CLR,
		Q0 				=>	q0_int,
		Q1 				=>	q1_int,
		Q2 				=>	q2_int,
		Q3 				=>	q3_int,
		Q4 				=>	q4_int,
		Q5 				=>	q5_int,
		Q6 				=>	q6_int,
		Q7 				=>	q7_int,
		Q8 				=>	q8_int,
		CONV_START		=> CONV_START,
		SEL				=> SEL,
		Q 					=> Px_out,
		CONV_OK			=> CONV_OK
		);
		



end Structural;

