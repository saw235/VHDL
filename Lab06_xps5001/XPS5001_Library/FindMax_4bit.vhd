----------------------------------------------------------------------------
-- Entity:        FindMax_4bit
-- Written By:    Saw Xue Zheng
-- Date Created:  9/10/2016
-- Description:   Output the Max of A, B, C, D
--
-- Revision History (date, initials, description):
-- 	9 September 16, xps5001, file created.

-- Dependencies:
--		Mux2to1_4bit
--    CompareGRT_4bit
----------------------------------------------------------------------------
library IEEE;
library XPS5001_Library;
use IEEE.STD_LOGIC_1164.ALL;
use XPS5001_Library.XPS5001_Components.ALL;

entity FindMax_4bit is
    Port (A 	: in  STD_LOGIC_VECTOR (3 downto 0);
          B 	: in  STD_LOGIC_VECTOR (3 downto 0);
          C 	: in  STD_LOGIC_VECTOR (3 downto 0);
          D 	: in  STD_LOGIC_VECTOR (3 downto 0);
          MAX  : out STD_LOGIC_VECTOR (3 downto 0));
end FindMax_4bit;

architecture Structural of FindMax_4bit is
	--Internal Signals
	signal GRT_int0 		: STD_LOGIC;
	signal GRT_int1 		: STD_LOGIC;
	signal GRT_int2 		: STD_LOGIC;
	signal mux0_out_int	: STD_LOGIC_VECTOR (3 downto 0);
	signal mux1_out_int	: STD_LOGIC_VECTOR (3 downto 0);
	
begin

   --2to1 Muxes
	mux0 : Mux2to1_4bit port map(
				X0 	=> A,
				X1 	=> B,
				SEL 	=> GRT_int0,
				Y 		=> mux0_out_int);
				
	mux1 : Mux2to1_4bit port map(
				X0 	=> C,
				X1 	=> D,
				SEL 	=> GRT_int1,
				Y 		=> mux1_out_int);
				
	mux2 : Mux2to1_4bit port map(
				X0 	=> mux0_out_int,
				X1 	=> mux1_out_int,
				SEL 	=> GRT_int2,
				Y 		=> MAX);
				
	--GRT_Comparators
	cmp_grt0 :	CompareGRT generic map (n => 4) port map(
						A 		=> B,
						B 		=> A,
						GRT 	=> GRT_int0);

	cmp_grt1 :	CompareGRT generic map (n => 4) port map(
						A 		=> D,
						B 		=> C,
						GRT 	=> GRT_int1);

	cmp_grt2 :	CompareGRT generic map (n => 4) port map(
						A 		=> mux1_out_int,
						B 		=> mux0_out_int,
						GRT 	=> GRT_int2);						
	

end Structural;

