----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:40:51 11/17/2014 
-- Design Name: 
-- Module Name:    twobitcounter - Behavioral 
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

entity twobitcounter is
 Port ( Count : in  STD_LOGIC;
				clk : in STD_LOGIC;
           s0 : out  STD_LOGIC;
           s1 : out  STD_LOGIC;
           Rst : in  STD_LOGIC);
end twobitcounter;

architecture Behavioral of twobitcounter is

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

signal  q0, q1, co0, co1, s0_in, s1_in: STD_LOGIC;
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

s0 <= s0_in;
s1 <= s1_in;

end Behavioral;


