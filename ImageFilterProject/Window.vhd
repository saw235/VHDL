library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use XPS5001_Library.XPS5001_Components.all;

entity Window is
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
           Q8 : out  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0));
end Window;

architecture Behavioral of Window is


	component STD_FIFO is
		Generic (
			constant DATA_WIDTH  : positive := 8;
			constant FIFO_DEPTH	: positive := 256
		);
		Port ( 
			CLK		: in  STD_LOGIC;
			RST		: in  STD_LOGIC;
			WriteEn	: in  STD_LOGIC;
			DataIn	: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
			ReadEn	: in  STD_LOGIC;
			DataOut	: out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
			Empty		: out STD_LOGIC;
			Full		: out STD_LOGIC
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
		
		signal fifo_0_writeen_int : std_logic;
		signal fifo_0_readen_int  : std_logic;
		signal fifo_0_out_int	  : std_logic_vector (DATA_WIDTH - 1 downto 0);
		signal fifo_0_empty_int	  : std_logic;
		signal fifo_0_full_int	  : std_logic;

		signal fifo_1_writeen_int : std_logic;
		signal fifo_1_readen_int  : std_logic;
		signal fifo_1_out_int	  : std_logic_vector (DATA_WIDTH - 1 downto 0);
		signal fifo_1_empty_int	  : std_logic;
		signal fifo_1_full_int	  : std_logic;
		
		signal fifo_0_isEnoughPx_Read  	: std_logic;
		signal fifo_0_isEnoughPx_Write  	: std_logic;
		signal fifo_1_isEnoughPx_Read  	: std_logic;
		signal fifo_1_isEnoughPx_Write  	: std_logic;
	
begin


	fifo_0_isEnoughPx_Read  <= '1' when (to_integer(unsigned(PxPos)) >= imgWidth - 1) else '0';
	fifo_0_isEnoughPx_Write <= '1' when (to_integer(unsigned(PxPos)) > 2) else '0';
   fifo_1_isEnoughPx_Read  <= '1' when (to_integer(unsigned(PxPos)) >= imgWidth+ imgWidth- 1) else '0';
   fifo_1_isEnoughPx_Write <= '1' when (to_integer(unsigned(PxPos)) > imgWidth + 2) else '0';

	fifo_0_writeen_int	<= fifo_0_isEnoughPx_Write and ShiftPx;
	fifo_0_readen_int		<= fifo_0_isEnoughPx_Read and ShiftPx;
	fifo_1_writeen_int	<= fifo_1_isEnoughPx_Write and ShiftPx;
	fifo_1_readen_int		<=	fifo_1_isEnoughPx_Read and ShiftPx;
	
	rg8 : reg generic map ( n => DATA_WIDTH ) port map(
		 D 		=> PxByte,
	    LOAD		=> ShiftPx,
	    CLK 		=> CLK,
	    CLR 		=> CLR,
	    Q 		=> q8_int
	);
	
	rg7 : reg generic map ( n => DATA_WIDTH ) port map(
		 D 		=> q8_int,
	    LOAD		=> ShiftPx,
	    CLK 		=> CLK,
	    CLR 		=> CLR,
	    Q 		=> q7_int
	);	
	
	rg6 : reg generic map ( n => DATA_WIDTH ) port map(
		 D 		=> q7_int,
	    LOAD		=> ShiftPx,
	    CLK 		=> CLK,
	    CLR 		=> CLR,
	    Q 		=> q6_int
	);	
	
	
	fifo_0 : STD_FIFO generic map ( DATA_WIDTH => DATA_WIDTH, FIFO_DEPTH => 256) port map (
		CLK		=> CLK,
	   RST		=> CLR,
	   WriteEn	=> fifo_0_writeen_int,
	   DataIn	=> q6_int,
	   ReadEn	=> fifo_0_readen_int,
	   DataOut	=> fifo_0_out_int,
	   Empty		=> fifo_0_empty_int,
	   Full		=> fifo_0_full_int
	);
	
	rg5 : reg generic map ( n => DATA_WIDTH ) port map(
		 D 		=> fifo_0_out_int,
	    LOAD		=> ShiftPx,
	    CLK 		=> CLK,
	    CLR 		=> CLR,
	    Q 		=> q5_int
	);
	
	rg4 : reg generic map ( n => DATA_WIDTH ) port map(
		 D 		=> q5_int,
	    LOAD		=> ShiftPx,
	    CLK 		=> CLK,
	    CLR 		=> CLR,
	    Q 		=> q4_int
	);	
	
	rg3 : reg generic map ( n => DATA_WIDTH ) port map(
		 D 		=> q4_int,
	    LOAD		=> ShiftPx,
	    CLK 		=> CLK,
	    CLR 		=> CLR,
	    Q 		=> q3_int
	);	
	
	
	fifo_1 : STD_FIFO generic map ( DATA_WIDTH => DATA_WIDTH, FIFO_DEPTH => 256) port map (
		CLK		=> CLK,
	   RST		=> CLR,
	   WriteEn	=> fifo_1_writeen_int,
	   DataIn	=> q3_int,
	   ReadEn	=> fifo_1_readen_int,
	   DataOut	=> fifo_1_out_int,
	   Empty		=> fifo_1_empty_int,
	   Full		=> fifo_1_full_int
	);
	
	rg2 : reg generic map ( n => DATA_WIDTH) port map(
		 D 		=> fifo_1_out_int,
	    LOAD		=> ShiftPx,
	    CLK 		=> CLK,
	    CLR 		=> CLR,
	    Q 		=> q2_int
	);
	
	rg1 : reg generic map ( n => DATA_WIDTH ) port map(
		 D 		=> q2_int,
	    LOAD		=> ShiftPx,
	    CLK 		=> CLK,
	    CLR 		=> CLR,
	    Q 		=> q1_int
	);	
	
	rg0 : reg generic map ( n => DATA_WIDTH ) port map(
		 D 		=> q1_int,
	    LOAD		=> ShiftPx,
	    CLK 		=> CLK,
	    CLR 		=> CLR,
	    Q 		=> q0_int
	);	
		
	q0 <= q0_int;
	q1 <= q1_int;
	q2 <= q2_int;
	q3 <= q3_int;
	q4 <= q4_int;
	q5 <= q5_int;
	q6 <= q6_int;
	q7 <= q7_int;
	q8 <= q8_int;

end Behavioral;

