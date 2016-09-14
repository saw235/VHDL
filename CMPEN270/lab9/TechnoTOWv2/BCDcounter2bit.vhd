----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:49:30 11/18/2014 
-- Design Name: 
-- Module Name:    BCDcounter2bit - Behavioral 
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

entity BCDcounter2bit is port
(
	rst : in std_logic;
	clk : in std_logic;
	
	count : in std_logic;
	
	a0 : out std_logic; --right most bit
	a1: out std_logic;
	a2: out std_logic;
	a3 : out std_logic; --left most
	
	b0: out std_logic; --right most bit
	b1: out std_logic;
	b2: out std_logic;
	b3: out std_logic -- left most
	
);

end BCDcounter2bit;

architecture Behavioral of BCDcounter2bit is

component Counter is port
(
	Count : in  STD_LOGIC;
				clk : in STD_LOGIC;
           s0 : out  STD_LOGIC;
           s1 : out  STD_LOGIC;
           s2 : out  STD_LOGIC;
           s3 : out  STD_LOGIC;
           Rst : in  STD_LOGIC
);
end component;

component compareten is port
(
		b0 : in  STD_LOGIC;
           b1 : in  STD_LOGIC;
           b2 : in  STD_LOGIC;
           b3 : in  STD_LOGIC;
           equal : out  STD_LOGIC
);
end component;


signal c0s0, c0s1, c0s2, c0s3 : std_logic;
signal c1s0, c1s1, c1s2, c1s3 : std_logic;
signal rstc0, rstc1 : std_logic;
signal c0equal10, c1equal10: std_logic;



begin


rstc0 <= rst or c0equal10;
rstc1 <= rst or c1equal10; 

count0 : Counter port map
(
	Count => count,
	clk => clk,
	s0 => c0s0, --right most bit
	s1 => c0s1,
	s2 => c0s2,
	s3 => c0s3,
	Rst => rstc0
);

count1 : Counter port map
(
	Count => c0equal10,
	clk => clk,
	s0 => c1s0,
	s1 => c1s1,
	s2 => c1s2,
	s3 => c1s3,
	Rst => rstc1
);

c0compare10 : compareten port map
(
	b0 => c0s0,
	b1 => c0s1,
	b2 => c0s2,
	b3 => c0s3,
	equal => c0equal10
);

c1compare10 : compareten port map
(
	b0 => c1s0,
	b1 => c1s1,
	b2 => c1s2,
	b3 => c1s3,
	equal => c1equal10
);

a0 <= c0s0;
a1 <= c0s1;
a2 <= c0s2;
a3 <= c0s3;

b0 <= c1s0;
b1 <= c1s1;
b2 <= c1s2;
b3 <= c1s3;
end Behavioral;

