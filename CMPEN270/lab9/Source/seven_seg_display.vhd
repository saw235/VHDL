----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:18:30 09/29/2014 
-- Design Name: 
-- Module Name:    seven_seg_display - 7_seg_display 
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

entity seven_seg_display is
    Port ( b0 : in  STD_LOGIC; -- most right bit
           b1 : in  STD_LOGIC; --
           b2 : in  STD_LOGIC; --
           b3 : in  STD_LOGIC; -- most left bit
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
           G : out  STD_LOGIC);
end seven_seg_display;

architecture seg_display_a of seven_seg_display is

signal A_sumterm1, A_sumterm2, A_sumterm3, A_sumterm4: std_logic;
signal B_sumterm1, B_sumterm2, B_sumterm3, B_sumterm4: std_logic;
signal C_sumterm1, C_sumterm2, C_sumterm3, C_sumterm4: std_logic;
signal D_sumterm1, D_sumterm2, D_sumterm3, D_sumterm4: std_logic;
signal E_productterm1, E_productterm2, E_productterm3, E_productterm4: std_logic;
signal F_sumterm1, F_sumterm2, F_sumterm3, F_sumterm4: std_logic;
signal G_sumterm1, G_sumterm2, G_sumterm3: std_logic;

begin

A_sumterm1 <= b3 or not b2 or b1 or b0;
A_sumterm2 <= b3 or b2 or b1 or not b0;
A_sumterm3 <= not b3 or not b2 or b1 or not b0;
A_sumterm4 <= not b3 or b2 or not b1 or not b0;

A <= not(A_sumterm1 and A_sumterm2 and A_sumterm3 and A_sumterm4);

--------------------------------------------------------------------
B_sumterm1 <= not b0 or b1 or not b2 or b3;
B_sumterm2 <= b0 or not b1 or not b2;
B_sumterm3 <= b0 or not b2 or not b3;
B_sumterm4 <= not b0 or not b1 or not b3;

B <= not(B_sumterm1 and B_sumterm2 and B_sumterm3 and B_sumterm4);

--------------------------------------------------------------------

C_sumterm1 <= not b3 or not b2 or b1 or b0;
C_sumterm2 <= not b3 or not b2 or not b1 or not b0;
C_sumterm3 <= not b3 or not b2 or not b1 or b0;
C_sumterm4 <= b3 or b2 or not b1 or b0;

C <= not(C_sumterm1 and C_sumterm2 and C_sumterm3 and c_sumterm4);

----------------------------------------------------------------------

D_sumterm1 <= b3 or not b2 or b1 or b0;
D_sumterm2 <= b2 or b1 or not b0;
D_sumterm3 <= not b2 or not b1 or not b0;
D_sumterm4 <= not b3 or b2 or not b1 or b0;

D <= not(D_sumterm1 and D_sumterm2 and D_sumterm3 and D_sumterm4);

------------------------------------------------------------------------

E_productterm1 <= b1 and b3;
E_productterm2 <= (not b0) and b1;
E_productterm3 <= (not b0) and (not b2);
E_productterm4 <= b2 and b3;

E <= not(E_productterm1 or E_productterm2 or E_productterm3 or E_productterm4);

---------------------------------------------------------------------------

F_sumterm1 <= not b0 or b1 or not b2 or not b3;
F_sumterm2 <= not b0 or not b1 or b3;
F_sumterm3 <= not b0 or b2 or b3;
F_sumterm4 <= not b1 or b2 or b3;

F <= not( F_sumterm1 and F_sumterm2 and F_sumterm3 and F_sumterm4);

---------------------------------------------------------------------------

G_sumterm1 <= b0 or b1 or not b2 or not b3;
G_sumterm2 <= not b0 or not b1 or not b2 or b3;
G_sumterm3 <= b1 or b2 or b3;

G <= not(G_sumterm1 and G_sumterm2 and G_sumterm3);

anode0 <= anode0in;
anode1 <= anode1in;
anode2 <= anode2in;
anode3 <= anode3in;
end seg_display_a;

