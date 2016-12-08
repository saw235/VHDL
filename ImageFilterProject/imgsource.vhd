library IEEE;
library XPS5001_Library;

use XPS5001_Library.XPS5001_Components.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity imgsource is
	generic ( constant data_width : positive := 12;
				 constant addr_width : positive := 15;
				 constant row_width	: positive := 9;
				 constant col_width  : positive := 10;
				 constant img_width	: positive := 150;
				 constant img_height : positive := 200
	);			 
	
	port (
		CLK 				: in STD_LOGIC; 
		RESET 			: in STD_LOGIC;
		Data_in  		: in STD_LOGIC_VECTOR( data_width - 1 downto 0);
		rowCount 		: in  STD_LOGIC_VECTOR(row_width - 1 downto 0);
		colCount 		: in  STD_LOGIC_VECTOR(col_width - 1 downto 0);
		Addrb 			: out  STD_LOGIC_VECTOR (addr_width -1  DOWNTO 0);
      RGB_out 	  		: out  STD_LOGIC_VECTOR (data_width - 1 downto 0)
	);		
	
	
end imgsource;

architecture Structural of imgsource is

	
	signal addr 	  : integer;
	
	signal isValidRowCol : STD_LOGIC;
	
	signal row_int : integer := 0;
	signal col_int : integer := 0;
	
	constant height : integer := img_height;
	constant width  : integer := img_width;


begin

	row_int <= to_integer(unsigned(rowCount));
	col_int <= to_integer(unsigned(colCount));
	

	isValidRowCol <= '1' when ( (col_int > -1) and (col_int < width) and ( row_int > -1) and (row_int < height)) else
					  '0';
	
	with isValidRowCol select 
							RGB_out <= Data_in when '1',
										  (others => '0') when others;
	
	with isValidRowCol select 
							 addr <=  col_int + row_int*width when '1',
										 0 when others;
							 
	addrb <= std_logic_vector(to_unsigned(addr, addr_width ));


end Structural;

