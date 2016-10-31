
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopLevel is
    Port ( CLK 	: in  STD_LOGIC;
           BTNR 	: in  STD_LOGIC;
			  BTNL 	: in  STD_LOGIC;
			  BTNC 	: in  STD_LOGIC;
			  BTND 	: in  STD_LOGIC;
			  BTNU 	: in  STD_LOGIC;
			  SWITCH	: in STD_LOGIC_VECTOR (15 downto 0);
           HS 		: out  STD_LOGIC;
           VS 		: out  STD_LOGIC;
           VGA_R 	: out  STD_LOGIC_VECTOR (3 downto 0);
           VGA_G 	: out  STD_LOGIC_VECTOR (3 downto 0);
           VGA_B 	: out  STD_LOGIC_VECTOR (3 downto 0));
end TopLevel;

architecture Structural of TopLevel is

	component VGA_Controller is
    Port ( 
			  CLK  	  : in STD_LOGIC;
			  RESET	  : in STD_LOGIC;
			  RGB_in : in STD_LOGIC_VECTOR (11 downto 0);
			  POS_X	: out STD_LOGIC_VECTOR (9 downto 0);
			  POS_Y	: out STD_LOGIC_VECTOR (8 downto 0);
			  HS 		: out  STD_LOGIC;
           VS 		: out  STD_LOGIC;
			  PULSE	: out  STD_LOGIC;
           RGB_out: out  STD_LOGIC_VECTOR (11 downto 0));
	end component;
	
	
	component ImageSource is
    Port ( 	
			  SWITCH	  : in  STD_LOGIC_VECTOR(11 downto 0);
			  BUTTON	  : in  STD_LOGIC_VECTOR(0 to 4);
	        rowCount : in  STD_LOGIC_VECTOR(8 downto 0);
			  colCount : in  STD_LOGIC_VECTOR(9 downto 0);
			  CLK		  : in  STD_LOGIC;
           en 		  : in  STD_LOGIC;
           RGB_out 	  : out  STD_LOGIC_VECTOR (11 downto 0));
	end component;
	
	signal x_int : STD_LOGIC_VECTOR(9 downto 0);
	signal y_int : STD_LOGIC_VECTOR(8 downto 0);
	
	signal RGB_int : STD_LOGIC_VECTOR(11 downto 0);
	signal RGB_out_int : STD_LOGIC_VECTOR(11 downto 0);
	signal vga_pulse : STD_LOGIC;
	
	signal button : STD_LOGIC_VECTOR(0 to 4);
	
begin
	
	
	button <= BTNU & BTND & BTNL & BTNR & BTNC;
	
	img : ImageSource port map(
		SWITCH   => SWITCH(11 downto 0),
		BUTTON	=> button,
		rowCount => y_int,
		colCount => x_int,
		CLK 		=> CLK,
		en 		=> vga_pulse,
		RGB_out	=> RGB_int
	);

	vga : VGA_Controller port map (
		CLK 		=> CLK,
		RESET 	=> BTNC,
		RGB_in 	=> RGB_int,
		POS_X		=> x_int,
		POS_y		=> y_int,
		HS			=> HS,
		VS			=> VS,
		PULSE		=> vga_pulse,
      RGB_out  => RGB_out_int
	);
	
	VGA_R <= RGB_out_int(11 downto 8);
	VGA_G <= RGB_out_int(7 downto 4);
	VGA_B <= RGB_out_int(3 downto 0);

end Structural;

