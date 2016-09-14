------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: 10/09/14
-- Lab # and name	: Lab5 - Latches and Flip-Flops
-- Student 1		: Robin Panda
-- Student 2		: That Other Guy Jr.

-- Description		: This file defines a debouncer for eliminating the logic noise presented on an input.
--					  Utilizes code style that should not be used elsewhere in lab.

-- Changes 
-- 		1.0	- Original from Digilent
--		1.1	- Modified to deal with a single input and not sample on every clock (only 1MHz)

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------

-- Library Declarations 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Entity 
entity Debouncer is
    Port ( clk : in  STD_LOGIC;
			-- signals from the pmod
           Ain : in  STD_LOGIC; 
			-- debounced signals 
			  Aout: out STD_LOGIC
			  );
end Debouncer;

-- Architecture 
-- DO NOT USE THESE IN YOUR CODE
architecture Behavioral of Debouncer is
----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	-------------------------------------------------------

	-- NONE	
	
	-------------------------------------------------------
	-- Internal Signal Declarations	
	-------------------------------------------------------

signal sclk: std_logic_vector (6 downto 0);
signal sampledA, sampledB : std_logic;

begin
	process(clk)
		begin 
			if clk'event and clk = '1' then
				-- clock is divided to 1MHz
				-- samples every 1uS to check if the input is the same as the sample
				-- if the signal is stable, the debouncer should output the signal
				if sclk = "1100100" then
					if sampledA = Ain then 
						Aout <= Ain;
					end if;
					sclk <="0000000";
					sampledA <= Ain;
				else
					sclk <= sclk +1;
				end if;
			end if;
	end process;
	
end Behavioral;

