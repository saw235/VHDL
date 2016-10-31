library IEEE;
library XPS5001_Library;

use XPS5001_Library.XPS5001_Components.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity H_Counter is
	 Generic ( n : integer := 10; maxCount : integer := 799);
    Port ( 
			  EN  : in  STD_LOGIC;
			  CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           TC 	: out  STD_LOGIC;
           Q 	: out  STD_LOGIC_VECTOR (n-1 downto 0));
end H_Counter;

architecture Structural of H_Counter is
	--internal signal
	signal a_int 		: STD_LOGIC_VECTOR ( n-1 downto 0);
	signal rst_int		: STD_LOGIC;
	signal TC_int 	: STD_LOGIC;
	
begin

	rst_int <= RST or TC_int;
	count : Counter generic map (n => n) port map(
				EN 	=> EN,
			   CLK 	=> CLK,
				CLR 	=> rst_int,
				Q 		=> a_int
	);
	
	cmpreq : CompareEQU generic map ( n => n) port map (
			  A	=> a_int,
           B	=> STD_LOGIC_VECTOR(to_unsigned(maxCount, n)),
           EQU	=> TC_int
	);
	
	Q  <= a_int;
	TC <= TC_int;

end Structural;

