----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:25:57 09/25/2016 
-- Design Name: 
-- Module Name:    img_Rom_480p - Behavioral 
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

entity img_Rom_480p is
    Port ( CLK : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           ADDR : in  STD_LOGIC_VECTOR (19 downto 0);
           DATA : out  STD_LOGIC_VECTOR (11 downto 0));
end img_Rom_480p;

architecture Behavioral of img_Rom_480p is

begin


end Behavioral;

