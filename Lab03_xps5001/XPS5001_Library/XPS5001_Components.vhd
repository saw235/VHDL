----------------------------------------------------------------------------
-- Entity:        XPS5001_Components
-- Written By:    Saw Xue Zheng
-- Date Created:  9 Sep 14
-- Description:   Package definition for common components
--
-- Revision History (date, initials, description):
-- 	(none)
-- Dependencies:
--  All components declared in this definition
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;


----------------------------------------------------------------------------
package XPS5001_Components is

	component FullAdder is
		port (A 		: in  STD_LOGIC;
				B 		: in  STD_LOGIC;
				C_in 	: in  STD_LOGIC;
				C_out : out  STD_LOGIC;
				Sum 	: out  STD_LOGIC);
	end component;

	component RippleCarryAdder_4bit is
		Port (A 		: in  STD_LOGIC_VECTOR (3 downto 0);
				B 		: in  STD_LOGIC_VECTOR (3 downto 0);
				C_in 	: in  STD_LOGIC;
				C_out : out  STD_LOGIC;
				SUM 	: out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component HexToSevenSeg is
		Port (HEX 		: in  STD_LOGIC_VECTOR (3 downto 0);
				SEGMENT 	: out  STD_LOGIC_VECTOR (0 to 6));
	end component;
	
	component Mux4to1_4bit is
		Port (X0 	: in  STD_LOGIC_VECTOR (3 downto 0);
				X1 	: in  STD_LOGIC_VECTOR (3 downto 0);
				X2 	: in  STD_LOGIC_VECTOR (3 downto 0);
				X3 	: in  STD_LOGIC_VECTOR (3 downto 0);
				SEL 	: in  STD_LOGIC_VECTOR (1 downto 0);
				Y 		: out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component Mux2to1_4bit is
		Port (X0 	: in  STD_LOGIC_VECTOR (3 downto 0);
				X1 	: in  STD_LOGIC_VECTOR (3 downto 0);
				SEL 	: in  STD_LOGIC;
				Y 		: out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
		
	component CompareEQU_4bit is
		Port (A 	: in  STD_LOGIC_VECTOR (3 downto 0);
				B 	: in  STD_LOGIC_VECTOR (3 downto 0);
				EQU: out  STD_LOGIC);
	end component;
	
	component CompareGRT_4bit is
		Port (A 	: in  STD_LOGIC_VECTOR (3 downto 0);
				B 	: in  STD_LOGIC_VECTOR (3 downto 0);
				GRT: out  STD_LOGIC);
	end component;
	
	component CompareLES_4bit is
		Port (A 	: in  STD_LOGIC_VECTOR (3 downto 0);
				B 	: in  STD_LOGIC_VECTOR (3 downto 0);
				LES: out  STD_LOGIC);
	end component;
	
   component FindMax_4bit
   Port(A 	: in  std_logic_vector(3 downto 0);
        B 	: in  std_logic_vector(3 downto 0);
        C 	: in  std_logic_vector(3 downto 0);
        D 	: in  std_logic_vector(3 downto 0);
        MAX : out  std_logic_vector(3 downto 0)
       );
	end component;
	
   component FindMin_4bit
   Port(A 	: in  std_logic_vector(3 downto 0);
        B 	: in  std_logic_vector(3 downto 0);
        C 	: in  std_logic_vector(3 downto 0);
        D 	: in  std_logic_vector(3 downto 0);
        MIN : out  std_logic_vector(3 downto 0)
       );
	end component;
	
    component Decoder3to8
    Port(X 	: in  std_logic_vector(2 downto 0);
         EN : in  std_logic;
         Y 	: out  std_logic_vector(7 downto 0)
        );
    end component;	
	 
    component FindAverage_4bit
    Port(
         A : in  std_logic_vector(3 downto 0);
         B : in  std_logic_vector(3 downto 0);
         C : in  std_logic_vector(3 downto 0);
         D : in  std_logic_vector(3 downto 0);
         AVERAGE : out  std_logic_vector(3 downto 0)
        );
    end component;
	 
	 Component RippleCarryAdder
	 Generic ( n: integer);
    Port ( A 		: in  STD_LOGIC_VECTOR (n-1 downto 0);
           B 		: in  STD_LOGIC_VECTOR (n-1 downto 0);
           C_in 	: in  STD_LOGIC;
           C_out 	: out  STD_LOGIC;
           SUM 	: out  STD_LOGIC_VECTOR (n-1 downto 0));
	end component;
	
	Component Mux4to1
	Generic ( n : integer := 8);
   Port ( X0  : in  STD_LOGIC_VECTOR (n-1 downto 0);
          X1  : in  STD_LOGIC_VECTOR (n-1 downto 0);
          X2  : in  STD_LOGIC_VECTOR (n-1 downto 0);
          X3  : in  STD_LOGIC_VECTOR (n-1 downto 0);
          SEL : in  STD_LOGIC_VECTOR (1 downto 0);
          Y  : out  STD_LOGIC_VECTOR (n-1 downto 0));
	end component;
	
	
	Component CompareEQU
	Generic ( n : integer := 8);
   Port ( A	 	: in  STD_LOGIC_VECTOR (n-1 downto 0);
          B	 	: in  STD_LOGIC_VECTOR (n-1 downto 0);
          EQU	: out  STD_LOGIC);
	end component;
	
	Component CompareGRT
	Generic ( n : integer := 8);
   Port ( A	 	: in  STD_LOGIC_VECTOR (n-1 downto 0);
          B	 	: in  STD_LOGIC_VECTOR (n-1 downto 0);
          GRT	: out  STD_LOGIC);
	end component;

	Component CompareLES
	Generic ( n : integer := 8);
   Port ( A	 	: in  STD_LOGIC_VECTOR (n-1 downto 0);
          B	 	: in  STD_LOGIC_VECTOR (n-1 downto 0);
          LES	: out  STD_LOGIC);
	end component;	
	
	COMPONENT AdderSubtractor
	Generic ( n : integer := 8);
   PORT(
         A 			: IN  std_logic_vector(n-1 downto 0);
         B 			: IN  std_logic_vector(n-1 downto 0);
         SUBTRACT : IN  std_logic;
         SUM 		: OUT  std_logic_vector(n-1 downto 0);
         OVERFLOW : OUT  std_logic
       );
	end component;
	
	
end XPS5001_Components;
----------------------------------------------------------------------------

----------------------------------------------------------------------------
package body XPS5001_Components is

end XPS5001_Components;
----------------------------------------------------------------------------
