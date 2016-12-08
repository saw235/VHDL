library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use XPS5001_Library.XPS5001_Components.all;

entity conv_unit_pipelined is
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
			 CLK : in  STD_LOGIC;
			 SEL : in  STD_LOGIC_VECTOR (1 downto 0 );
	CONV_START : in STD_LOGIC;
		CONV_OK : out STD_LOGIC;	 
           Q : out  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0));
end conv_unit_pipelined;


architecture Behavioral of conv_unit_pipelined is


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
	
	signal p0 : integer;
	signal p1 : integer;
	signal p2 : integer;
	signal p3 : integer;
	signal p4 : integer;
	signal p5 : integer;
	signal p6 : integer;
	
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
								
	isOverflow <= '1' when ( signed(sum_signed_scaled) > ceil) else '0';
	isNegative <= '1' when ( signed(sum_signed_scaled) < floor ) else '0';

	Q <= sum_signed_scaled( DATA_WIDTH - 1 downto 0) when ( isOverflow = '0' and isNegative = '0') else
										x"F" when (isOverflow = '1' and isNegative = '0') else
										x"0" when (isOverflow = '0' and isNegative = '1') else
										sum_signed_scaled( DATA_WIDTH - 1  downto 0);

PROCESS(Clk)
BEGIN
    if(rising_edge(Clk)) then
    --Implement the pipeline stages using a for loop and case statement.
    --'i' is the stage number here.
    --See the output waveform of both the modules and compare them.
		if  CONV_START = '1' then
        for i in 0 to 10 loop 
            case i is 
					 when 0 => 
							
							mult_0 <= to_integer(unsigned(Q0)) * A(0);
							mult_1 <= to_integer(unsigned(Q1)) * A(1);
							mult_2 <= to_integer(unsigned(Q2)) * A(2);
							mult_3 <= to_integer(unsigned(Q3)) * A(3);
							mult_4 <= to_integer(unsigned(Q4)) * A(4);
							mult_5 <= to_integer(unsigned(Q5)) * A(5);
							mult_6 <= to_integer(unsigned(Q6)) * A(6);
							mult_7 <= to_integer(unsigned(Q7)) * A(7);
							mult_8 <= to_integer(unsigned(Q8)) * A(8);	
					 
					 
                when 1 => P0 <= mult_0 + mult_1; CONV_OK <= '0';
                when 2 => P1 <= P0 + mult_2;
                when 3 => P2 <= P1 + mult_3;
					 when 4 => P3 <= P2 + mult_4;
					 when 5 => P4 <= P3 + mult_5;
					 when 6 => P5 <= P4 + mult_6;
					 when 7 => P6 <= P5 + mult_7;
					 when 8 => sum <= P6 + mult_8; 
					 when 9 => sum_signed <= std_logic_vector(to_signed(sum, SUM_BIT_WIDTH));
					 when 10 => sum_signed_scaled <= sum_signed(SUM_BIT_WIDTH - 1 downto 1);
                when others => null;
            end case;
        end loop; 
		  
		end if;
    end if; 
	 
	 
END PROCESS;

	
	
	

	

		  


end Behavioral;

