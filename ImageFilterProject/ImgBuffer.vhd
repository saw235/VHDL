library IEEE;
library XPS5001_Library;

use XPS5001_Library.XPS5001_Components.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ImgBuffer is
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
		WE 				: in STD_LOGIC;
		WRITE_ADDRA 	: in STD_LOGIC_VECTOR( addr_width - 1 downto 0);
		Data_in  		: in STD_LOGIC_VECTOR( data_width - 1 downto 0);
		rowCount 		: in  STD_LOGIC_VECTOR(row_width - 1 downto 0);
		colCount 		: in  STD_LOGIC_VECTOR(col_width - 1 downto 0);
      RE		 		   : in  STD_LOGIC;
      RGB_out 	  		: out  STD_LOGIC_VECTOR (data_width - 1 downto 0)
	);		
	
	
end ImgBuffer;

architecture Structural of ImgBuffer is

	COMPONENT RAM
	  PORT (
		 clka : IN STD_LOGIC;
		 wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 addra : IN STD_LOGIC_VECTOR(addr_width - 1 DOWNTO 0);
		 dina : IN STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);
		 clkb : IN STD_LOGIC;
		 rstb : IN STD_LOGIC;
		 enb : IN STD_LOGIC;
		 addrb : IN STD_LOGIC_VECTOR(addr_width -1  DOWNTO 0);
		 doutb : OUT STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0)
	  );
	END COMPONENT;

	alias data is RGB_out(data_width-1 downto 0); 
	
	signal addr 	  : integer;
	signal addrb 	  : STD_LOGIC_VECTOR(addr_width - 1 downto 0);
	signal doutb_int : STD_LOGIC_VECTOR (data_width - 1 downto 0);
	
	signal isValidRowCol : STD_LOGIC;
	
	signal row_int : integer := 0;
	signal col_int : integer := 0;
	
	signal wea_int : STD_LOGIC_VECTOR(0 downto 0);
	constant height : integer := img_height;
	constant width  : integer := img_width;


begin

	row_int <= to_integer(unsigned(rowCount));
	col_int <= to_integer(unsigned(colCount));
	

	isValidRowCol <= '1' when ( (col_int > -1) and (col_int < width) and ( row_int > -1) and (row_int < height)) else
					  '0';
	
	with isValidRowCol select 
							RGB_out <= doutb_int when '1',
										  (others => '0') when others;
	
	with isValidRowCol select 
							 addr <=  col_int + row_int*width when '1',
										 0 when others;
							 
	addrb <= std_logic_vector(to_unsigned(addr, addr_width ));


	imgbuf : RAM
  PORT MAP (
    clka => CLK,
    wea(0) => WE,
    addra => WRITE_ADDRA,
    dina => Data_in,
    clkb => CLK,
    rstb => RESET,
	 enb => RE,
    addrb => addrb,
    doutb => doutb_int
  );

end Structural;

