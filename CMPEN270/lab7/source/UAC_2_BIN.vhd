
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

entity UAC_2_display is
    Port ( U : in  STD_LOGIC;
           A : in  STD_LOGIC;
           C : in  STD_LOGIC;
           b0 : out  STD_LOGIC;
           b1 : out  STD_LOGIC;
           b2 : out  STD_LOGIC;
           b3 : out  STD_LOGIC);
end UAC_2_display;

architecture uac_2_dis_a of UAC_2_display is

begin

b0 <= (U or C) and (not U or not A) and (not U or not C);
b1 <= (not C) or (not U and not A); 
b2 <= A or U;
b3 <= '1';

end uac_2_dis_a;

