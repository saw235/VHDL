library IEEE;
library XPS5001_Library;

use XPS5001_Library.XPS5001_Components.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ImageSource is
    Port ( 	
			  SWITCH	  : in  STD_LOGIC_VECTOR(11 downto 0);
			  BUTTON	  : in  STD_LOGIC_VECTOR(0 to 4);
	        rowCount : in  STD_LOGIC_VECTOR(8 downto 0);
			  colCount : in  STD_LOGIC_VECTOR(9 downto 0);
			  CLK		  : in  STD_LOGIC;
           en 		  : in  STD_LOGIC;
           RGB_out 	  : out  STD_LOGIC_VECTOR (11 downto 0));
end ImageSource;

architecture Structural of ImageSource is

	alias data is RGB_out(11 downto 0); 

	signal isValidRowCol : STD_LOGIC;
	signal isBorders 		: STD_LOGIC;
	
	signal cur_x : integer := 0;
	signal cur_y : integer := 0;
	
	constant offset : integer := 10;
	
	signal up_int		: STD_LOGIC;
	signal down_int	: STD_LOGIC;
	signal left_int	: STD_LOGIC;
	signal right_int	: STD_LOGIC;
	
	
	signal row_int : integer := 0;
	signal col_int : integer := 0;
	
	signal isSquare : STD_LOGIC;
	signal pulse_20hz : STD_LOGIC;
	
	
	signal isCollideLeft		: STD_LOGIC;
	signal isCollideRight   : STD_LOGIC;
	signal isCollideTop 	   : STD_LOGIC;
	signal isCollideBottom  : STD_LOGIC;
	
	signal reset_int : STD_LOGIC;
	
	
	signal xcord_int : STD_LOGIC_VECTOR( 9 downto 0);
	signal ycord_int : STD_LOGIC_VECTOR( 8 downto 0);
	
	signal xor_color : STD_LOGIC_VECTOR( 11 downto 0);
	
	alias x_pos is col_int;
	alias y_pos is row_int;

begin
	
	row_int <= to_integer(unsigned(rowCount));
	col_int <= to_integer(unsigned(colCount));
	

	reset_int   <= BUTTON(4);
	
	--20hz Pulse
	pulse_gen_20hz : PulseGenerator generic map( n => 23, maxCount => 4999999)
		port map(
					EN 	=> '1',
					CLK	=> CLK,
					CLR	=> reset_int,
					PULSE => pulse_20hz--internal pulse
				);
	
	xcord : CounterUpDown generic map ( n => 10) port map(
		EN		=> pulse_20hz,
		UP 	=> right_int,
	   DOWN	=> left_int,
	   CLK	=> CLK,
	   CLR 	=> reset_int,
	   Q 		=> xcord_int
	);

	ycord : CounterUpDown generic map ( n=> 9) port map(
		EN		=> pulse_20hz,
		UP 	=> down_int,
	   DOWN	=> up_int,
	   CLK	=> CLK,
	   CLR 	=> reset_int,
	   Q 		=> ycord_int
	);	
	
	cur_x <= to_integer(unsigned(xcord_int));
	cur_y <= to_integer(unsigned(ycord_int));
	
	isSquare <= '1' when ( (x_pos >= (10 + cur_x) and x_pos < (26+cur_x)) and 
								  (y_pos >= (10+cur_y) and y_pos < (26+cur_y))) 
								  else '0';
								  
								  
	isCollideLeft 		<= '1' when (cur_x = 0) else '0';
	isCollideRight 	<= '1' when (cur_x = 604) else '0';
	isCollideTop 		<= '1' when (cur_y = 0) else '0';
	isCollideBottom 	<= '1' when (cur_y = 444) else '0';
	
	
	with isCollideLeft select 
					left_int	<= '0' when '1',
									BUTTON(2) when others;
					
	with isCollideRight select 
					right_int	<= '0' when '1',
									BUTTON(3) when others;
	
	with isCollideTop select 
					up_int	<= '0' when '1',
									BUTTON(0) when others;
	
	
	with isCollideBottom select 
					down_int	<= '0' when '1',
									BUTTON(1) when others;	

	
	isBorders <= '1' when ( ( x_pos >= 0 and x_pos < 10) or ( y_pos >= 0 and y_pos < 10) or 
									( x_pos >= 630 and x_pos < 640) or ( y_pos >= 470 and y_pos < 480)) 
									else '0';
									
	xor_color <= SWITCH xor "111111111111";
	
	RGB_out <= SWITCH when ((isBorders = '1') or (isSquare ='1')) else
				  xor_color;
				
	
	
end Structural;

