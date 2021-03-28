library IEEE;
use IEEE.STD_LOGIC_1164.all;

LIBRARY simpleLogic;
USE simpleLogic.all;

entity Encoder_CRC_8 is
	port(
		dataIn:	in STD_LOGIC_VECTOR(15 downto 0);
		dataOut:	out STD_LOGIC_VECTOR(23 downto 0)
	);
end Encoder_CRC_8;


architecture Structural of Encoder_CRC_8 is
	signal level0	:	STD_LOGIC_VECTOR(11 downto 0);
	signal level1	:	STD_LOGIC_VECTOR(11 downto 0);
	signal level2	:	STD_LOGIC_VECTOR(5 downto 0);
	signal temp 	: 	STD_LOGIC_VECTOR(15 downto 0);

	COMPONENT gateXor2
	PORT (x1, x2: IN STD_LOGIC;
        y:      OUT STD_LOGIC);
	END COMPONENT;
	
begin
	
	level_0_0: gateXor2 PORT MAP(dataIn(15), dataIn(0), level0(0)); --(15,0)  bits: 2,1,0
	level_0_1: gateXor2 PORT MAP(dataIn(14), dataIn(2), level0(1)); --(14,2)  bits: 7,2
	level_0_2: gateXor2 PORT MAP(dataIn(13), dataIn(1), level0(2)); --(13,1)  bits: 6,1 
	level_0_3: gateXor2 PORT MAP(dataIn(12), dataIn(11), level0(3)); --(12,11) bits: 2,0
	level_0_4: gateXor2 PORT MAP(dataIn(10), dataIn(9), level0(4)); --(10,9)  bits: 7,6,4,2,0
	level_0_5: gateXor2 PORT MAP(dataIn(8), dataIn(7), level0(5)); --(8,7)   bits: 7,6,5,0
	level_0_6: gateXor2 PORT MAP(dataIn(6), dataIn(4), level0(6)); --(6,4)   bits: 7,5,2,1
	level_0_7: gateXor2 PORT MAP(dataIn(5), dataIn(3), level0(7)); --(5,3)   bits: 6,4,1,0
	level_0_8: gateXor2 PORT MAP(dataIn(3), dataIn(1), level0(8)); --(3,1)    bits: 2
	level_0_9: gateXor2 PORT MAP(dataIn(2), dataIn(0), level0(9)); --(2,0)    bits: 5,3
	level_0_10: gateXor2 PORT MAP(dataIn(8), dataIn(4), level0(10)); --(8,4)    bits: 3
	level_0_11: gateXor2 PORT MAP(dataIn(12), dataIn(5), level0(11)); --(12,5)   bits: 5   
	
	level_1_0: gateXor2 PORT MAP(level0(4), level0(5), level1(0)); -- (10,9) (8,7)  bits: 7,6,0
	level_1_1: gateXor2 PORT MAP(level0(0), level0(7), level1(1)); -- (15,0) (5,3)  bits: 1,0
	level_1_2: gateXor2 PORT MAP(level0(1), level0(6), level1(2)); -- (14,2) (6,4)  bits: 7,2
	level_1_3: gateXor2 PORT MAP(level0(2), level0(7), level1(3)); -- (13,1) (5,3)  bits: 6,1
	level_1_4: gateXor2 PORT MAP(level0(2), level0(6), level1(4)); -- (13,1) (6,4)  bits: 1	
	level_1_5: gateXor2 PORT MAP(level0(4), level0(0), level1(5)); -- (10,9) (15,0) bits: 2
	level_1_6: gateXor2 PORT MAP(level0(3), level0(8), level1(6)); -- (12,11) (3,1) bits: 2
	level_1_7: gateXor2 PORT MAP(level0(9), dataIn(9), level1(7)); -- (2,0) (9)	 bits: 5,3
	level_1_8: gateXor2 PORT MAP(level0(2), level0(10), level1(8)); -- (13,1) (8,4)  bits: 3
	level_1_9: gateXor2 PORT MAP(level0(4), level0(7), level1(9)); -- (10,9) (5,3)  bits: 4
	level_1_10: gateXor2 PORT MAP(level0(5), level0(6), level1(10)); -- (8,7) (6,4)   bits: 5
	level_1_11: gateXor2 PORT MAP(level0(1), dataIn(1), level1(11)); -- (14,2) (1)    bits: 4
	
	level_2_0: gateXor2 PORT MAP(level1(0), level1(1), level2(0)); --(10,9) (8,7) (15,0) (5,3)  bits: 0
	level_2_1: gateXor2 PORT MAP(level1(6), level1(5), level2(1)); --(12,11)(3,1) (10,9) (15,0) bits: 2
	level_2_2: gateXor2 PORT MAP(level1(7), level0(11), level2(2)); --(2,0) (9) (12,5) 			 bits: 5
	level_2_3: gateXor2 PORT MAP(level1(0), level1(3), level2(3));	--(10,9) (8,7) (13,1) (5,3)  bits: 6
	level_2_4: gateXor2 PORT MAP(level1(0), level1(2), level2(4)); --(10,9) (8,7) (14,2) (6,4)  bits: 7
	level_2_5: gateXor2 PORT MAP(level1(1), level1(4), level2(5)); --(15,0) (5,3) (13,1) (6,4)  bits: 1
	
	dataOut_0: gateXor2 PORT MAP(level2(0), level0(3), dataOut(0)); --(10,9) (8,7) (15,0) (5,3) (12,11) 		bits: 0
	dataOut_1: gateXor2 PORT MAP(level2(5), dataIn(7), dataOut(1)); --(15,0) (5,3) (13,1) (6,4) (7)  			bits: 1
	dataOut_2: gateXor2 PORT MAP(level2(1), level1(2), dataOut(2)); --(12,11)(3,1) (10,9) (15,0) (14,2) (6,4) bits: 2
	dataOut_3: gateXor2 PORT MAP(level1(7), level1(8), dataOut(3)); --(2,0) (9) (13,1) (8,4)	 					bits: 3
	dataOut_4: gateXor2 PORT MAP(level1(9), level1(11), dataOut(4)); --(10,9) (5,3) (14,2) (1)  					bits: 4
	dataOut_5: gateXor2 PORT MAP(level2(2), level1(10), dataOut(5)); --(2,0) (9) (12,5) (8,7) (6,4)  			bits: 5
	dataOut_6: gateXor2 PORT MAP(level2(3), dataIn(6), dataOut(6)); --(10,9) (8,7) (13,1) (5,3) (6) 			bits: 6
	dataOut_7: gateXor2 PORT MAP(level2(4), dataIn(11), dataOut(7));  --(10,9) (8,7) (14,2) (6,4) (11) 			bits: 7
	
	temp <= dataIn;
	dataOut(23 downto 8) <= temp;

end Structural;