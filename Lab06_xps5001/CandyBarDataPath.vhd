
library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use XPS5001_Library.XPS5001_Components.ALL;


entity CandyBarDataPath is
    Port ( CLK				: in STD_LOGIC;
			  DEC_80 		: in  STD_LOGIC;
           INC_CRED 		: in  STD_LOGIC_VECTOR (1 downto 0);
           DEC_CANDY 	: in  STD_LOGIC;
           INC_SALES_80 : in  STD_LOGIC;
           CLR_CREDIT 	: in  STD_LOGIC;
           RESET 			: in  STD_LOGIC;
			  hasCandy		: out STD_LOGIC;
			  enoughCredit	: out STD_LOGIC;
           SALES 			: out  STD_LOGIC_VECTOR (11 downto 0);
           CANDY 			: out  STD_LOGIC_VECTOR (15 downto 0);
           CREDIT 		: out  STD_LOGIC_VECTOR (11 downto 0));
end CandyBarDataPath;

architecture Behavioral of CandyBarDataPath is
	
	signal credit_toload_int : STD_LOGIC_VECTOR (11 downto 0);
	signal loadcredit_int 	 : STD_LOGIC;
	signal clrcredit_int		 : STD_LOGIC;
	signal credit_reg_int	 : STD_LOGIC_VECTOR (11 downto 0);
	
	
	signal add_mux_out		 : STD_LOGIC_VECTOR (11 downto 0);
	signal sub_out				 : STD_LOGIC_VECTOR (11 downto 0);
	
	signal add_credit_int	 : STD_LOGIC_VECTOR (11 downto 0);
	signal sub_credit_int	 : STD_LOGIC_VECTOR (11 downto 0);
	
	signal candy_reg_int		 : STD_LOGIC_VECTOR (15 downto 0);
	
	signal sales_reg_int	 	 : STD_LOGIC_VECTOR (11 downto 0);
	signal loadsales_int 	 : STD_LOGIC;
	signal sales_toload_int	 : STD_LOGIC_VECTOR (11 downto 0);
		
	
begin

	
	--CREDIT
		
	clrcredit_int <= RESET or CLR_CREDIT;
	loadcredit_int <= DEC_80 or INC_CRED(0) or INC_CRED(1);
	sub_out <= x"050";
	
	with INC_CRED select
		add_mux_out <= x"000" when "00",
							x"008" when "01",
							x"010" when "10",
							x"028" when "11",
							x"000" when others;


	add: AdderSubtractor generic map ( n => 12) port map(
			  A			=> add_mux_out,
           B 			=> credit_reg_int,
			  SUBTRACT  => '0',
           SUM			=> add_credit_int,
           OVERFLOW  => open
	);
	
	sub: AdderSubtractor generic map ( n => 12) port map(
			  A			=> credit_reg_int,
           B 			=> sub_out,
			  SUBTRACT  => '1',
           SUM			=> sub_credit_int,
           OVERFLOW  => open
	);
		
	
	with DEC_80 select
		credit_toload_int <= add_credit_int when '0',
									sub_credit_int when '1',
									(others => '0') when others;

	creditR : Reg generic map ( n => 12) port map(
		D 		=> credit_toload_int,
		LOAD 	=> loadcredit_int,
		CLK 	=> CLK,
		CLR 	=> clrcredit_int,
	   Q 		=> credit_reg_int
	);
	

	
	enoughCredit <= '1' when ( to_integer(unsigned(credit_reg_int)) > 79) else
						 '0';
	
	CREDIT <= credit_reg_int;
	

	candyR : Reg_SIPO generic map ( n => 16, clrto => '1') port map(
			  D 			=> '0',
           SHIFT_EN 	=> DEC_CANDY,
           CLK 		=> CLK,
           CLR 		=> RESET,
           Q 			=> candy_reg_int
	);
	
	hasCandy <= '1' when ( candy_reg_int /= x"0000") else
					'0';
	
	CANDY <= candy_reg_int;
	--sales
	add80: AdderSubtractor generic map ( n => 12) port map(
			  A			=> x"050",
           B 			=> sales_reg_int,
			  SUBTRACT  => '0',
           SUM			=> sales_toload_int,
           OVERFLOW  => open
	);
	
	salesR : Reg generic map ( n => 12) port map(
		D 		=> sales_toload_int,
		LOAD 	=> loadsales_int,
		CLK 	=> CLK,
		CLR 	=> RESET,
	   Q 		=> sales_reg_int
	);	
	
	loadsales_int <= INC_SALES_80;
	SALES <= sales_reg_int;
	
	
end Behavioral;

