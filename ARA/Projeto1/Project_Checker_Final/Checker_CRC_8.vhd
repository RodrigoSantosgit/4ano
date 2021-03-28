library storeDev;
use storeDev.all;

LIBRARY simpleLogic;
USE simpleLogic.all;

library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity Checker_CRC_8 is
	port(
		nRst:	in STD_LOGIC;
		dataIn:	in STD_LOGIC;
		clock:	in STD_LOGIC;
		error:	out STD_LOGIC
	);
end Checker_CRC_8;


architecture Structural of Checker_CRC_8 is
	signal dataOut: STD_LOGIC_VECTOR(7 downto 0);
	signal or1,or2,or3,or4,or5,or6,or7,or8,or9,and1,ff0,ff1,and_c: STD_LOGIC;
	signal count: STD_LOGIC_VECTOR (4 DOWNTO 0);
	signal r: STD_LOGIC;
	COMPONENT CRC_ShiftReg 
		PORT(
			nRst: IN STD_LOGIC;
			nSet: IN STD_LOGIC;
			clk: IN STD_LOGIC;
			D: IN STD_LOGIC;
			Q: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT binCounter_5bit 
		PORT (
			nRst: IN STD_LOGIC;
			nSet: IN STD_LOGIC;
			clk:  IN STD_LOGIC;
			c:    OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT comparator_5bit 
		PORT (
			dataIn1: IN STD_LOGIC_VECTOR(4 downto 0);
			dataIn2: IN STD_LOGIC_VECTOR(4 downto 0);
			equal: OUT STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT gateOr2
    PORT (x1, x2: IN STD_LOGIC;
          y:      OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT gateAnd2
    PORT (x1, x2: IN STD_LOGIC;
          y:      OUT STD_LOGIC);
  END COMPONENT;
  
  COMPONENT flipFlopDPET
		PORT (
				clk, D: IN STD_LOGIC;
				nSet, nRst: IN STD_LOGIC;
				Q, nQ: OUT STD_LOGIC);
	END COMPONENT;
begin

shiftreg: CRC_ShiftReg PORT MAP(nRst, '1',clock,dataIn,dataOut);
andc: gateAnd2 PORT MAP(nRst,not ff1,and_c);
counter: binCounter_5bit PORT MAP(and_c,'1', clock, count);
comparator: comparator_5bit PORT MAP(count,"11000",r);
or_9: gateOr2 PORT MAP(r,ff1,or9);
ff_1: flipFlopDPET PORT MAP (clock, or9, '1', nRst, ff1);
or_1: gateOr2 PORT MAP(dataOut(0),dataOut(1),or1);
or_2: gateOr2 PORT MAP(dataOut(2),dataOut(3),or2);
or_3: gateOr2 PORT MAP(dataOut(4),dataOut(5),or3);
or_4: gateOr2 PORT MAP(dataOut(6),dataOut(7),or4);
or_5: gateOr2 PORT MAP(or1,or2,or5);
or_6: gateOr2 PORT MAP(or3,or4,or6);
or_7: gateOr2 PORT MAP(or5,or6,or7);
and_1: gateAnd2 PORT MAP(not or7,r,and1);
or_8: gateOr2 PORT MAP(and1,ff0,or8);


ff_0: flipFlopDPET PORT MAP (clock, or8, '1', nRst, ff0);
and_2: gateAnd2 PORT MAP(not ff0,ff1,error);

end Structural;