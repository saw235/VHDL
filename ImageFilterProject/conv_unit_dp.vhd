library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use XPS5001_Library.XPS5001_Components.all;


entity conv_unit_dp is
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
			  
end conv_unit_dp;

architecture Structural of conv_unit_dp is

	--inputs for FSM
	alias CONV_START		is Status_out(0);
	alias ISOVERFLOW		is Status_out(1);
	alias ISNEGATIVE		is Status_out(2);

	--outputs for FSM
	alias CLR_REG			is CONTROL_in(0);
	
	alias LOAD_MULT		is CONTROL_in(1);
	alias LOAD_ADD : STD_LOGIC_VECTOR(0 to 7)	is CONTROL_in(2 to 9);
	
	alias LOAD_DIV		 	is CONTROL_in(10);
	
	alias Q_SEL	: STD_LOGIC_VECTOR(1 downto 0) is CONTROL_in(11 to 12);
	alias LOAD_Q_SEL	 	is CONTROL_in(13);
	alias CONV_OK			is CONTROL_in(14);
	
	
	signal Q_int : STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
	signal mult_0 : integer;
	signal mult_1 : integer;
	signal mult_2 : integer;
	signal mult_3 : integer;
	signal mult_4 : integer;
	signal mult_5 : integer;
	signal mult_6 : integer;
	signal mult_7 : integer;
	signal mult_8 : integer;
	
	signal sum : integer;
	
	signal sum_signed 			: std_logic_vector (SUM_BIT_WIDTH - 1 downto 0);
	signal sum_signed_scaled 	: std_logic_vector(SUM_BIT_WIDTH - 2 downto 0);
	
	signal q_sel_reg : std_logic_vector (1 downto 0);
	
	signal p0 : integer;
	signal p1 : integer;
	signal p2 : integer;
	signal p3 : integer;
	signal p4 : integer;
	signal p5 : integer;
	signal p6 : integer;	
	
	type kernel_matrix_type is array (0 to 8) of integer;
	
	type kernel_list_type is array (0 to 15) of kernel_matrix_type;
	
	constant identity_filter : kernel_matrix_type :=  (0,0,0,
																		0,2,0,
																		0,0,0);																		 
	constant edge_filter : kernel_matrix_type := (-1,-1,-1,
																 -1,8,-1,
																 -1,-1,-1);
	constant edge_filter_2 : kernel_matrix_type := (-2,-2,-2,
																	-2,16,-2,
																	-2,-2,-2);
	constant edge_filter_3 : kernel_matrix_type := (-1,-1,-1,
																	-1,9,-1,
																	-1,-1,-1);

																 
	constant sharpen_filter : kernel_matrix_type := (0,-2 ,0,
																	 -2,10,-2,
																	 0,-2,0);
	constant sharpen_filter_2 : kernel_matrix_type :=  (0,-1 ,0,
																		-1,5,-1,
																		0,-1,0);
													 
	constant emboss_filter : kernel_matrix_type := 	(-2,-1,0,
																	 -1,1,1,
																	 0,1,2);																 															
	constant emboss_filter_2 : kernel_matrix_type := (-4,-2,0,
																	  -2,2,2,
																	  0,2,4);		
	constant top_sobel_filter : kernel_matrix_type := (2,4,2,
																		0,0,0,
																	 -2,-4,-2);																 																
	constant right_sobel_filter : kernel_matrix_type := (-2,0,2,
																		  -4,0,4,
																		 -2,0,2);	
	constant bottom_sobel_filter : kernel_matrix_type := (-2,-4,-2,
																			 0,0,0,
																			 2,4,2);																				
	constant left_sobel_filter : kernel_matrix_type := (2,0,-2,
																		  4,0,-4,
																		 2,0,-2);	
	constant sobel_feldman : kernel_matrix_type := 		(3,0,-3,
																		 10,0,-10,
																		 3,0,-3);						 
	constant custom_filter : kernel_matrix_type := 	(0,1,0,
																	 1,1,1,
																	 0,1,0);
																	 
	constant custom_filter_1 : kernel_matrix_type := (2,4,2,
																		0,0,0,
																	 -1,-2,-1);

	constant custom_filter_2 : kernel_matrix_type := (-1,-2,-1,
																		0,0,0,
																	 2,4,2);																	 
																	 
																	 
	constant kernel_list : kernel_list_type := (identity_filter, edge_filter, edge_filter_2, edge_filter_3, sharpen_filter, sharpen_filter_2, 
																emboss_filter, emboss_filter_2, top_sobel_filter, right_sobel_filter, bottom_sobel_filter,
																left_sobel_filter, sobel_feldman, custom_filter, custom_filter_1, custom_filter_2);
																									  
	signal A: kernel_matrix_type;	

begin
	
	with sel select A <= kernel_list(0) when x"0",
								kernel_list(1) when x"1",
								kernel_list(2) when x"2",
								kernel_list(3) when x"3",
								kernel_list(4) when x"4",
								kernel_list(5) when x"5",
								kernel_list(6) when x"6",
								kernel_list(7) when x"7",
								kernel_list(8) when x"8",
								kernel_list(9) when x"9",
								kernel_list(10) when x"A",
								kernel_list(11) when x"B",
								kernel_list(12) when x"C",
								kernel_list(13) when x"D",
								kernel_list(14) when x"E",
								kernel_list(15) when x"F",
								kernel_list(0) when others;	
								
								
	sum_signed <= std_logic_vector(to_signed(sum, SUM_BIT_WIDTH));

	--check if number is between floor and ceil, set to floor if less than floor, set to ceil if greater than ceil. 
	isOverflow <= '1' when ( signed(sum_signed_scaled) > ceil) else '0';
	isNegative <= '1' when ( signed(sum_signed_scaled) < floor ) else '0';	
	
	with q_sel_reg select Q_int <=   x"F" when "01",
												x"0" when "10",
												sum_signed_scaled( DATA_WIDTH - 1 downto 0) when others;
		  
	CONV_START <= CONV_START_in;
	
	process(CLK) is
	begin
		if rising_edge(CLK) then 
			
			if LOAD_MULT = '1' then
				mult_0 <= to_integer(unsigned(Q0)) * A(0);
				mult_1 <= to_integer(unsigned(Q1)) * A(1);
				mult_2 <= to_integer(unsigned(Q2)) * A(2);
				mult_3 <= to_integer(unsigned(Q3)) * A(3);
				mult_4 <= to_integer(unsigned(Q4)) * A(4);
				mult_5 <= to_integer(unsigned(Q5)) * A(5);
				mult_6 <= to_integer(unsigned(Q6)) * A(6);
				mult_7 <= to_integer(unsigned(Q7)) * A(7);
				mult_8 <= to_integer(unsigned(Q8)) * A(8);
			end if;
			
			if LOAD_ADD(0) = '1' then
				p0 <= mult_0 + mult_1;
			end if;

			if LOAD_ADD(1) = '1' then
				p1 <= p0 + mult_2;
			end if;

			if LOAD_ADD(2) = '1' then
				p2 <= p1 + mult_3;
			end if;

			if LOAD_ADD(3) = '1' then
				p3 <= p2 + mult_4;
			end if;

			if LOAD_ADD(4) = '1' then
				p4 <= p3 + mult_5;
			end if;
			
			if LOAD_ADD(5) = '1' then
				p5 <= p4 + mult_6;
			end if;			
			
			if LOAD_ADD(6) = '1' then
				p6 <= p5 + mult_7;
			end if;			
			
			if LOAD_ADD(7) = '1' then
				sum <= p6 + mult_8;
			end if;			

			if LOAD_DIV = '1' then
				sum_signed_scaled <= sum_signed(SUM_BIT_WIDTH - 1 downto 1);
			end if;
			
			if LOAD_Q_SEL = '1' then
				q_sel_reg <= Q_SEL;
			end if;
			
			if CONV_OK = '1' then
				Q <= Q_int;
			end if;
			
		end if;
	end process;

end Structural;

