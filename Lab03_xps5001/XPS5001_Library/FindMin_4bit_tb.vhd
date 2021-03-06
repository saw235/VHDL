----------------------------------------------------------------------------
-- Entity:        FindMin_4bit_tb
-- Written By:    Saw Xue Zheng
-- Date Created:  9/10/2016
-- Description:   Testbench for FindMin_4bit
--
-- Revision History (date, initials, description):
-- 	9 September 16, xps5001, file created.

-- Dependencies:
--		FindMin_4bit
----------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY FindMin_4bit_tb IS
END FindMin_4bit_tb;
 
ARCHITECTURE behavior OF FindMin_4bit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FindMin_4bit
    PORT(
         A   : IN  std_logic_vector(3 downto 0);
         B   : IN  std_logic_vector(3 downto 0);
         C   : IN  std_logic_vector(3 downto 0);
         D   : IN  std_logic_vector(3 downto 0);
         MIN : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');
   signal C : std_logic_vector(3 downto 0) := (others => '0');
   signal D : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal MIN : std_logic_vector(3 downto 0);

   -- Test vector includes input stimuli and expected outputs
   -- A      : bits 19..16
   -- B 		 : bits 15..12
   -- C      : bits 11..8
   -- D 		 : bits 7..4
   -- MIN    : bits 3..0
	-- test vector is A & B & C & D & MIN
	-- test for combinations of A = B = C = D  = {0, 1, 7, 14, 15}
	type test_vector_type is array(0 to 624) of STD_LOGIC_VECTOR (19 downto 0);
	constant test_vector : test_vector_type := (
	--A			 	B			  C			  D			 MIN
	"0000"	&	"0000"	&	"0000"	&	"0000"	&	"0000",
	"0000"	&	"0000"	&	"0000"	&	"0001"	&	"0000",
	"0000"	&	"0000"	&	"0000"	&	"0111"	&	"0000",
	"0000"	&	"0000"	&	"0000"	&	"1110"	&	"0000",
	"0000"	&	"0000"	&	"0000"	&	"1111"	&	"0000",
	"0000"	&	"0000"	&	"0001"	&	"0000"	&	"0000",
	"0000"	&	"0000"	&	"0001"	&	"0001"	&	"0000",
	"0000"	&	"0000"	&	"0001"	&	"0111"	&	"0000",
	"0000"	&	"0000"	&	"0001"	&	"1110"	&	"0000",
	"0000"	&	"0000"	&	"0001"	&	"1111"	&	"0000",
	"0000"	&	"0000"	&	"0111"	&	"0000"	&	"0000",
	"0000"	&	"0000"	&	"0111"	&	"0001"	&	"0000",
	"0000"	&	"0000"	&	"0111"	&	"0111"	&	"0000",
	"0000"	&	"0000"	&	"0111"	&	"1110"	&	"0000",
	"0000"	&	"0000"	&	"0111"	&	"1111"	&	"0000",
	"0000"	&	"0000"	&	"1110"	&	"0000"	&	"0000",
	"0000"	&	"0000"	&	"1110"	&	"0001"	&	"0000",
	"0000"	&	"0000"	&	"1110"	&	"0111"	&	"0000",
	"0000"	&	"0000"	&	"1110"	&	"1110"	&	"0000",
	"0000"	&	"0000"	&	"1110"	&	"1111"	&	"0000",
	"0000"	&	"0000"	&	"1111"	&	"0000"	&	"0000",
	"0000"	&	"0000"	&	"1111"	&	"0001"	&	"0000",
	"0000"	&	"0000"	&	"1111"	&	"0111"	&	"0000",
	"0000"	&	"0000"	&	"1111"	&	"1110"	&	"0000",
	"0000"	&	"0000"	&	"1111"	&	"1111"	&	"0000",
	"0000"	&	"0001"	&	"0000"	&	"0000"	&	"0000",
	"0000"	&	"0001"	&	"0000"	&	"0001"	&	"0000",
	"0000"	&	"0001"	&	"0000"	&	"0111"	&	"0000",
	"0000"	&	"0001"	&	"0000"	&	"1110"	&	"0000",
	"0000"	&	"0001"	&	"0000"	&	"1111"	&	"0000",
	"0000"	&	"0001"	&	"0001"	&	"0000"	&	"0000",
	"0000"	&	"0001"	&	"0001"	&	"0001"	&	"0000",
	"0000"	&	"0001"	&	"0001"	&	"0111"	&	"0000",
	"0000"	&	"0001"	&	"0001"	&	"1110"	&	"0000",
	"0000"	&	"0001"	&	"0001"	&	"1111"	&	"0000",
	"0000"	&	"0001"	&	"0111"	&	"0000"	&	"0000",
	"0000"	&	"0001"	&	"0111"	&	"0001"	&	"0000",
	"0000"	&	"0001"	&	"0111"	&	"0111"	&	"0000",
	"0000"	&	"0001"	&	"0111"	&	"1110"	&	"0000",
	"0000"	&	"0001"	&	"0111"	&	"1111"	&	"0000",
	"0000"	&	"0001"	&	"1110"	&	"0000"	&	"0000",
	"0000"	&	"0001"	&	"1110"	&	"0001"	&	"0000",
	"0000"	&	"0001"	&	"1110"	&	"0111"	&	"0000",
	"0000"	&	"0001"	&	"1110"	&	"1110"	&	"0000",
	"0000"	&	"0001"	&	"1110"	&	"1111"	&	"0000",
	"0000"	&	"0001"	&	"1111"	&	"0000"	&	"0000",
	"0000"	&	"0001"	&	"1111"	&	"0001"	&	"0000",
	"0000"	&	"0001"	&	"1111"	&	"0111"	&	"0000",
	"0000"	&	"0001"	&	"1111"	&	"1110"	&	"0000",
	"0000"	&	"0001"	&	"1111"	&	"1111"	&	"0000",
	"0000"	&	"0111"	&	"0000"	&	"0000"	&	"0000",
	"0000"	&	"0111"	&	"0000"	&	"0001"	&	"0000",
	"0000"	&	"0111"	&	"0000"	&	"0111"	&	"0000",
	"0000"	&	"0111"	&	"0000"	&	"1110"	&	"0000",
	"0000"	&	"0111"	&	"0000"	&	"1111"	&	"0000",
	"0000"	&	"0111"	&	"0001"	&	"0000"	&	"0000",
	"0000"	&	"0111"	&	"0001"	&	"0001"	&	"0000",
	"0000"	&	"0111"	&	"0001"	&	"0111"	&	"0000",
	"0000"	&	"0111"	&	"0001"	&	"1110"	&	"0000",
	"0000"	&	"0111"	&	"0001"	&	"1111"	&	"0000",
	"0000"	&	"0111"	&	"0111"	&	"0000"	&	"0000",
	"0000"	&	"0111"	&	"0111"	&	"0001"	&	"0000",
	"0000"	&	"0111"	&	"0111"	&	"0111"	&	"0000",
	"0000"	&	"0111"	&	"0111"	&	"1110"	&	"0000",
	"0000"	&	"0111"	&	"0111"	&	"1111"	&	"0000",
	"0000"	&	"0111"	&	"1110"	&	"0000"	&	"0000",
	"0000"	&	"0111"	&	"1110"	&	"0001"	&	"0000",
	"0000"	&	"0111"	&	"1110"	&	"0111"	&	"0000",
	"0000"	&	"0111"	&	"1110"	&	"1110"	&	"0000",
	"0000"	&	"0111"	&	"1110"	&	"1111"	&	"0000",
	"0000"	&	"0111"	&	"1111"	&	"0000"	&	"0000",
	"0000"	&	"0111"	&	"1111"	&	"0001"	&	"0000",
	"0000"	&	"0111"	&	"1111"	&	"0111"	&	"0000",
	"0000"	&	"0111"	&	"1111"	&	"1110"	&	"0000",
	"0000"	&	"0111"	&	"1111"	&	"1111"	&	"0000",
	"0000"	&	"1110"	&	"0000"	&	"0000"	&	"0000",
	"0000"	&	"1110"	&	"0000"	&	"0001"	&	"0000",
	"0000"	&	"1110"	&	"0000"	&	"0111"	&	"0000",
	"0000"	&	"1110"	&	"0000"	&	"1110"	&	"0000",
	"0000"	&	"1110"	&	"0000"	&	"1111"	&	"0000",
	"0000"	&	"1110"	&	"0001"	&	"0000"	&	"0000",
	"0000"	&	"1110"	&	"0001"	&	"0001"	&	"0000",
	"0000"	&	"1110"	&	"0001"	&	"0111"	&	"0000",
	"0000"	&	"1110"	&	"0001"	&	"1110"	&	"0000",
	"0000"	&	"1110"	&	"0001"	&	"1111"	&	"0000",
	"0000"	&	"1110"	&	"0111"	&	"0000"	&	"0000",
	"0000"	&	"1110"	&	"0111"	&	"0001"	&	"0000",
	"0000"	&	"1110"	&	"0111"	&	"0111"	&	"0000",
	"0000"	&	"1110"	&	"0111"	&	"1110"	&	"0000",
	"0000"	&	"1110"	&	"0111"	&	"1111"	&	"0000",
	"0000"	&	"1110"	&	"1110"	&	"0000"	&	"0000",
	"0000"	&	"1110"	&	"1110"	&	"0001"	&	"0000",
	"0000"	&	"1110"	&	"1110"	&	"0111"	&	"0000",
	"0000"	&	"1110"	&	"1110"	&	"1110"	&	"0000",
	"0000"	&	"1110"	&	"1110"	&	"1111"	&	"0000",
	"0000"	&	"1110"	&	"1111"	&	"0000"	&	"0000",
	"0000"	&	"1110"	&	"1111"	&	"0001"	&	"0000",
	"0000"	&	"1110"	&	"1111"	&	"0111"	&	"0000",
	"0000"	&	"1110"	&	"1111"	&	"1110"	&	"0000",
	"0000"	&	"1110"	&	"1111"	&	"1111"	&	"0000",
	"0000"	&	"1111"	&	"0000"	&	"0000"	&	"0000",
	"0000"	&	"1111"	&	"0000"	&	"0001"	&	"0000",
	"0000"	&	"1111"	&	"0000"	&	"0111"	&	"0000",
	"0000"	&	"1111"	&	"0000"	&	"1110"	&	"0000",
	"0000"	&	"1111"	&	"0000"	&	"1111"	&	"0000",
	"0000"	&	"1111"	&	"0001"	&	"0000"	&	"0000",
	"0000"	&	"1111"	&	"0001"	&	"0001"	&	"0000",
	"0000"	&	"1111"	&	"0001"	&	"0111"	&	"0000",
	"0000"	&	"1111"	&	"0001"	&	"1110"	&	"0000",
	"0000"	&	"1111"	&	"0001"	&	"1111"	&	"0000",
	"0000"	&	"1111"	&	"0111"	&	"0000"	&	"0000",
	"0000"	&	"1111"	&	"0111"	&	"0001"	&	"0000",
	"0000"	&	"1111"	&	"0111"	&	"0111"	&	"0000",
	"0000"	&	"1111"	&	"0111"	&	"1110"	&	"0000",
	"0000"	&	"1111"	&	"0111"	&	"1111"	&	"0000",
	"0000"	&	"1111"	&	"1110"	&	"0000"	&	"0000",
	"0000"	&	"1111"	&	"1110"	&	"0001"	&	"0000",
	"0000"	&	"1111"	&	"1110"	&	"0111"	&	"0000",
	"0000"	&	"1111"	&	"1110"	&	"1110"	&	"0000",
	"0000"	&	"1111"	&	"1110"	&	"1111"	&	"0000",
	"0000"	&	"1111"	&	"1111"	&	"0000"	&	"0000",
	"0000"	&	"1111"	&	"1111"	&	"0001"	&	"0000",
	"0000"	&	"1111"	&	"1111"	&	"0111"	&	"0000",
	"0000"	&	"1111"	&	"1111"	&	"1110"	&	"0000",
	"0000"	&	"1111"	&	"1111"	&	"1111"	&	"0000",
	"0001"	&	"0000"	&	"0000"	&	"0000"	&	"0000",
	"0001"	&	"0000"	&	"0000"	&	"0001"	&	"0000",
	"0001"	&	"0000"	&	"0000"	&	"0111"	&	"0000",
	"0001"	&	"0000"	&	"0000"	&	"1110"	&	"0000",
	"0001"	&	"0000"	&	"0000"	&	"1111"	&	"0000",
	"0001"	&	"0000"	&	"0001"	&	"0000"	&	"0000",
	"0001"	&	"0000"	&	"0001"	&	"0001"	&	"0000",
	"0001"	&	"0000"	&	"0001"	&	"0111"	&	"0000",
	"0001"	&	"0000"	&	"0001"	&	"1110"	&	"0000",
	"0001"	&	"0000"	&	"0001"	&	"1111"	&	"0000",
	"0001"	&	"0000"	&	"0111"	&	"0000"	&	"0000",
	"0001"	&	"0000"	&	"0111"	&	"0001"	&	"0000",
	"0001"	&	"0000"	&	"0111"	&	"0111"	&	"0000",
	"0001"	&	"0000"	&	"0111"	&	"1110"	&	"0000",
	"0001"	&	"0000"	&	"0111"	&	"1111"	&	"0000",
	"0001"	&	"0000"	&	"1110"	&	"0000"	&	"0000",
	"0001"	&	"0000"	&	"1110"	&	"0001"	&	"0000",
	"0001"	&	"0000"	&	"1110"	&	"0111"	&	"0000",
	"0001"	&	"0000"	&	"1110"	&	"1110"	&	"0000",
	"0001"	&	"0000"	&	"1110"	&	"1111"	&	"0000",
	"0001"	&	"0000"	&	"1111"	&	"0000"	&	"0000",
	"0001"	&	"0000"	&	"1111"	&	"0001"	&	"0000",
	"0001"	&	"0000"	&	"1111"	&	"0111"	&	"0000",
	"0001"	&	"0000"	&	"1111"	&	"1110"	&	"0000",
	"0001"	&	"0000"	&	"1111"	&	"1111"	&	"0000",
	"0001"	&	"0001"	&	"0000"	&	"0000"	&	"0000",
	"0001"	&	"0001"	&	"0000"	&	"0001"	&	"0000",
	"0001"	&	"0001"	&	"0000"	&	"0111"	&	"0000",
	"0001"	&	"0001"	&	"0000"	&	"1110"	&	"0000",
	"0001"	&	"0001"	&	"0000"	&	"1111"	&	"0000",
	"0001"	&	"0001"	&	"0001"	&	"0000"	&	"0000",
	"0001"	&	"0001"	&	"0001"	&	"0001"	&	"0001",
	"0001"	&	"0001"	&	"0001"	&	"0111"	&	"0001",
	"0001"	&	"0001"	&	"0001"	&	"1110"	&	"0001",
	"0001"	&	"0001"	&	"0001"	&	"1111"	&	"0001",
	"0001"	&	"0001"	&	"0111"	&	"0000"	&	"0000",
	"0001"	&	"0001"	&	"0111"	&	"0001"	&	"0001",
	"0001"	&	"0001"	&	"0111"	&	"0111"	&	"0001",
	"0001"	&	"0001"	&	"0111"	&	"1110"	&	"0001",
	"0001"	&	"0001"	&	"0111"	&	"1111"	&	"0001",
	"0001"	&	"0001"	&	"1110"	&	"0000"	&	"0000",
	"0001"	&	"0001"	&	"1110"	&	"0001"	&	"0001",
	"0001"	&	"0001"	&	"1110"	&	"0111"	&	"0001",
	"0001"	&	"0001"	&	"1110"	&	"1110"	&	"0001",
	"0001"	&	"0001"	&	"1110"	&	"1111"	&	"0001",
	"0001"	&	"0001"	&	"1111"	&	"0000"	&	"0000",
	"0001"	&	"0001"	&	"1111"	&	"0001"	&	"0001",
	"0001"	&	"0001"	&	"1111"	&	"0111"	&	"0001",
	"0001"	&	"0001"	&	"1111"	&	"1110"	&	"0001",
	"0001"	&	"0001"	&	"1111"	&	"1111"	&	"0001",
	"0001"	&	"0111"	&	"0000"	&	"0000"	&	"0000",
	"0001"	&	"0111"	&	"0000"	&	"0001"	&	"0000",
	"0001"	&	"0111"	&	"0000"	&	"0111"	&	"0000",
	"0001"	&	"0111"	&	"0000"	&	"1110"	&	"0000",
	"0001"	&	"0111"	&	"0000"	&	"1111"	&	"0000",
	"0001"	&	"0111"	&	"0001"	&	"0000"	&	"0000",
	"0001"	&	"0111"	&	"0001"	&	"0001"	&	"0001",
	"0001"	&	"0111"	&	"0001"	&	"0111"	&	"0001",
	"0001"	&	"0111"	&	"0001"	&	"1110"	&	"0001",
	"0001"	&	"0111"	&	"0001"	&	"1111"	&	"0001",
	"0001"	&	"0111"	&	"0111"	&	"0000"	&	"0000",
	"0001"	&	"0111"	&	"0111"	&	"0001"	&	"0001",
	"0001"	&	"0111"	&	"0111"	&	"0111"	&	"0001",
	"0001"	&	"0111"	&	"0111"	&	"1110"	&	"0001",
	"0001"	&	"0111"	&	"0111"	&	"1111"	&	"0001",
	"0001"	&	"0111"	&	"1110"	&	"0000"	&	"0000",
	"0001"	&	"0111"	&	"1110"	&	"0001"	&	"0001",
	"0001"	&	"0111"	&	"1110"	&	"0111"	&	"0001",
	"0001"	&	"0111"	&	"1110"	&	"1110"	&	"0001",
	"0001"	&	"0111"	&	"1110"	&	"1111"	&	"0001",
	"0001"	&	"0111"	&	"1111"	&	"0000"	&	"0000",
	"0001"	&	"0111"	&	"1111"	&	"0001"	&	"0001",
	"0001"	&	"0111"	&	"1111"	&	"0111"	&	"0001",
	"0001"	&	"0111"	&	"1111"	&	"1110"	&	"0001",
	"0001"	&	"0111"	&	"1111"	&	"1111"	&	"0001",
	"0001"	&	"1110"	&	"0000"	&	"0000"	&	"0000",
	"0001"	&	"1110"	&	"0000"	&	"0001"	&	"0000",
	"0001"	&	"1110"	&	"0000"	&	"0111"	&	"0000",
	"0001"	&	"1110"	&	"0000"	&	"1110"	&	"0000",
	"0001"	&	"1110"	&	"0000"	&	"1111"	&	"0000",
	"0001"	&	"1110"	&	"0001"	&	"0000"	&	"0000",
	"0001"	&	"1110"	&	"0001"	&	"0001"	&	"0001",
	"0001"	&	"1110"	&	"0001"	&	"0111"	&	"0001",
	"0001"	&	"1110"	&	"0001"	&	"1110"	&	"0001",
	"0001"	&	"1110"	&	"0001"	&	"1111"	&	"0001",
	"0001"	&	"1110"	&	"0111"	&	"0000"	&	"0000",
	"0001"	&	"1110"	&	"0111"	&	"0001"	&	"0001",
	"0001"	&	"1110"	&	"0111"	&	"0111"	&	"0001",
	"0001"	&	"1110"	&	"0111"	&	"1110"	&	"0001",
	"0001"	&	"1110"	&	"0111"	&	"1111"	&	"0001",
	"0001"	&	"1110"	&	"1110"	&	"0000"	&	"0000",
	"0001"	&	"1110"	&	"1110"	&	"0001"	&	"0001",
	"0001"	&	"1110"	&	"1110"	&	"0111"	&	"0001",
	"0001"	&	"1110"	&	"1110"	&	"1110"	&	"0001",
	"0001"	&	"1110"	&	"1110"	&	"1111"	&	"0001",
	"0001"	&	"1110"	&	"1111"	&	"0000"	&	"0000",
	"0001"	&	"1110"	&	"1111"	&	"0001"	&	"0001",
	"0001"	&	"1110"	&	"1111"	&	"0111"	&	"0001",
	"0001"	&	"1110"	&	"1111"	&	"1110"	&	"0001",
	"0001"	&	"1110"	&	"1111"	&	"1111"	&	"0001",
	"0001"	&	"1111"	&	"0000"	&	"0000"	&	"0000",
	"0001"	&	"1111"	&	"0000"	&	"0001"	&	"0000",
	"0001"	&	"1111"	&	"0000"	&	"0111"	&	"0000",
	"0001"	&	"1111"	&	"0000"	&	"1110"	&	"0000",
	"0001"	&	"1111"	&	"0000"	&	"1111"	&	"0000",
	"0001"	&	"1111"	&	"0001"	&	"0000"	&	"0000",
	"0001"	&	"1111"	&	"0001"	&	"0001"	&	"0001",
	"0001"	&	"1111"	&	"0001"	&	"0111"	&	"0001",
	"0001"	&	"1111"	&	"0001"	&	"1110"	&	"0001",
	"0001"	&	"1111"	&	"0001"	&	"1111"	&	"0001",
	"0001"	&	"1111"	&	"0111"	&	"0000"	&	"0000",
	"0001"	&	"1111"	&	"0111"	&	"0001"	&	"0001",
	"0001"	&	"1111"	&	"0111"	&	"0111"	&	"0001",
	"0001"	&	"1111"	&	"0111"	&	"1110"	&	"0001",
	"0001"	&	"1111"	&	"0111"	&	"1111"	&	"0001",
	"0001"	&	"1111"	&	"1110"	&	"0000"	&	"0000",
	"0001"	&	"1111"	&	"1110"	&	"0001"	&	"0001",
	"0001"	&	"1111"	&	"1110"	&	"0111"	&	"0001",
	"0001"	&	"1111"	&	"1110"	&	"1110"	&	"0001",
	"0001"	&	"1111"	&	"1110"	&	"1111"	&	"0001",
	"0001"	&	"1111"	&	"1111"	&	"0000"	&	"0000",
	"0001"	&	"1111"	&	"1111"	&	"0001"	&	"0001",
	"0001"	&	"1111"	&	"1111"	&	"0111"	&	"0001",
	"0001"	&	"1111"	&	"1111"	&	"1110"	&	"0001",
	"0001"	&	"1111"	&	"1111"	&	"1111"	&	"0001",
	"0111"	&	"0000"	&	"0000"	&	"0000"	&	"0000",
	"0111"	&	"0000"	&	"0000"	&	"0001"	&	"0000",
	"0111"	&	"0000"	&	"0000"	&	"0111"	&	"0000",
	"0111"	&	"0000"	&	"0000"	&	"1110"	&	"0000",
	"0111"	&	"0000"	&	"0000"	&	"1111"	&	"0000",
	"0111"	&	"0000"	&	"0001"	&	"0000"	&	"0000",
	"0111"	&	"0000"	&	"0001"	&	"0001"	&	"0000",
	"0111"	&	"0000"	&	"0001"	&	"0111"	&	"0000",
	"0111"	&	"0000"	&	"0001"	&	"1110"	&	"0000",
	"0111"	&	"0000"	&	"0001"	&	"1111"	&	"0000",
	"0111"	&	"0000"	&	"0111"	&	"0000"	&	"0000",
	"0111"	&	"0000"	&	"0111"	&	"0001"	&	"0000",
	"0111"	&	"0000"	&	"0111"	&	"0111"	&	"0000",
	"0111"	&	"0000"	&	"0111"	&	"1110"	&	"0000",
	"0111"	&	"0000"	&	"0111"	&	"1111"	&	"0000",
	"0111"	&	"0000"	&	"1110"	&	"0000"	&	"0000",
	"0111"	&	"0000"	&	"1110"	&	"0001"	&	"0000",
	"0111"	&	"0000"	&	"1110"	&	"0111"	&	"0000",
	"0111"	&	"0000"	&	"1110"	&	"1110"	&	"0000",
	"0111"	&	"0000"	&	"1110"	&	"1111"	&	"0000",
	"0111"	&	"0000"	&	"1111"	&	"0000"	&	"0000",
	"0111"	&	"0000"	&	"1111"	&	"0001"	&	"0000",
	"0111"	&	"0000"	&	"1111"	&	"0111"	&	"0000",
	"0111"	&	"0000"	&	"1111"	&	"1110"	&	"0000",
	"0111"	&	"0000"	&	"1111"	&	"1111"	&	"0000",
	"0111"	&	"0001"	&	"0000"	&	"0000"	&	"0000",
	"0111"	&	"0001"	&	"0000"	&	"0001"	&	"0000",
	"0111"	&	"0001"	&	"0000"	&	"0111"	&	"0000",
	"0111"	&	"0001"	&	"0000"	&	"1110"	&	"0000",
	"0111"	&	"0001"	&	"0000"	&	"1111"	&	"0000",
	"0111"	&	"0001"	&	"0001"	&	"0000"	&	"0000",
	"0111"	&	"0001"	&	"0001"	&	"0001"	&	"0001",
	"0111"	&	"0001"	&	"0001"	&	"0111"	&	"0001",
	"0111"	&	"0001"	&	"0001"	&	"1110"	&	"0001",
	"0111"	&	"0001"	&	"0001"	&	"1111"	&	"0001",
	"0111"	&	"0001"	&	"0111"	&	"0000"	&	"0000",
	"0111"	&	"0001"	&	"0111"	&	"0001"	&	"0001",
	"0111"	&	"0001"	&	"0111"	&	"0111"	&	"0001",
	"0111"	&	"0001"	&	"0111"	&	"1110"	&	"0001",
	"0111"	&	"0001"	&	"0111"	&	"1111"	&	"0001",
	"0111"	&	"0001"	&	"1110"	&	"0000"	&	"0000",
	"0111"	&	"0001"	&	"1110"	&	"0001"	&	"0001",
	"0111"	&	"0001"	&	"1110"	&	"0111"	&	"0001",
	"0111"	&	"0001"	&	"1110"	&	"1110"	&	"0001",
	"0111"	&	"0001"	&	"1110"	&	"1111"	&	"0001",
	"0111"	&	"0001"	&	"1111"	&	"0000"	&	"0000",
	"0111"	&	"0001"	&	"1111"	&	"0001"	&	"0001",
	"0111"	&	"0001"	&	"1111"	&	"0111"	&	"0001",
	"0111"	&	"0001"	&	"1111"	&	"1110"	&	"0001",
	"0111"	&	"0001"	&	"1111"	&	"1111"	&	"0001",
	"0111"	&	"0111"	&	"0000"	&	"0000"	&	"0000",
	"0111"	&	"0111"	&	"0000"	&	"0001"	&	"0000",
	"0111"	&	"0111"	&	"0000"	&	"0111"	&	"0000",
	"0111"	&	"0111"	&	"0000"	&	"1110"	&	"0000",
	"0111"	&	"0111"	&	"0000"	&	"1111"	&	"0000",
	"0111"	&	"0111"	&	"0001"	&	"0000"	&	"0000",
	"0111"	&	"0111"	&	"0001"	&	"0001"	&	"0001",
	"0111"	&	"0111"	&	"0001"	&	"0111"	&	"0001",
	"0111"	&	"0111"	&	"0001"	&	"1110"	&	"0001",
	"0111"	&	"0111"	&	"0001"	&	"1111"	&	"0001",
	"0111"	&	"0111"	&	"0111"	&	"0000"	&	"0000",
	"0111"	&	"0111"	&	"0111"	&	"0001"	&	"0001",
	"0111"	&	"0111"	&	"0111"	&	"0111"	&	"0111",
	"0111"	&	"0111"	&	"0111"	&	"1110"	&	"0111",
	"0111"	&	"0111"	&	"0111"	&	"1111"	&	"0111",
	"0111"	&	"0111"	&	"1110"	&	"0000"	&	"0000",
	"0111"	&	"0111"	&	"1110"	&	"0001"	&	"0001",
	"0111"	&	"0111"	&	"1110"	&	"0111"	&	"0111",
	"0111"	&	"0111"	&	"1110"	&	"1110"	&	"0111",
	"0111"	&	"0111"	&	"1110"	&	"1111"	&	"0111",
	"0111"	&	"0111"	&	"1111"	&	"0000"	&	"0000",
	"0111"	&	"0111"	&	"1111"	&	"0001"	&	"0001",
	"0111"	&	"0111"	&	"1111"	&	"0111"	&	"0111",
	"0111"	&	"0111"	&	"1111"	&	"1110"	&	"0111",
	"0111"	&	"0111"	&	"1111"	&	"1111"	&	"0111",
	"0111"	&	"1110"	&	"0000"	&	"0000"	&	"0000",
	"0111"	&	"1110"	&	"0000"	&	"0001"	&	"0000",
	"0111"	&	"1110"	&	"0000"	&	"0111"	&	"0000",
	"0111"	&	"1110"	&	"0000"	&	"1110"	&	"0000",
	"0111"	&	"1110"	&	"0000"	&	"1111"	&	"0000",
	"0111"	&	"1110"	&	"0001"	&	"0000"	&	"0000",
	"0111"	&	"1110"	&	"0001"	&	"0001"	&	"0001",
	"0111"	&	"1110"	&	"0001"	&	"0111"	&	"0001",
	"0111"	&	"1110"	&	"0001"	&	"1110"	&	"0001",
	"0111"	&	"1110"	&	"0001"	&	"1111"	&	"0001",
	"0111"	&	"1110"	&	"0111"	&	"0000"	&	"0000",
	"0111"	&	"1110"	&	"0111"	&	"0001"	&	"0001",
	"0111"	&	"1110"	&	"0111"	&	"0111"	&	"0111",
	"0111"	&	"1110"	&	"0111"	&	"1110"	&	"0111",
	"0111"	&	"1110"	&	"0111"	&	"1111"	&	"0111",
	"0111"	&	"1110"	&	"1110"	&	"0000"	&	"0000",
	"0111"	&	"1110"	&	"1110"	&	"0001"	&	"0001",
	"0111"	&	"1110"	&	"1110"	&	"0111"	&	"0111",
	"0111"	&	"1110"	&	"1110"	&	"1110"	&	"0111",
	"0111"	&	"1110"	&	"1110"	&	"1111"	&	"0111",
	"0111"	&	"1110"	&	"1111"	&	"0000"	&	"0000",
	"0111"	&	"1110"	&	"1111"	&	"0001"	&	"0001",
	"0111"	&	"1110"	&	"1111"	&	"0111"	&	"0111",
	"0111"	&	"1110"	&	"1111"	&	"1110"	&	"0111",
	"0111"	&	"1110"	&	"1111"	&	"1111"	&	"0111",
	"0111"	&	"1111"	&	"0000"	&	"0000"	&	"0000",
	"0111"	&	"1111"	&	"0000"	&	"0001"	&	"0000",
	"0111"	&	"1111"	&	"0000"	&	"0111"	&	"0000",
	"0111"	&	"1111"	&	"0000"	&	"1110"	&	"0000",
	"0111"	&	"1111"	&	"0000"	&	"1111"	&	"0000",
	"0111"	&	"1111"	&	"0001"	&	"0000"	&	"0000",
	"0111"	&	"1111"	&	"0001"	&	"0001"	&	"0001",
	"0111"	&	"1111"	&	"0001"	&	"0111"	&	"0001",
	"0111"	&	"1111"	&	"0001"	&	"1110"	&	"0001",
	"0111"	&	"1111"	&	"0001"	&	"1111"	&	"0001",
	"0111"	&	"1111"	&	"0111"	&	"0000"	&	"0000",
	"0111"	&	"1111"	&	"0111"	&	"0001"	&	"0001",
	"0111"	&	"1111"	&	"0111"	&	"0111"	&	"0111",
	"0111"	&	"1111"	&	"0111"	&	"1110"	&	"0111",
	"0111"	&	"1111"	&	"0111"	&	"1111"	&	"0111",
	"0111"	&	"1111"	&	"1110"	&	"0000"	&	"0000",
	"0111"	&	"1111"	&	"1110"	&	"0001"	&	"0001",
	"0111"	&	"1111"	&	"1110"	&	"0111"	&	"0111",
	"0111"	&	"1111"	&	"1110"	&	"1110"	&	"0111",
	"0111"	&	"1111"	&	"1110"	&	"1111"	&	"0111",
	"0111"	&	"1111"	&	"1111"	&	"0000"	&	"0000",
	"0111"	&	"1111"	&	"1111"	&	"0001"	&	"0001",
	"0111"	&	"1111"	&	"1111"	&	"0111"	&	"0111",
	"0111"	&	"1111"	&	"1111"	&	"1110"	&	"0111",
	"0111"	&	"1111"	&	"1111"	&	"1111"	&	"0111",
	"1110"	&	"0000"	&	"0000"	&	"0000"	&	"0000",
	"1110"	&	"0000"	&	"0000"	&	"0001"	&	"0000",
	"1110"	&	"0000"	&	"0000"	&	"0111"	&	"0000",
	"1110"	&	"0000"	&	"0000"	&	"1110"	&	"0000",
	"1110"	&	"0000"	&	"0000"	&	"1111"	&	"0000",
	"1110"	&	"0000"	&	"0001"	&	"0000"	&	"0000",
	"1110"	&	"0000"	&	"0001"	&	"0001"	&	"0000",
	"1110"	&	"0000"	&	"0001"	&	"0111"	&	"0000",
	"1110"	&	"0000"	&	"0001"	&	"1110"	&	"0000",
	"1110"	&	"0000"	&	"0001"	&	"1111"	&	"0000",
	"1110"	&	"0000"	&	"0111"	&	"0000"	&	"0000",
	"1110"	&	"0000"	&	"0111"	&	"0001"	&	"0000",
	"1110"	&	"0000"	&	"0111"	&	"0111"	&	"0000",
	"1110"	&	"0000"	&	"0111"	&	"1110"	&	"0000",
	"1110"	&	"0000"	&	"0111"	&	"1111"	&	"0000",
	"1110"	&	"0000"	&	"1110"	&	"0000"	&	"0000",
	"1110"	&	"0000"	&	"1110"	&	"0001"	&	"0000",
	"1110"	&	"0000"	&	"1110"	&	"0111"	&	"0000",
	"1110"	&	"0000"	&	"1110"	&	"1110"	&	"0000",
	"1110"	&	"0000"	&	"1110"	&	"1111"	&	"0000",
	"1110"	&	"0000"	&	"1111"	&	"0000"	&	"0000",
	"1110"	&	"0000"	&	"1111"	&	"0001"	&	"0000",
	"1110"	&	"0000"	&	"1111"	&	"0111"	&	"0000",
	"1110"	&	"0000"	&	"1111"	&	"1110"	&	"0000",
	"1110"	&	"0000"	&	"1111"	&	"1111"	&	"0000",
	"1110"	&	"0001"	&	"0000"	&	"0000"	&	"0000",
	"1110"	&	"0001"	&	"0000"	&	"0001"	&	"0000",
	"1110"	&	"0001"	&	"0000"	&	"0111"	&	"0000",
	"1110"	&	"0001"	&	"0000"	&	"1110"	&	"0000",
	"1110"	&	"0001"	&	"0000"	&	"1111"	&	"0000",
	"1110"	&	"0001"	&	"0001"	&	"0000"	&	"0000",
	"1110"	&	"0001"	&	"0001"	&	"0001"	&	"0001",
	"1110"	&	"0001"	&	"0001"	&	"0111"	&	"0001",
	"1110"	&	"0001"	&	"0001"	&	"1110"	&	"0001",
	"1110"	&	"0001"	&	"0001"	&	"1111"	&	"0001",
	"1110"	&	"0001"	&	"0111"	&	"0000"	&	"0000",
	"1110"	&	"0001"	&	"0111"	&	"0001"	&	"0001",
	"1110"	&	"0001"	&	"0111"	&	"0111"	&	"0001",
	"1110"	&	"0001"	&	"0111"	&	"1110"	&	"0001",
	"1110"	&	"0001"	&	"0111"	&	"1111"	&	"0001",
	"1110"	&	"0001"	&	"1110"	&	"0000"	&	"0000",
	"1110"	&	"0001"	&	"1110"	&	"0001"	&	"0001",
	"1110"	&	"0001"	&	"1110"	&	"0111"	&	"0001",
	"1110"	&	"0001"	&	"1110"	&	"1110"	&	"0001",
	"1110"	&	"0001"	&	"1110"	&	"1111"	&	"0001",
	"1110"	&	"0001"	&	"1111"	&	"0000"	&	"0000",
	"1110"	&	"0001"	&	"1111"	&	"0001"	&	"0001",
	"1110"	&	"0001"	&	"1111"	&	"0111"	&	"0001",
	"1110"	&	"0001"	&	"1111"	&	"1110"	&	"0001",
	"1110"	&	"0001"	&	"1111"	&	"1111"	&	"0001",
	"1110"	&	"0111"	&	"0000"	&	"0000"	&	"0000",
	"1110"	&	"0111"	&	"0000"	&	"0001"	&	"0000",
	"1110"	&	"0111"	&	"0000"	&	"0111"	&	"0000",
	"1110"	&	"0111"	&	"0000"	&	"1110"	&	"0000",
	"1110"	&	"0111"	&	"0000"	&	"1111"	&	"0000",
	"1110"	&	"0111"	&	"0001"	&	"0000"	&	"0000",
	"1110"	&	"0111"	&	"0001"	&	"0001"	&	"0001",
	"1110"	&	"0111"	&	"0001"	&	"0111"	&	"0001",
	"1110"	&	"0111"	&	"0001"	&	"1110"	&	"0001",
	"1110"	&	"0111"	&	"0001"	&	"1111"	&	"0001",
	"1110"	&	"0111"	&	"0111"	&	"0000"	&	"0000",
	"1110"	&	"0111"	&	"0111"	&	"0001"	&	"0001",
	"1110"	&	"0111"	&	"0111"	&	"0111"	&	"0111",
	"1110"	&	"0111"	&	"0111"	&	"1110"	&	"0111",
	"1110"	&	"0111"	&	"0111"	&	"1111"	&	"0111",
	"1110"	&	"0111"	&	"1110"	&	"0000"	&	"0000",
	"1110"	&	"0111"	&	"1110"	&	"0001"	&	"0001",
	"1110"	&	"0111"	&	"1110"	&	"0111"	&	"0111",
	"1110"	&	"0111"	&	"1110"	&	"1110"	&	"0111",
	"1110"	&	"0111"	&	"1110"	&	"1111"	&	"0111",
	"1110"	&	"0111"	&	"1111"	&	"0000"	&	"0000",
	"1110"	&	"0111"	&	"1111"	&	"0001"	&	"0001",
	"1110"	&	"0111"	&	"1111"	&	"0111"	&	"0111",
	"1110"	&	"0111"	&	"1111"	&	"1110"	&	"0111",
	"1110"	&	"0111"	&	"1111"	&	"1111"	&	"0111",
	"1110"	&	"1110"	&	"0000"	&	"0000"	&	"0000",
	"1110"	&	"1110"	&	"0000"	&	"0001"	&	"0000",
	"1110"	&	"1110"	&	"0000"	&	"0111"	&	"0000",
	"1110"	&	"1110"	&	"0000"	&	"1110"	&	"0000",
	"1110"	&	"1110"	&	"0000"	&	"1111"	&	"0000",
	"1110"	&	"1110"	&	"0001"	&	"0000"	&	"0000",
	"1110"	&	"1110"	&	"0001"	&	"0001"	&	"0001",
	"1110"	&	"1110"	&	"0001"	&	"0111"	&	"0001",
	"1110"	&	"1110"	&	"0001"	&	"1110"	&	"0001",
	"1110"	&	"1110"	&	"0001"	&	"1111"	&	"0001",
	"1110"	&	"1110"	&	"0111"	&	"0000"	&	"0000",
	"1110"	&	"1110"	&	"0111"	&	"0001"	&	"0001",
	"1110"	&	"1110"	&	"0111"	&	"0111"	&	"0111",
	"1110"	&	"1110"	&	"0111"	&	"1110"	&	"0111",
	"1110"	&	"1110"	&	"0111"	&	"1111"	&	"0111",
	"1110"	&	"1110"	&	"1110"	&	"0000"	&	"0000",
	"1110"	&	"1110"	&	"1110"	&	"0001"	&	"0001",
	"1110"	&	"1110"	&	"1110"	&	"0111"	&	"0111",
	"1110"	&	"1110"	&	"1110"	&	"1110"	&	"1110",
	"1110"	&	"1110"	&	"1110"	&	"1111"	&	"1110",
	"1110"	&	"1110"	&	"1111"	&	"0000"	&	"0000",
	"1110"	&	"1110"	&	"1111"	&	"0001"	&	"0001",
	"1110"	&	"1110"	&	"1111"	&	"0111"	&	"0111",
	"1110"	&	"1110"	&	"1111"	&	"1110"	&	"1110",
	"1110"	&	"1110"	&	"1111"	&	"1111"	&	"1110",
	"1110"	&	"1111"	&	"0000"	&	"0000"	&	"0000",
	"1110"	&	"1111"	&	"0000"	&	"0001"	&	"0000",
	"1110"	&	"1111"	&	"0000"	&	"0111"	&	"0000",
	"1110"	&	"1111"	&	"0000"	&	"1110"	&	"0000",
	"1110"	&	"1111"	&	"0000"	&	"1111"	&	"0000",
	"1110"	&	"1111"	&	"0001"	&	"0000"	&	"0000",
	"1110"	&	"1111"	&	"0001"	&	"0001"	&	"0001",
	"1110"	&	"1111"	&	"0001"	&	"0111"	&	"0001",
	"1110"	&	"1111"	&	"0001"	&	"1110"	&	"0001",
	"1110"	&	"1111"	&	"0001"	&	"1111"	&	"0001",
	"1110"	&	"1111"	&	"0111"	&	"0000"	&	"0000",
	"1110"	&	"1111"	&	"0111"	&	"0001"	&	"0001",
	"1110"	&	"1111"	&	"0111"	&	"0111"	&	"0111",
	"1110"	&	"1111"	&	"0111"	&	"1110"	&	"0111",
	"1110"	&	"1111"	&	"0111"	&	"1111"	&	"0111",
	"1110"	&	"1111"	&	"1110"	&	"0000"	&	"0000",
	"1110"	&	"1111"	&	"1110"	&	"0001"	&	"0001",
	"1110"	&	"1111"	&	"1110"	&	"0111"	&	"0111",
	"1110"	&	"1111"	&	"1110"	&	"1110"	&	"1110",
	"1110"	&	"1111"	&	"1110"	&	"1111"	&	"1110",
	"1110"	&	"1111"	&	"1111"	&	"0000"	&	"0000",
	"1110"	&	"1111"	&	"1111"	&	"0001"	&	"0001",
	"1110"	&	"1111"	&	"1111"	&	"0111"	&	"0111",
	"1110"	&	"1111"	&	"1111"	&	"1110"	&	"1110",
	"1110"	&	"1111"	&	"1111"	&	"1111"	&	"1110",
	"1111"	&	"0000"	&	"0000"	&	"0000"	&	"0000",
	"1111"	&	"0000"	&	"0000"	&	"0001"	&	"0000",
	"1111"	&	"0000"	&	"0000"	&	"0111"	&	"0000",
	"1111"	&	"0000"	&	"0000"	&	"1110"	&	"0000",
	"1111"	&	"0000"	&	"0000"	&	"1111"	&	"0000",
	"1111"	&	"0000"	&	"0001"	&	"0000"	&	"0000",
	"1111"	&	"0000"	&	"0001"	&	"0001"	&	"0000",
	"1111"	&	"0000"	&	"0001"	&	"0111"	&	"0000",
	"1111"	&	"0000"	&	"0001"	&	"1110"	&	"0000",
	"1111"	&	"0000"	&	"0001"	&	"1111"	&	"0000",
	"1111"	&	"0000"	&	"0111"	&	"0000"	&	"0000",
	"1111"	&	"0000"	&	"0111"	&	"0001"	&	"0000",
	"1111"	&	"0000"	&	"0111"	&	"0111"	&	"0000",
	"1111"	&	"0000"	&	"0111"	&	"1110"	&	"0000",
	"1111"	&	"0000"	&	"0111"	&	"1111"	&	"0000",
	"1111"	&	"0000"	&	"1110"	&	"0000"	&	"0000",
	"1111"	&	"0000"	&	"1110"	&	"0001"	&	"0000",
	"1111"	&	"0000"	&	"1110"	&	"0111"	&	"0000",
	"1111"	&	"0000"	&	"1110"	&	"1110"	&	"0000",
	"1111"	&	"0000"	&	"1110"	&	"1111"	&	"0000",
	"1111"	&	"0000"	&	"1111"	&	"0000"	&	"0000",
	"1111"	&	"0000"	&	"1111"	&	"0001"	&	"0000",
	"1111"	&	"0000"	&	"1111"	&	"0111"	&	"0000",
	"1111"	&	"0000"	&	"1111"	&	"1110"	&	"0000",
	"1111"	&	"0000"	&	"1111"	&	"1111"	&	"0000",
	"1111"	&	"0001"	&	"0000"	&	"0000"	&	"0000",
	"1111"	&	"0001"	&	"0000"	&	"0001"	&	"0000",
	"1111"	&	"0001"	&	"0000"	&	"0111"	&	"0000",
	"1111"	&	"0001"	&	"0000"	&	"1110"	&	"0000",
	"1111"	&	"0001"	&	"0000"	&	"1111"	&	"0000",
	"1111"	&	"0001"	&	"0001"	&	"0000"	&	"0000",
	"1111"	&	"0001"	&	"0001"	&	"0001"	&	"0001",
	"1111"	&	"0001"	&	"0001"	&	"0111"	&	"0001",
	"1111"	&	"0001"	&	"0001"	&	"1110"	&	"0001",
	"1111"	&	"0001"	&	"0001"	&	"1111"	&	"0001",
	"1111"	&	"0001"	&	"0111"	&	"0000"	&	"0000",
	"1111"	&	"0001"	&	"0111"	&	"0001"	&	"0001",
	"1111"	&	"0001"	&	"0111"	&	"0111"	&	"0001",
	"1111"	&	"0001"	&	"0111"	&	"1110"	&	"0001",
	"1111"	&	"0001"	&	"0111"	&	"1111"	&	"0001",
	"1111"	&	"0001"	&	"1110"	&	"0000"	&	"0000",
	"1111"	&	"0001"	&	"1110"	&	"0001"	&	"0001",
	"1111"	&	"0001"	&	"1110"	&	"0111"	&	"0001",
	"1111"	&	"0001"	&	"1110"	&	"1110"	&	"0001",
	"1111"	&	"0001"	&	"1110"	&	"1111"	&	"0001",
	"1111"	&	"0001"	&	"1111"	&	"0000"	&	"0000",
	"1111"	&	"0001"	&	"1111"	&	"0001"	&	"0001",
	"1111"	&	"0001"	&	"1111"	&	"0111"	&	"0001",
	"1111"	&	"0001"	&	"1111"	&	"1110"	&	"0001",
	"1111"	&	"0001"	&	"1111"	&	"1111"	&	"0001",
	"1111"	&	"0111"	&	"0000"	&	"0000"	&	"0000",
	"1111"	&	"0111"	&	"0000"	&	"0001"	&	"0000",
	"1111"	&	"0111"	&	"0000"	&	"0111"	&	"0000",
	"1111"	&	"0111"	&	"0000"	&	"1110"	&	"0000",
	"1111"	&	"0111"	&	"0000"	&	"1111"	&	"0000",
	"1111"	&	"0111"	&	"0001"	&	"0000"	&	"0000",
	"1111"	&	"0111"	&	"0001"	&	"0001"	&	"0001",
	"1111"	&	"0111"	&	"0001"	&	"0111"	&	"0001",
	"1111"	&	"0111"	&	"0001"	&	"1110"	&	"0001",
	"1111"	&	"0111"	&	"0001"	&	"1111"	&	"0001",
	"1111"	&	"0111"	&	"0111"	&	"0000"	&	"0000",
	"1111"	&	"0111"	&	"0111"	&	"0001"	&	"0001",
	"1111"	&	"0111"	&	"0111"	&	"0111"	&	"0111",
	"1111"	&	"0111"	&	"0111"	&	"1110"	&	"0111",
	"1111"	&	"0111"	&	"0111"	&	"1111"	&	"0111",
	"1111"	&	"0111"	&	"1110"	&	"0000"	&	"0000",
	"1111"	&	"0111"	&	"1110"	&	"0001"	&	"0001",
	"1111"	&	"0111"	&	"1110"	&	"0111"	&	"0111",
	"1111"	&	"0111"	&	"1110"	&	"1110"	&	"0111",
	"1111"	&	"0111"	&	"1110"	&	"1111"	&	"0111",
	"1111"	&	"0111"	&	"1111"	&	"0000"	&	"0000",
	"1111"	&	"0111"	&	"1111"	&	"0001"	&	"0001",
	"1111"	&	"0111"	&	"1111"	&	"0111"	&	"0111",
	"1111"	&	"0111"	&	"1111"	&	"1110"	&	"0111",
	"1111"	&	"0111"	&	"1111"	&	"1111"	&	"0111",
	"1111"	&	"1110"	&	"0000"	&	"0000"	&	"0000",
	"1111"	&	"1110"	&	"0000"	&	"0001"	&	"0000",
	"1111"	&	"1110"	&	"0000"	&	"0111"	&	"0000",
	"1111"	&	"1110"	&	"0000"	&	"1110"	&	"0000",
	"1111"	&	"1110"	&	"0000"	&	"1111"	&	"0000",
	"1111"	&	"1110"	&	"0001"	&	"0000"	&	"0000",
	"1111"	&	"1110"	&	"0001"	&	"0001"	&	"0001",
	"1111"	&	"1110"	&	"0001"	&	"0111"	&	"0001",
	"1111"	&	"1110"	&	"0001"	&	"1110"	&	"0001",
	"1111"	&	"1110"	&	"0001"	&	"1111"	&	"0001",
	"1111"	&	"1110"	&	"0111"	&	"0000"	&	"0000",
	"1111"	&	"1110"	&	"0111"	&	"0001"	&	"0001",
	"1111"	&	"1110"	&	"0111"	&	"0111"	&	"0111",
	"1111"	&	"1110"	&	"0111"	&	"1110"	&	"0111",
	"1111"	&	"1110"	&	"0111"	&	"1111"	&	"0111",
	"1111"	&	"1110"	&	"1110"	&	"0000"	&	"0000",
	"1111"	&	"1110"	&	"1110"	&	"0001"	&	"0001",
	"1111"	&	"1110"	&	"1110"	&	"0111"	&	"0111",
	"1111"	&	"1110"	&	"1110"	&	"1110"	&	"1110",
	"1111"	&	"1110"	&	"1110"	&	"1111"	&	"1110",
	"1111"	&	"1110"	&	"1111"	&	"0000"	&	"0000",
	"1111"	&	"1110"	&	"1111"	&	"0001"	&	"0001",
	"1111"	&	"1110"	&	"1111"	&	"0111"	&	"0111",
	"1111"	&	"1110"	&	"1111"	&	"1110"	&	"1110",
	"1111"	&	"1110"	&	"1111"	&	"1111"	&	"1110",
	"1111"	&	"1111"	&	"0000"	&	"0000"	&	"0000",
	"1111"	&	"1111"	&	"0000"	&	"0001"	&	"0000",
	"1111"	&	"1111"	&	"0000"	&	"0111"	&	"0000",
	"1111"	&	"1111"	&	"0000"	&	"1110"	&	"0000",
	"1111"	&	"1111"	&	"0000"	&	"1111"	&	"0000",
	"1111"	&	"1111"	&	"0001"	&	"0000"	&	"0000",
	"1111"	&	"1111"	&	"0001"	&	"0001"	&	"0001",
	"1111"	&	"1111"	&	"0001"	&	"0111"	&	"0001",
	"1111"	&	"1111"	&	"0001"	&	"1110"	&	"0001",
	"1111"	&	"1111"	&	"0001"	&	"1111"	&	"0001",
	"1111"	&	"1111"	&	"0111"	&	"0000"	&	"0000",
	"1111"	&	"1111"	&	"0111"	&	"0001"	&	"0001",
	"1111"	&	"1111"	&	"0111"	&	"0111"	&	"0111",
	"1111"	&	"1111"	&	"0111"	&	"1110"	&	"0111",
	"1111"	&	"1111"	&	"0111"	&	"1111"	&	"0111",
	"1111"	&	"1111"	&	"1110"	&	"0000"	&	"0000",
	"1111"	&	"1111"	&	"1110"	&	"0001"	&	"0001",
	"1111"	&	"1111"	&	"1110"	&	"0111"	&	"0111",
	"1111"	&	"1111"	&	"1110"	&	"1110"	&	"1110",
	"1111"	&	"1111"	&	"1110"	&	"1111"	&	"1110",
	"1111"	&	"1111"	&	"1111"	&	"0000"	&	"0000",
	"1111"	&	"1111"	&	"1111"	&	"0001"	&	"0001",
	"1111"	&	"1111"	&	"1111"	&	"0111"	&	"0111",
	"1111"	&	"1111"	&	"1111"	&	"1110"	&	"1110",
	"1111"	&	"1111"	&	"1111"	&	"1111"	&	"1111"
	);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FindMin_4bit PORT MAP (
          A => A,
          B => B,
          C => C,
          D => D,
          MIN => MIN
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      for i in test_vector'Range loop
			
			--assign test input
			A <= test_vector(i)(19 downto 16);
			B <= test_vector(i)(15 downto 12);
			C <= test_vector(i)(11 downto 8);
			D <= test_vector(i)(7 downto 4);
			
			wait for 2ns;
			--assertions
			assert(MIN = test_vector(i)(3 downto 0))
				report "***** Test failed. *****"
            severity Failure;
		end loop;
		
		 -- All tests are successful if we get this far
      report "***** All tests completed successfully. *****";
      wait;
   end process;

END;
