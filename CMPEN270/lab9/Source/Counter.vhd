----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:15:23 11/03/2014 
-- Design Name: 
-- Module Name:    Counter - Behavioral 
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

entity Counter is
    Port ( Count : in  STD_LOGIC;
				clk : in STD_LOGIC;
           s0 : out  STD_LOGIC; --right most bit
           s1 : out  STD_LOGIC;
           s2 : out  STD_LOGIC;
           s3 : out  STD_LOGIC; --left most bit
           Rst : in  STD_LOGIC);
end Counter;

architecture Behavioral of Counter is

component Adder is port
(
			a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           ci : in  STD_LOGIC;
           co : out  STD_LOGIC;
           s : out  STD_LOGIC);
			  
end component;
component dff272 is port
(
		clk 	: in std_logic ;
	  clken	: in std_logic ;
		 rst 	: in std_logic ;
		 d 	: in std_logic ;
		 q 	: out std_logic
    );
end component;

signal  q0, q1, q2, q3, co0, co1, co2, co3, s0_in, s1_in, s2_in, s3_in : STD_LOGIC;
signal cos0, cos1, cos2, cos3: std_logic;
begin

--ena1 : enabler port map(
--clk => clk,
--Sen => sen
--)

adder0 : Adder port map(

a => '1',
b => q0,
ci => '0',
co => co0,
s => s0_in
);

adder1 : Adder port map(

a => '0',
b => q1,
ci => co0,
co => co1,
s => s1_in
);
adder2 : Adder port map(

a => '0',
b => q2,
ci => co1,
co => co2,
s => s2_in
);
adder3 : Adder port map(

a => '0',
b => q3,
ci => co2,
co => co3,
s => s3_in
);

ff0 : dff272 port map(

clk 	=> clk,
		clken	=> Count,
		 rst 	=> Rst,
		 d 	=> s0_in,
		 q 	=> q0
);

ff1 : dff272 port map(

clk 	=> clk,
		clken	=> Count,
		 rst 	=> Rst,
		 d 	=> s1_in,
		 q 	=> q1
);
ff2 : dff272 port map(

clk 	=> clk,
		clken	=> Count,
		 rst 	=> Rst,
		 d 	=> s2_in,
		 q 	=> q2
);
ff3 : dff272 port map(

clk 	=> clk,
		clken	=> Count,
		 rst 	=> Rst,
		 d 	=> s3_in,
		 q 	=> q3
);

subtract3: Adder port map(
a => s3_in,
b => '1',
ci => cos2,
co => cos3,
s => s3
);
subtract2: Adder port map(
a => s2_in,
b => '1',
ci => cos1,
co => cos2,
s => s2
);
subtract1: Adder port map(
a => s1_in,
b => '1',
ci => cos0,
co => cos1,
s => s1
);
subtract0: Adder port map(
a => s0_in,
b => '1',
ci => '0',
co => cos0,
s => s0
);




end Behavioral;

