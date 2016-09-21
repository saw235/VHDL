----------------------------------------------------------------------------
-- Entity:        RippleCarryAdder_4bit
-- Written By:    Saw Xue Zheng
-- Date Created:  8/27/2017
-- Description:   Component to add two 4-bit numbers together.
--
-- Revision History (date, initials, description):
-- 	27 Aug 16, xps5001, file created.

-- Dependencies:
--		FullAdder
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity RippleCarryAdder_4bit is
    Port ( A 		: in  STD_LOGIC_VECTOR (3 downto 0);
           B 		: in  STD_LOGIC_VECTOR (3 downto 0);
           C_in 	: in  STD_LOGIC;
           C_out 	: out  STD_LOGIC;
           SUM 	: out  STD_LOGIC_VECTOR (3 downto 0));
end RippleCarryAdder_4bit;

architecture Structural of RippleCarryAdder_4bit is

	-- Components
		--Full Adder
	component FullAdder is 
		Port( A 		: in  STD_LOGIC;
				B 		: in  STD_LOGIC;
				C_in 	: in  STD_LOGIC;
				C_out : out  STD_LOGIC;
				Sum 	: out  STD_LOGIC);
	end component;
	

	-- Internal signals
		-- Carry Signals
	signal Carry0 : STD_LOGIC;
	signal Carry1 : STD_LOGIC;
	signal Carry2 : STD_LOGIC;
	
	
begin

	-- Instantiate FullAdders (4 FA for 4 bits)
	FA0 : FullAdder port map(
		 A     => A(0),
       B     => B(0),
       C_in  => C_in,
       C_out => Carry0,
       Sum   => SUM(0)
	);
	
	FA1 : FullAdder port map(
		 A     => A(1),
       B     => B(1),
       C_in  => Carry0,
       C_out => Carry1,
       Sum 	 => SUM(1)
	);
	
	FA2 : FullAdder port map(
		 A     => A(2),
       B     => B(2),
       C_in  => Carry1,
       C_out => Carry2,
       Sum   => SUM(2)
	);
	
	FA3 : FullAdder port map(
		 A     => A(3),
       B     => B(3),
       C_in  => Carry2,
       C_out => C_out,
       Sum   => SUM(3)
	);
	
	
	

end Structural;

