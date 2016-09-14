----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:11:13 11/17/2014 
-- Design Name: 
-- Module Name:    sevsegdd - Behavioral 
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

entity sevsegdd is
    Port ( clk : in STD_LOGIC;
			  a0: in STD_LOGIC; --most left bit
			  a1: in STD_LOGIC;
			  a2: in STD_LOGIC;
			  a3: in STD_LOGIC; --most right bit
		     b0: in STD_LOGIC;
			  b1: in STD_LOGIC;
			  b2: in STD_LOGIC;
			  b3: in STD_LOGIC;
			  c0: in STD_LOGIC;
			  c1: in STD_LOGIC;
			  c2: in STD_LOGIC;
			  c3: in STD_LOGIC;
			  d0: in STD_LOGIC;
			  d1: in STD_LOGIC;
			  d2: in STD_LOGIC;
			  d3: in STD_LOGIC;
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
           G : out  STD_LOGIC);
end sevsegdd;

architecture Behavioral of sevsegdd is

component twobitcounter is port
(
			Count : in  STD_LOGIC;
				clk : in STD_LOGIC;
           s0 : out  STD_LOGIC;
           s1 : out  STD_LOGIC;
           Rst : in  STD_LOGIC
);

end component;

component twofourdec is port
(
s0 : in  STD_LOGIC;
           s1 : in  STD_LOGIC;
           d0 : out  STD_LOGIC;
           d1 : out  STD_LOGIC;
           d2 : out  STD_LOGIC;
           d3 : out  STD_LOGIC
);

end component;

component fouronemux is port
( i0 : in  STD_LOGIC;
           i1 : in  STD_LOGIC;
           i2 : in  STD_LOGIC;
           i3 : in  STD_LOGIC;
           s1 : in  STD_LOGIC;
           s0 : in  STD_LOGIC;
           d : out  STD_LOGIC
);
end component;

component seven_seg_display is port
(
				b0 : in  STD_LOGIC; --is actually b3
           b1 : in  STD_LOGIC; --actually b2
           b2 : in  STD_LOGIC; -- so on.. :(
           b3 : in  STD_LOGIC;
			  anode0in : in STD_LOGIC;
			  anode1in : in STD_LOGIC;
			  anode2in : in STD_LOGIC;
			  anode3in : in STD_LOGIC;
			  anode0 : out STD_LOGIC;
			  anode1 : out STD_LOGIC;
			  anode2 : out STD_LOGIC;
			  anode3 : out STD_LOGIC;
           A : out  STD_LOGIC;
           B : out  STD_LOGIC;
           C : out  STD_LOGIC;
           D : out  STD_LOGIC;
           E : out  STD_LOGIC;
           F : out  STD_LOGIC;
           G : out  STD_LOGIC
);
end component;

component fenabler is port
(
			clk : in  STD_LOGIC;
		   Fen: out STD_LOGIC
);
end component;

signal count0_in, count1_in : STD_LOGIC;
signal anode0_in, anode1_in, anode2_in, anode3_in : std_logic;
signal out0_in, out1_in, out2_in, out3_in : std_logic;
signal fen :std_logic;

begin
fena1: fenabler port map
(
	clk => clk,
	Fen => fen
);

count1: twobitcounter port map
(
	Count => fen,
	clk => clk,
   s0 => count0_in,
	s1 => count1_in,
   Rst => '0'
		
);

dec1 : twofourdec port map
(
	 s0 => count1_in,
	 s1 => count0_in,
    d0 => anode3_in,
    d1 => anode2_in,
    d2 => anode1_in,
    d3 => anode0_in
);

---------------------------------muxes -------------------
mux0 : fouronemux port map  --most left bit
(
	i0 => d0 ,
   i1 => c0 ,
   i2 => b0,
   i3 => a0,
   s0 => count1_in,
	s1 => count0_in,
   d => out3_in
);

mux1 : fouronemux port map
(
	i0 => d1 ,
   i1 => c1 ,
   i2 => b1,
   i3 => a1,
   s0 => count1_in,
	s1 => count0_in,
   d => out2_in
);

mux2 : fouronemux port map
(
	i0 => d2 ,
   i1 => c2 ,
   i2 => b2,
   i3 => a2,
   s0 => count1_in,
	s1 => count0_in,
   d => out1_in
);

mux3 : fouronemux port map --most right bit
(
	i0 => d3 ,
   i1 => c3 ,
   i2 => b3,
   i3 => a3,
   s0 => count1_in,
	s1 => count0_in,
   d => out0_in
);

sevseg : seven_seg_display port map
(
			  b0 => out0_in,
           b1 => out1_in,
           b2 => out2_in,
           b3 => out3_in,
			  anode0in => anode0_in,
			  anode1in => anode1_in,
			  anode2in => anode2_in,
			  anode3in => anode3_in,
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

end Behavioral;

