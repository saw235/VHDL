----------------------------------------------------------------------------
-- Entity:        Lab07_xps5001_kmr5802
-- Written By:    Saw Xue Zheng, Krishna Ramesh
-- Date Created:  10/23/2016
-- Description:   Timeout component
--
-- Revision History (date, initials, description):
-- 	

-- Dependencies:
--		Counter
--		
----------------------------------------------------------------------------


library IEEE;
library XPS5001_Library;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use XPS5001_Library.XPS5001_Components.ALL;

entity TimeOut is
generic ( n     : integer; 
          nbits : integer);
port(
        EN        : in    STD_LOGIC;
        CLK       : in    STD_LOGIC;
        CLR       : in    STD_LOGIC;
        Timeout   : out   STD_LOGIC
        );
end TimeOut;

architecture Behavioral of TimeOut is

             
signal counter_out : std_logic_vector(nbits - 1 downto 0);

begin

Timeout <= '1' when (unsigned(counter_out) = n) else '0';

c_ount : Counter generic map(n=> nbits) port map(
					EN 	=> EN,
					CLK	=> CLK,
					CLR	=> CLR,
					Q => counter_out
				);


end Behavioral;
