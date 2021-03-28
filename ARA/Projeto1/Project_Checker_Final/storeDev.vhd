LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY flipFlopDPET IS
  PORT (clk, D: IN STD_LOGIC;
        nSet, nRst: IN STD_LOGIC;
        Q, nQ: OUT STD_LOGIC);
END flipFlopDPET;

ARCHITECTURE behavior OF flipFlopDPET IS
BEGIN
  PROCESS (clk, nSet, nRst)
  BEGIN
    IF (nRst = '0')
	    THEN Q <= '0';
		      nQ <= '1';
		 ELSIF (nSet = '0')
		       THEN Q <= '1';
		            nQ <= '0';
	          ELSIF (clk = '1') AND (clk'EVENT)
	                THEN Q <= D;
		                  nQ <= NOT D;

	 END IF;
  END PROCESS;
END behavior;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY CRC_ShiftReg IS
  PORT (nRst: IN STD_LOGIC;
		  nSet: IN STD_LOGIC;	
        clk: IN STD_LOGIC;
        D: IN STD_LOGIC;
        Q: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END CRC_ShiftReg;

ARCHITECTURE structure OF CRC_ShiftReg IS
	SIGNAL dataOut: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL xor1,xor2,xor3,xor4,xor5: STD_LOGIC;
	COMPONENT flipFlopDPET
		PORT (
				clk, D: IN STD_LOGIC;
				nSet, nRst: IN STD_LOGIC;
				Q, nQ: OUT STD_LOGIC);
	END COMPONENT;
	COMPONENT gateXor2
    PORT (x1, x2: IN STD_LOGIC;
          y:      OUT STD_LOGIC);
	END COMPONENT;
BEGIN
  xor_1: gateXor2 PORT MAP (D, dataOut(7), xor1);
  ff0: flipFlopDPET PORT MAP (clk, xor1, nSet, nRst, dataOut(0));
  xor_2: gateXor2 PORT MAP (dataOut(0), dataOut(7), xor2);
  ff1: flipFlopDPET PORT MAP (clk, xor2, nSet, nRst, dataOut(1));
  xor_3: gateXor2 PORT MAP (dataOut(1), dataOut(7), xor3);
  ff2: flipFlopDPET PORT MAP (clk, xor3, nSet, nRst, dataOut(2));
  xor_4: gateXor2 PORT MAP (dataOut(2), dataOut(7), xor4);
  ff3: flipFlopDPET PORT MAP (clk, xor4, nSet, nRst, dataOut(3));
  ff4: flipFlopDPET PORT MAP (clk, dataOut(3), nSet, nRst, dataOut(4));
  xor_5: gateXor2 PORT MAP (dataOut(4), dataOut(7), xor5);
  ff5: flipFlopDPET PORT MAP (clk, xor5, nSet, nRst, dataOut(5));
  ff6: flipFlopDPET PORT MAP (clk, dataOut(5), nSet, nRst, dataOut(6));
  ff7: flipFlopDPET PORT MAP (clk, dataOut(6), nSet, nRst, dataOut(7));
  Q <= dataOut;
END structure;

LIBRARY simpleLogic;
USE simpleLogic.all;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY simpleLogic;
USE simpleLogic.all;

ENTITY binCounter_5bit IS
  PORT (nRst: IN STD_LOGIC;
		  nSet: IN STD_LOGIC;
        clk:  IN STD_LOGIC;
        c:    OUT STD_LOGIC_VECTOR (4 DOWNTO 0));
END binCounter_5bit;

ARCHITECTURE structure OF binCounter_5bit IS
  SIGNAL pD1, pD2, pD3: STD_LOGIC;
  SIGNAL iD1, iD2, iD3, iD4: STD_LOGIC;
  SIGNAL iQ0, iQ1, iQ2, iQ3, iQ4: STD_LOGIC;
  SIGNAL inQ0: STD_LOGIC;
  COMPONENT gateAnd2
    PORT (x1, x2: IN STD_LOGIC;
          y:      OUT STD_LOGIC);
  END COMPONENT;
  COMPONENT gateXor2
    PORT (x1, x2: IN STD_LOGIC;
          y:      OUT STD_LOGIC);
  END COMPONENT;
  COMPONENT flipFlopDPET
    PORT (clk, D:     IN STD_LOGIC;
          nSet, nRst: IN STD_LOGIC;
          Q, nQ:      OUT STD_LOGIC);
  END COMPONENT;
BEGIN
  ad1: gateAnd2 PORT MAP (iQ0, iQ1, pD1);
  ad2: gateAnd2 PORT MAP (pD1, iQ2, pD2);
  ad3: gateAnd2 PORT MAP (pD2, iQ3, pD3);
  xr1: gateXor2 PORT MAP (iQ0, iQ1, iD1);
  xr2: gateXor2 PORT MAP (pD1, iQ2, iD2);
  xr3: gateXor2 PORT MAP (pD2, iQ3, iD3);
  xr4: gateXor2 PORT MAP (pD3, iQ4, iD4);
  ff0: flipFlopDPET PORT MAP (clk, inQ0, nSet, nRst, iQ0, inQ0);
  ff1: flipFlopDPET PORT MAP (clk, iD1,  nSet, nRst, iQ1);
  ff2: flipFlopDPET PORT MAP (clk, iD2,  nSet, nRst, iQ2);
  ff3: flipFlopDPET PORT MAP (clk, iD3,  nSet, nRst, iQ3);
  ff4: flipFlopDPET PORT MAP (clk, iD4,  nSet, nRst, iQ4);
  c(0) <= iQ0;
  c(1) <= iQ1;
  c(2) <= iQ2;
  c(3) <= iQ3;
  c(4) <= iQ4;
END structure;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY simpleLogic;
USE simpleLogic.all;

ENTITY comparator_5bit IS
  PORT (
			dataIn1: IN STD_LOGIC_VECTOR(4 downto 0);
			dataIn2: IN STD_LOGIC_VECTOR(4 downto 0);
			equal: OUT STD_LOGIC
		);
END comparator_5bit;

ARCHITECTURE behavioral OF comparator_5bit IS
	SIGNAL bit0,bit1,bit2,bit3,bit4: STD_LOGIC;
	SIGNAL and0,and1,and2: STD_LOGIC;
	SIGNAL eq: STD_LOGIC; 
	
	COMPONENT gateOr2
    PORT (x1, x2: IN STD_LOGIC;
          y:      OUT STD_LOGIC);
	END COMPONENT;
	COMPONENT gateXor2
    PORT (x1, x2: IN STD_LOGIC;
          y:      OUT STD_LOGIC);
	END COMPONENT;
BEGIN
	bit_0: gateXor2 PORT MAP(dataIn1(0),dataIn2(0),bit0);
	bit_1: gateXor2 PORT MAP(dataIn1(1),dataIn2(1),bit1);
	bit_2: gateXor2 PORT MAP(dataIn1(2),dataIn2(2),bit2);
	bit_3: gateXor2 PORT MAP(dataIn1(3),dataIn2(3),bit3);
	bit_4: gateXor2 PORT MAP(dataIn1(4),dataIn2(4),bit4);
	and_0: gateOr2 PORT MAP(bit0,bit1,and0);
	and_1: gateOr2 PORT MAP(bit2,bit3,and1);
	and_2: gateOr2 PORT MAP(and0,and1,and2);
	and_3: gateOr2 PORT MAP(bit4,and2,eq);
	
	equal <= NOT eq;
END behavioral;