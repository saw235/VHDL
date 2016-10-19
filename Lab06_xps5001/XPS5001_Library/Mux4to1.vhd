----------------------------------------------------------------------------
-- Entity:        Mux4to1
-- Written By:    Saw Xue Zheng
-- Date Created:  9/17/2016
-- Description:   4to1 Mux
--
-- Revision History (date, initials, description):
-- 	17 September 16, xps5001, file created.

-- Dependencies:
--		None
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux4to1 is
	 Generic ( n : integer := 8);
    Port ( X0  : in  STD_LOGIC_VECTOR (n-1 downto 0);
           X1  : in  STD_LOGIC_VECTOR (n-1 downto 0);
           X2  : in  STD_LOGIC_VECTOR (n-1 downto 0);
           X3  : in  STD_LOGIC_VECTOR (n-1 downto 0);
           SEL : in  STD_LOGIC_VECTOR (1 downto 0);
           Y   : out  STD_LOGIC_VECTOR (n-1 downto 0));
end Mux4to1;

architecture Behavioral of Mux4to1 is

signal zeroes : STD_LOGIC_VECTOR (n-1 downto 0) := (others => '0');

begin

	with SEL select Y <= X0 when "00",
								X1 when "01",
								X2 when "10",
								X3 when "11",
								zeroes when others;


end Behavioral;

