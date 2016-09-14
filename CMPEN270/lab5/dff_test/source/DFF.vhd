----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:23:50 10/13/2014 
-- Design Name: 
-- Module Name:    DFF - dff 
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

entity DFF is
    Port ( Clk_DFF : in  STD_LOGIC;
           D_DFF : in  STD_LOGIC;
           Q_DFF : out  STD_LOGIC);
end DFF;

architecture dff of DFF is

component Dlatch is
		Port ( Clk : in  STD_LOGIC;
           D : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end component;

signal clk1, d1, q1, clk2, d2, q2 : std_logic;

begin

dlatch1 : Dlatch Port Map(
				Clk => clk1,
				D => d1,
				Q => q1);
				
dlatch2 : Dlatch Port Map(
				Clk => clk2,
				D => d2,
				Q => q2);

clk1 <= not Clk_DFF;
clk2 <= Clk_DFF;

d1 <= D_DFF;
d2 <= q1;

Q_DFF <= q2;

end dff;

