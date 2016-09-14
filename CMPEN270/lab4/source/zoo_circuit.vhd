----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:49:16 09/30/2014 
-- Design Name: 
-- Module Name:    zoo_circuit - zoo_a 
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

entity zoo_circuit is
    Port ( U : in  STD_LOGIC;
           A : in  STD_LOGIC;
           C : in  STD_LOGIC;
           S : in  STD_LOGIC;
           need_vac : out  STD_LOGIC;
           dangerous : out  STD_LOGIC;
           A1 : out  STD_LOGIC;
           B1 : out  STD_LOGIC;
           C1 : out  STD_LOGIC;
           D1 : out  STD_LOGIC;
           E1 : out  STD_LOGIC;
           F1 : out  STD_LOGIC;
           G1 : out  STD_LOGIC;
			  AN0 : out STD_LOGIC;
			  AN1 : out STD_LOGIC;
			  AN2 : out STD_LOGIC;
			  AN3 : out STD_LOGIC);
end zoo_circuit;

architecture zoo_a of zoo_circuit is


    COMPONENT seven_seg_display
    PORT(
         b0 : IN  std_logic;
         b1 : IN  std_logic;
         b2 : IN  std_logic;
         b3 : IN  std_logic;
         A : OUT  std_logic;
         B : OUT  std_logic;
         C : OUT  std_logic;
         D : OUT  std_logic;
         E : OUT  std_logic;
         F : OUT  std_logic;
         G : OUT  std_logic;
			AN : OUT std_logic
        );
    END COMPONENT;
	 
	 COMPONENT UAC_2_display is
    Port ( U : in  STD_LOGIC;
           A : in  STD_LOGIC;
           C : in  STD_LOGIC;
           b0 : out  STD_LOGIC;
           b1 : out  STD_LOGIC;
           b2 : out  STD_LOGIC;
           b3 : out  STD_LOGIC);
	end COMPONENT;
	
	COMPONENT uac_read is
	Port ( U : in  STD_LOGIC; 
           A : in  STD_LOGIC;
           C : in  STD_LOGIC;
           S : in  STD_LOGIC; -- Signal for sedated animals (1) for sedated, (0) otherwise.
           dangerous : out  STD_LOGIC;  -- (0) Animal is safe, (1) animal is dangerous.
           needs_vac : out  STD_LOGIC); -- (0) Animal does not need vaccine, (1) Animal needs vaccine
	 
	 end COMPONENT;
	 
	 signal in_b0, in_b1, in_b2, in_b3 : std_logic;
	 
begin
		--instantiate and link component
		
		uac_read_a : uac_read PORT MAP (
          U => U,
          A => A,
          C => C,
          S => S,
          dangerous => dangerous,
          needs_vac => need_vac
        );
		  
		uac2dis : UAC_2_display PORT MAP (
			U => U,
			A => A,
			C => C,
			b0 => in_b0,
			b1 => in_b1,
			b2 => in_b2,
			b3 => in_b3
		);
		
		seven_seg_1 : seven_seg_display PORT MAP (
			b0 => in_b0,
			b1 => in_b1,
			b2 => in_b2,
			b3 => in_b3,
         A => A1,
         B => B1,
         C => C1,
         D => D1,
         E => E1,
         F => F1,
         G => G1,
			AN => AN0
		);
		
		AN1 <= '1';
		AN2 <= '1';
		AN3 <= '1';


end zoo_a;

