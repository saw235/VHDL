----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:02:10 11/20/2014 
-- Design Name: 
-- Module Name:    BCDsingledigit - Behavioral 
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

entity BCDsingledigit is port
(
	rst : in std_logic;
	clk : in std_logic;
	
	butclk : in std_logic;
	buten : in std_logic;
	
	anode0 : out  STD_LOGIC;
   anode1 : out  STD_LOGIC;
   anode2 : out  STD_LOGIC;
   anode3 : out  STD_LOGIC;
	A : out  STD_LOGIC;
	B : out  STD_LOGIC;
	C : out  STD_LOGIC;
	D : out  STD_LOGIC;
	E : out  STD_LOGIC;
	F : out  STD_LOGIC;
	G : out  STD_LOGIC;
	led1 : out std_logic
	
);
end BCDsingledigit;

architecture Behavioral of BCDsingledigit is

component compareten is port
(				
			  b0 : in  STD_LOGIC; --right most bit
           b1 : in  STD_LOGIC;
           b2 : in  STD_LOGIC;
           b3 : in  STD_LOGIC; -- left most bit
           equal : out  STD_LOGIC
);
end component;

component counter is port
(
			Count : in  STD_LOGIC;
				clk : in STD_LOGIC;
           s0 : out  STD_LOGIC; --right most bit
           s1 : out  STD_LOGIC;
           s2 : out  STD_LOGIC;
           s3 : out  STD_LOGIC; --left most bit
           Rst : in  STD_LOGIC
);
end component;

component sevensegdd is port
(
clk : in STD_LOGIC;
			  a0: in STD_LOGIC; --most left bit
			  a1: in STD_LOGIC;
			  a2: in STD_LOGIC;
			  a3: in STD_LOGIC; --most right bit
		     b0: in STD_LOGIC;
			  b1: in STD_LOGIC;
			  b2: in STD_LOGIC;
			  b3: in STD_LOGIC;
			  anode0 : out  STD_LOGIC;
           anode1 : out  STD_LOGIC;
           anode2 : out  STD_LOGIC;
           anode3 : out  STD_LOGIC;
           A : out  STD_LOGIC;
           B : out  STD_LOGIC;
           C : out  STD_LOGIC;
           D : out  STD_LOGIC;
           E : out  STD_LOGIC;
           F : out  STD_LOGIC;
           G : out  STD_LOGIC
);

end component;

signal s0_in, s1_in, s2_in, s3_in : std_logic;

begin

sevenseg : sevsegdd port map
(	
	clk=> clk,
	a0 => s3_in, --anode 
	a1 => s2_in,
	a2 => s1_in,
	a3 => s0_in,
	b0 => '0',
	b1 => '0',
	b2 => '0',
	b3 => '0',
	anode0 => anode0,
			  anode1 => anode1,
			  anode2 => anode2,
			  anode3 => anode3,
           A => A,
           B => B,
           C => C,
           D => D,
           E => E,
           F => F,
           G => G
);

count : Counter port map
(
	Count => buten,
				clk => butclk,
           s0 => s0_in,
           s1 => s1_in,
           s2 => s2_in,
           s3 => s3_in,--left most bit
           Rst => rst
);

cmp : compareten port map
(
			  b0 => s0_in,
           b1 => s1_in,
           b2 => s2_in,
           b3 => s3_in, -- left most bit
           equal => led1
);

end Behavioral;

