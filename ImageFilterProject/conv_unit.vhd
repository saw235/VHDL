library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use XPS5001_Library.XPS5001_Components.all;

entity conv_unit is
	 Generic (
				 constant DATA_WIDTH 		: positive := 4;
				 constant SUM_BIT_WIDTH 	: positive := 9;
				 constant ceil					: positive := 15;
				 constant floor 				: integer  := 0
				 );
				 
    Port ( Q0 : in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q1 : in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q2 : in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q3 : in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q4 : in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q5 : in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q6 : in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q7 : in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           Q8 : in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
			 SEL : in  STD_LOGIC_VECTOR (1 downto 0 );
           Q : out  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0));
end conv_unit;


architecture Behavioral of conv_unit is


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
	signal isOverflow 			: std_logic;
	signal isNegative				: std_logic;
	
	type kernel_matrix_type is array ( 0 to 8) of integer;
	
	constant non_filter : kernel_matrix_type :=  (0,0,0,
																 0,2,0,
																 0,0,0);
	constant edge_filter : kernel_matrix_type := (-1,-1,-1,
																 -1, 8,-1,
																 -1,-1,-1);
	
	constant sharpen_filter : kernel_matrix_type := (0,-1 ,0,
																	 -1,5,-1,
																	 0,-1,0);
																	 
	constant custom_filter : kernel_matrix_type := (-1,0,-1,
																	 0, 5, 0,
																	 -1,0,-1);
																	 
																	 
	signal A: kernel_matrix_type;
	

begin

	with sel select A <= non_filter when "00",
								edge_filter when "01",
								sharpen_filter when "10",
								custom_filter when "11",
								non_filter when others;
								
	--multiplies							
	mult_0 <= to_integer(unsigned(Q0)) * A(0);
	mult_1 <= to_integer(unsigned(Q1)) * A(1);
	mult_2 <= to_integer(unsigned(Q2)) * A(2);
	mult_3 <= to_integer(unsigned(Q3)) * A(3);
	mult_4 <= to_integer(unsigned(Q4)) * A(4);
	mult_5 <= to_integer(unsigned(Q5)) * A(5);
	mult_6 <= to_integer(unsigned(Q6)) * A(6);
	mult_7 <= to_integer(unsigned(Q7)) * A(7);
	mult_8 <= to_integer(unsigned(Q8)) * A(8);								

	
	--sum
	sum <= mult_0 + mult_1 + mult_2 + mult_3 + mult_4 + mult_5 + mult_6 + mult_7 + mult_8;

	sum_signed <= std_logic_vector(to_signed(sum, SUM_BIT_WIDTH));
	
	--divide by two
	sum_signed_scaled <= sum_signed(SUM_BIT_WIDTH - 1 downto 1);
	
	
	--check if number is between floor and ceil, set to floor if less than floor, set to ceil if greater than ceil. 
	isOverflow <= '1' when ( signed(sum_signed_scaled) > ceil) else '0';
	isNegative <= '1' when ( signed(sum_signed_scaled) < floor ) else '0';
	
	Q <= sum_signed_scaled( DATA_WIDTH - 1 downto 0) when ( isOverflow = '0' and isNegative = '0') else
		  x"F" when (isOverflow = '1' and isNegative = '0') else
		  x"0" when (isOverflow = '0' and isNegative = '1') else
		  sum_signed_scaled( DATA_WIDTH - 1  downto 0);
		  


end Behavioral;

