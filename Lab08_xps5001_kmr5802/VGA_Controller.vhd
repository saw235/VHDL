library IEEE;
library XPS5001_Library;

use XPS5001_Library.XPS5001_Components.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity VGA_Controller is
    Port ( 
			  CLK  	  : in STD_LOGIC;
			  RESET	  : in STD_LOGIC;
			  RGB_in   : in STD_LOGIC_VECTOR (11 downto 0);
			  POS_X	  : out STD_LOGIC_VECTOR (9 downto 0);
			  POS_Y	  : out STD_LOGIC_VECTOR (8 downto 0);
			  HS 		  : out  STD_LOGIC;
           VS 		  : out  STD_LOGIC;
			  PULSE	  : out  STD_LOGIC;
           RGB_out  : out  STD_LOGIC_VECTOR (11 downto 0));
end VGA_Controller;

architecture Structural of VGA_Controller is

	
	--internal signal
	signal pulse_25mhz 	: std_logic;
	signal rst_int		 	: std_logic;
	signal tc_int		 	: std_logic;

	signal h_count_int 	: std_logic_vector (9 downto 0);
	signal v_count_int 	: std_logic_vector (9 downto 0);
	
	signal hs_int 			: std_logic;
	signal vs_int 			: std_logic;
	
	signal isDisplayArea : std_logic;
	
	constant offset_x  	: integer := 144;
	constant offset_y  	: integer := 35;
	
	
begin
	
	
	rst_int <= RESET;
	
	pulsegen_25mhz :	PulseGenerator generic map(n => 2, maxCount => 3) port map(
					EN 	=> '1',
					CLK	=> CLK,
					CLR	=> rst_int,
					PULSE => pulse_25mhz--internal pulse
	);
	
	h_count : H_Counter generic map (n => 10, maxCount => 799) port map(
			
			  EN  => pulse_25mhz,
			  CLK => CLK,
           RST => rst_int,
           TC 	=> tc_int,
           Q 	=> h_count_int
	);
	
	v_count : V_Counter generic map (n => 10, maxCount => 524) port map(
			
			  EN 	=> tc_int,
           CLK => CLK,
           RST => rst_int,
           Q	=> v_count_int
	);
	
	
	---------------------------------------------
	-- h sync and v sync
	hsync_96 : CompareLES generic map ( n => 10) port map (
			  A	=> h_count_int,
           B	=> STD_LOGIC_VECTOR(to_unsigned(96, 10)),
           LES	=> hs_int
	);
	
	vsync : CompareLES generic map ( n => 10) port map (
			  A	=> v_count_int,
           B	=> STD_LOGIC_VECTOR(to_unsigned(2, 10)),
           LES	=> vs_int
	);
	
	HS <= not hs_int;
	VS <= not vs_int; 

	
	isDisplayArea <= '1' when ( (unsigned(h_count_int) > 143) and  (unsigned(h_count_int) < 783) and (unsigned(v_count_int) > 34) and (unsigned(v_count_int) < 514) ) else
						  '0';
									 
									 
	with isDisplayArea select 
		 RGB_out <= RGB_in when '1',
						X"000" when others;
						
	POS_X <=  STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(h_count_int)) - offset_x,10));
	POS_Y <=  STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(v_count_int)) - offset_y,9));	
	
	PULSE <= pulse_25mhz;

end Structural;
