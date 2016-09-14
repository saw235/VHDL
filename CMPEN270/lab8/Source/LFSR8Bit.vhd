----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:56:26 11/04/2014 
-- Design Name: 
-- Module Name:    LFSR8Bit - Behavioral 
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

entity LFSR8Bit is
    Port ( clk, rst : in STD_LOGIC;
				q1 : out  STD_LOGIC;
           q2 : out  STD_LOGIC;
           q3 : out  STD_LOGIC;
           q4 : out  STD_LOGIC;
           q5 : out  STD_LOGIC;
           q6 : out  STD_LOGIC;
           q7 : out  STD_LOGIC;
           q0 : out  STD_LOGIC);
end LFSR8Bit;

architecture Behavioral of LFSR8Bit is
component dff272 is port
	(
		 clk 	: in std_logic ;
		 clken : in std_logic;
		 rst 	: in std_logic ;
		 d 	: in std_logic ;
		 q 	: out std_logic
    );
end component;

--component clkdiv is port(
--clk : in  STD_LOGIC;
--Sclk: out STD_LOGIC
--);
--end component;
			
component enabler is port
(
			clk : in  STD_LOGIC;
		   Sen: out STD_LOGIC
);
end component;

signal sen, gateout, q0_in, q1_in ,q2_in, q3_in, q4_in, q5_in, q6_in, q7_in: STD_LOGIC;
begin

ena1 : enabler port map(
clk => clk,
Sen => sen
);

--div1 : clkdiv port map(
--clk => clk,
--Sclk => int_clk);
--sen <= '1';
gateout <= q3_in xnor q4_in xnor q5_in xnor q7_in;

dff0 : dff272 port map(
  clk => clk,
  clken => sen,
  rst => '0',
  d => gateout,
  q => q0_in
);


dff1 : dff272 port map(
  clk => clk,
  clken => sen,
  rst => '0',
  d => q0_in,
  q => q1_in
);

dff2 : dff272 port map(
  clk => clk,
  clken => sen,
  rst => '0',
  d => q1_in,
  q => q2_in
);

dff3 : dff272 port map(
  clk =>clk,
  clken => sen,
  rst => '0',
  d => q2_in,
  q => q3_in
);
dff4 : dff272 port map(
  clk => clk,
  clken => sen,
  rst => '0',
  d => q3_in,
  q => q4_in
);
dff5 : dff272 port map(
  clk => clk,
  clken => sen,
  rst => '0',
  d => q4_in,
  q => q5_in
);
dff6 : dff272 port map(
  clk => clk,
  clken => sen,
  rst => '0',
  d => q5_in,
  q => q6_in
);
dff7 : dff272 port map(
  clk => clk,
  clken => sen,
  rst => '0',
  d => q6_in,
  q => q7_in
);


q0 <= q0_in;
q1 <= q1_in;
q2 <= q2_in;
q3 <= q3_in;
q4 <= q4_in;
q5 <= q5_in;
q6 <= q6_in;
q7 <= q7_in;

end Behavioral;

