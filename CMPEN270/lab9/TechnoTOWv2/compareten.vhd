----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:05:37 11/18/2014 
-- Design Name: 
-- Module Name:    compareten - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity compareten is
    Port ( b0 : in  STD_LOGIC; --right most bit
           b1 : in  STD_LOGIC;
           b2 : in  STD_LOGIC;
           b3 : in  STD_LOGIC; -- left most bit
           equal : out  STD_LOGIC);
end compareten;

architecture Behavioral of compareten is

component Adder is port
(
				a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           ci : in  STD_LOGIC;
           co : out  STD_LOGIC;
           s : out  STD_LOGIC
);
end component;

signal co0, co1, co2, co3, co4 : std_logic;
signal s0, s1, s2, s3, s4: std_logic;

begin

adder4 : Adder port map
(	
	a => '0',
	b => '1',
	ci => co3,
	co => co4,
	s => s4
);

adder3 : Adder port map
(
	a => b3,
	b => '0',
	ci => co2,
	co => co3,
	s => s3
);

adder2 : Adder port map
(
	a => b2,
	b => '1',
	ci => co1,
	co => co2,
	s => s2
);

adder1 : Adder port map
(
	a => b1,
	b => '0',
	ci => co0,
	co => co1,
	s => s1
);

adder0 : Adder port map
(
	a => b0,
	b => '1',
	ci => '1',
	co => co0,
	s => s0
);

equal <= not (s0 or s1 or s2 or s3 or s4);

end Behavioral;

