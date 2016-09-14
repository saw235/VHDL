----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:14:43 11/03/2014 
-- Design Name: 
-- Module Name:    comparator - Behavioral 
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

entity comparator is
    Port ( a0 : in  STD_LOGIC;
           a1 : in  STD_LOGIC;
           a2 : in  STD_LOGIC;
           a3 : in  STD_LOGIC;
           a4 : in  STD_LOGIC;
           a5 : in  STD_LOGIC;
           a6 : in  STD_LOGIC;
           a7 : in  STD_LOGIC;
           b0 : in  STD_LOGIC;
           b1 : in  STD_LOGIC;
           b2 : in  STD_LOGIC;
           b3 : in  STD_LOGIC;
           b4 : in  STD_LOGIC;
           b5 : in  STD_LOGIC;
           b6 : in  STD_LOGIC;
           b7 : in  STD_LOGIC;
           s0 : out  STD_LOGIC;
           s1 : out  STD_LOGIC;
           s2 : out  STD_LOGIC;
           s3 : out  STD_LOGIC;
           s4 : out  STD_LOGIC;
           s5 : out  STD_LOGIC;
           s6 : out  STD_LOGIC;
           s7 : out  STD_LOGIC;
			  s8 : out STD_LOGIC);
end comparator;

architecture Behavioral of comparator is

component Adder is port
(
				a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           ci : in  STD_LOGIC;
           co : out  STD_LOGIC;
           s : out  STD_LOGIC);
end component;

signal co0, co1, co2, co3, co4, co5, co6, co7, co8 : std_logic;
signal b0in, b1in, b2in, b3in, b4in, b5in, b6in, b7in : std_logic;

begin


b0in <= not b0;
b1in <= not b1;
b2in <= not b2;
b3in <= not b3;
b4in <= not b4;
b5in <= not b5;
b6in <= not b6;
b7in <= not b7;




adder0 : Adder port map(

a => a0,
b => b0in,
ci => '1',
co => co0,
s => s0
);

adder1 : Adder port map(

a => a1,
b => b1in,
ci => co0,
co => co1,
s => s1
);
adder2 : Adder port map(

a => a2,
b => b2in,
ci => co1,
co => co2,
s => s2
);
adder3 : Adder port map(

a => a3,
b => b3in,
ci => co2,
co => co3,
s => s3
);

adder4 : Adder port map(

a => a4,
b => b4in,
ci => co3,
co => co4,
s => s4
);

adder5 : Adder port map(

a => a5,
b => b5in,
ci => co4,
co => co5,
s => s5
);

adder6 : Adder port map(

a => a6,
b => b6in,
ci => co5,
co => co6,
s => s6
);
adder7 : Adder port map(

a => a7,
b => b7in,
ci => co6,
co => co7,
s => s7
);

adder8 : Adder port map(
a => '0',
b => '0',
ci => co7,
co => co8,
s => s8
);

end Behavioral;

