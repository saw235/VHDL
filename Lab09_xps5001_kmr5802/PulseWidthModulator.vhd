
library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use XPS5001_Library.XPS5001_Components.all;



entity PulseWidthModulator is
	 Generic ( nbits  	 : integer := 8);
    Port ( CLK 			 : in  STD_LOGIC;
			  PERIOD_IN		 : in  STD_LOGIC_VECTOR( nbits - 1 downto 0);
			  PULSEWIDTH_IN : in  STD_LOGIC_VECTOR( nbits - 1 downto 0);
			  RESET			 : in  STD_LOGIC;
           PULSE_OUT 	 : out  STD_LOGIC);
end PulseWidthModulator;

architecture Behavioral of PulseWidthModulator is

	signal reset_int 		: std_logic;
	signal counter_int	: std_logic_vector ( nbits - 1 downto 0);
	signal duty_high_int	: std_logic;
	signal tc			   : std_logic;
	
	signal pulsewidth    : integer := 128;
	signal period 			: integer := 256;
	

begin
	
	pulsewidth <= to_integer(unsigned(PULSEWIDTH_IN));
	period     <= to_integer(unsigned(PERIOD_IN));
	
	reset_int <= tc or RESET;
	ctnr : Counter generic map ( n => nbits) port map(
			  EN 	 => '1',
           CLK  => CLK,
           CLR  => reset_int,
           Q 	 => counter_int);
			

	duty_high_int <= '1' when ( unsigned(counter_int) < to_unsigned(pulsewidth,nbits)) else '0';
	tc 			  <= '1' when ( unsigned(counter_int) = to_unsigned(period, nbits)) else '0';
	
	PULSE_OUT <= duty_high_int;

end Behavioral;

