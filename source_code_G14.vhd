
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;




ENTITY std_1B_FA IS
PORT(	std_1B_FA_IN1: IN STD_LOGIC; 
	std_1B_FA_IN2: IN STD_LOGIC; 
	std_1B_FA_CARRYIN: IN STD_LOGIC; 
	std_1B_FA_CARRYOUT: OUT STD_LOGIC;
	std_1B_FA_OUT: OUT STD_LOGIC);
END std_1B_FA;

ARCHITECTURE std_1B_FA_dataf of std_1B_FA IS
BEGIN
std_1B_FA_CARRYOUT <= (std_1B_FA_IN1 and std_1B_FA_IN2) or (std_1B_FA_IN1 and std_1B_FA_CARRYIN) or (std_1B_FA_IN2 and std_1B_FA_CARRYIN);
std_1B_FA_OUT      <= std_1B_FA_IN1 xor std_1B_FA_IN2 xor std_1B_FA_CARRYIN;
END std_1B_FA_dataf;







LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY std_4B_FA IS
PORT(	std_4B_FA_IN1: IN STD_LOGIC_VECTOR(3 downto 0); 
	std_4B_FA_IN2: IN STD_LOGIC_VECTOR(3 downto 0); 
	std_4B_FA_CARRYIN: IN STD_LOGIC; 
	std_4B_FA_CARRYOUT: OUT STD_LOGIC;
	std_4B_FA_OUT: OUT STD_LOGIC_VECTOR(3 downto 0));
END std_4B_FA;

ARCHITECTURE std_4B_FA_dataf of std_4B_FA IS
component std_1B_FA 
PORT(	std_1B_FA_IN1: IN STD_LOGIC; 
	std_1B_FA_IN2: IN STD_LOGIC; 
	std_1B_FA_CARRYIN: IN STD_LOGIC; 
	std_1B_FA_CARRYOUT: OUT STD_LOGIC;
	std_1B_FA_OUT: OUT STD_LOGIC);
end component;

signal CARRYOUT1, CARRYOUT2, CARRYOUT3: STD_LOGIC;

BEGIN
std_1B_FA1: std_1B_FA PORT MAP (std_1B_FA_IN1 => std_4B_FA_IN1(0), std_1B_FA_IN2 => std_4B_FA_IN2(0),
				std_1B_FA_CARRYIN => std_4B_FA_CARRYIN, std_1B_FA_CARRYOUT => CARRYOUT1,
				std_1B_FA_OUT => std_4B_FA_OUT(0));

std_1B_FA2: std_1B_FA PORT MAP (std_1B_FA_IN1 => std_4B_FA_IN1(1), std_1B_FA_IN2 => std_4B_FA_IN2(1),
				std_1B_FA_CARRYIN => CARRYOUT1, std_1B_FA_CARRYOUT => CARRYOUT2,
				std_1B_FA_OUT => std_4B_FA_OUT(1));

std_1B_FA3: std_1B_FA PORT MAP (std_1B_FA_IN1 => std_4B_FA_IN1(2), std_1B_FA_IN2 => std_4B_FA_IN2(2),
				std_1B_FA_CARRYIN => CARRYOUT2, std_1B_FA_CARRYOUT => CARRYOUT3,
				std_1B_FA_OUT => std_4B_FA_OUT(2));

std_1B_FA4: std_1B_FA PORT MAP (std_1B_FA_IN1 => std_4B_FA_IN1(3), std_1B_FA_IN2 => std_4B_FA_IN2(3),
				std_1B_FA_CARRYIN => CARRYOUT3, std_1B_FA_CARRYOUT => std_4B_FA_CARRYOUT,
				std_1B_FA_OUT => std_4B_FA_OUT(3));
				


END std_4B_FA_dataf;




LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

Entity STD_4B_MULT IS
PORT (	std_4B_MULT_IN1: IN STD_LOGIC_VECTOR(3 downto 0); 
	std_4B_MULT_IN2: IN STD_LOGIC_VECTOR(3 downto 0);  
	std_4B_MULT_OUT: OUT STD_LOGIC_VECTOR(7 downto 0)
); 
END STD_4B_MULT;


ARCHITECTURE STD_4B_MULT_arch of STD_4B_MULT IS
component std_4B_FA 
PORT(	std_4B_FA_IN1: IN STD_LOGIC_VECTOR(3 downto 0); 
	std_4B_FA_IN2: IN STD_LOGIC_VECTOR(3 downto 0); 
	std_4B_FA_CARRYIN: IN STD_LOGIC; 
	std_4B_FA_CARRYOUT: OUT STD_LOGIC;
	std_4B_FA_OUT: OUT STD_LOGIC_VECTOR(3 downto 0)
);
end component;


component std_1B_FA 
PORT(	std_1B_FA_IN1: IN STD_LOGIC; 
	std_1B_FA_IN2: IN STD_LOGIC; 
	std_1B_FA_CARRYIN: IN STD_LOGIC; 
	std_1B_FA_CARRYOUT: OUT STD_LOGIC;
	std_1B_FA_OUT: OUT STD_LOGIC
);
end component;

signal c_1,c_2,c_3,c_HA,out_HA :STD_logic ;
signal b_4BA_1,a_4BA_1,s_4BA_1,b_4BA_2,a_4BA_2,s_4BA_2,b_4BA_3,a_4BA_3,s_4BA_3: STD_LOGIC_VECTOR(3 downto 0);

begin
std_4B_MULT_OUT(0) <= std_4B_MULT_IN1(0) and std_4B_MULT_IN2(0);

b_4BA_1(0)<= std_4B_MULT_IN1(1) and std_4B_MULT_IN2(0);
b_4BA_1(1)<= std_4B_MULT_IN1(2) and std_4B_MULT_IN2(0);
b_4BA_1(2)<= std_4B_MULT_IN1(3) nand std_4B_MULT_IN2(0);
b_4BA_1(3)<= '1';

a_4BA_1(0)<= std_4B_MULT_IN1(0) and std_4B_MULT_IN2(1);
a_4BA_1(1)<= std_4B_MULT_IN1(1) and std_4B_MULT_IN2(1);
a_4BA_1(2)<= std_4B_MULT_IN1(2) and std_4B_MULT_IN2(1);
a_4BA_1(3)<= std_4B_MULT_IN1(3) nand std_4B_MULT_IN2(1);

std_4B_FA1: std_4B_FA PORT MAP (std_4B_FA_IN1 => a_4BA_1, std_4B_FA_IN2 => b_4BA_1,
				std_4B_FA_CARRYIN => '0', std_4B_FA_CARRYOUT => c_1,
				std_4B_FA_OUT => s_4BA_1);

std_4B_MULT_OUT(1) <= s_4BA_1(0);

b_4BA_2(0)<= s_4BA_1(1);
b_4BA_2(1)<= s_4BA_1(2);
b_4BA_2(2)<= s_4BA_1(3);
b_4BA_2(3)<= c_1;

a_4BA_2(0)<= std_4B_MULT_IN1(0) and std_4B_MULT_IN2(2);
a_4BA_2(1)<= std_4B_MULT_IN1(1) and std_4B_MULT_IN2(2);
a_4BA_2(2)<= std_4B_MULT_IN1(2) and std_4B_MULT_IN2(2);
a_4BA_2(3)<= std_4B_MULT_IN1(3) nand std_4B_MULT_IN2(2);

std_4B_FA2: std_4B_FA PORT MAP (std_4B_FA_IN1 => a_4BA_2, std_4B_FA_IN2 => b_4BA_2,
				std_4B_FA_CARRYIN => '0', std_4B_FA_CARRYOUT => c_2,
				std_4B_FA_OUT => s_4BA_2);

std_4B_MULT_OUT(2) <= s_4BA_2(0);

b_4BA_3(0)<= s_4BA_2(1);
b_4BA_3(1)<= s_4BA_2(2);
b_4BA_3(2)<= s_4BA_2(3);
b_4BA_3(3)<= c_2;

a_4BA_3(0)<= std_4B_MULT_IN1(0) nand std_4B_MULT_IN2(3);
a_4BA_3(1)<= std_4B_MULT_IN1(1) nand std_4B_MULT_IN2(3);
a_4BA_3(2)<= std_4B_MULT_IN1(2) nand std_4B_MULT_IN2(3);
a_4BA_3(3)<= std_4B_MULT_IN1(3) and std_4B_MULT_IN2(3);

std_4B_FA3: std_4B_FA PORT MAP (std_4B_FA_IN1 => a_4BA_3, std_4B_FA_IN2 => b_4BA_3,
				std_4B_FA_CARRYIN => '0', std_4B_FA_CARRYOUT => c_3,
				std_4B_FA_OUT => s_4BA_3);

std_4B_MULT_OUT(3) <= s_4BA_3(0);
std_4B_MULT_OUT(4) <= s_4BA_3(1);
std_4B_MULT_OUT(5) <= s_4BA_3(2);
std_4B_MULT_OUT(6) <= s_4BA_3(3);

std_1B_FA1: std_1B_FA PORT MAP (std_1B_FA_IN1 => c_3, std_1B_FA_IN2 => '1',
				std_1B_FA_CARRYIN => '0', std_1B_FA_CARRYOUT => c_HA,
				std_1B_FA_OUT => out_HA);

std_4B_MULT_OUT(7) <= out_HA;

end STD_4B_MULT_arch;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY muxL is
PORT (
	input0L: IN STD_LOGIC_VECTOR  (3 downto 0);
	input1L: IN STD_LOGIC_VECTOR  (3 downto 0);
	input2L: IN STD_LOGIC_VECTOR  (3 downto 0);
	input3L: IN STD_LOGIC_VECTOR  (3 downto 0);
	input4L: IN STD_LOGIC_VECTOR  (3 downto 0);
	input5L: IN STD_LOGIC_VECTOR  (3 downto 0);
	input6L: IN STD_LOGIC_VECTOR  (3 downto 0);
	input7L: IN STD_LOGIC_VECTOR  (3 downto 0);
	selL: IN BIT_VECTOR (2 downto 0);
	out_muxL: OUT STD_LOGIC_VECTOR  (3 downto 0)
	);
END muxL;


ARCHITECTURE logical OF muxL is
BEGIN
logicalselection: process( input0L, input1L, input2L ,input3L,input4L, input5L, input6L, input7L, selL)
 
BEGIN 
case selL is 

	when "000" => out_muxL <= input0L;
	when "001" => out_muxL <= input1L;
	when "010" => out_muxL <= input2L;
	when "011" => out_muxL <= input3L;
	when "100" => out_muxL <= input4L;
	when "101" => out_muxL <= input5L;
	when "110" => out_muxL <= input6L;
	when "111" => out_muxL <= input7L;

	--default case needed to be synthesizable

 end case;
end process logicalselection;

end logical;




LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY muxalu is
PORT (
	inputArithmetic: IN STD_LOGIC_VECTOR  (7 downto 0);
	inputLogical: IN STD_LOGIC_VECTOR  (7 downto 0);

	selectionbit: IN BIT;
	out_alu: OUT STD_LOGIC_VECTOR  (7 downto 0)
	);
END muxalu;


ARCHITECTURE alu OF muxalu is
BEGIN
aluselection: process( inputArithmetic, inputLogical, selectionbit)
 
BEGIN 
case selectionbit is 

	when '1' => out_alu <= inputLogical;
	when '0' => out_alu <= inputArithmetic;
	

 end case;
end process aluselection;

end alu;



LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity logicalunit is
port (
	a: in std_logic_vector (3 downto 0);
	b: in std_logic_vector (3 downto 0);
	sel0: in bit_vector (2 downto 0);
	logicalout: out std_logic_vector ( 3 downto 0)
);
end logicalunit;
architecture logic of logicalunit is
signal compa,compb,and4,or4,xor4,xnor4,nand4,nor4: std_logic_vector (3 downto 0);
component muxL is
	port(	
	input0L: in std_logic_vector (3 downto 0);
	input1L: in std_logic_vector (3 downto 0);
	input2L: in std_logic_vector (3 downto 0);
	input3L: in std_logic_vector (3 downto 0);
	input4L: in std_logic_vector (3 downto 0);
	input5L: in std_logic_vector (3 downto 0);
	input6L: in std_logic_vector (3 downto 0);
	input7L: in std_logic_vector (3 downto 0);
	selL: in bit_vector (2 downto 0);
	out_muxL: out std_logic_vector (3 downto 0)
); 	
end component;
begin
	compa <= not a;
	compb <= not b;
	and4 <= a and b;
	or4 <= a or b;
	xor4 <= a xor b;
	xnor4 <= a xnor b;
	nand4 <= a nand b;
	nor4 <= a nor b;
mux_1: muxL port map ( input0L => compa, input1L => compb, input2L => and4, input3L => or4, input4L => xor4, input5L => xnor4, input6L => nand4, input7L => nor4, selL=>sel0, out_muxL => logicalout);
end logic;



LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity arithmeticunit is
port (
	a: in std_logic_vector (3 downto 0);
	b: in std_logic_vector (3 downto 0);
	sel2: in bit_vector (2 downto 0);
	arithmeticout: out std_logic_vector ( 7 downto 0)
);
end arithmeticunit;
architecture arithmetic of arithmeticunit is
component muxA 
	port(	
	input0A: in std_logic_vector (7 downto 0);
	input1A: in std_logic_vector (7 downto 0);
	input2A: in std_logic_vector (7 downto 0);
	input3A: in std_logic_vector (7 downto 0);
	input4A: in std_logic_vector (7 downto 0);
	input5A: in std_logic_vector (7 downto 0);
	input6A: in std_logic_vector (7 downto 0);
	input7A: in std_logic_vector (7 downto 0);
	selA: in bit_vector (2 downto 0);
	out_muxA: out std_logic_vector (7 downto 0)
); 	
end component;

signal inc_a4, dec_a4,  inc_b4, dec_b4 ,add4, sub4,trans_b4, notb: std_logic_vector (3 downto 0);
signal inc_a8, inc_b8, dec_a8, dec_b8, mul,trans_b8, add8, sub8: std_logic_vector (7 downto 0);
signal carryout: std_logic;
 component std_4B_FA  
	port (std_4B_FA_IN1: IN STD_LOGIC_VECTOR(3 downto 0); 
	std_4B_FA_IN2: IN STD_LOGIC_VECTOR(3 downto 0); 
	std_4B_FA_CARRYIN: IN STD_LOGIC; 
	std_4B_FA_CARRYOUT: OUT STD_LOGIC;
	std_4B_FA_OUT: OUT STD_LOGIC_VECTOR(3 downto 0)
); 
end component;
component STD_4B_MULT
port(	std_4B_MULT_IN1: IN STD_LOGIC_VECTOR(3 downto 0); 
	std_4B_MULT_IN2: IN STD_LOGIC_VECTOR(3 downto 0);  
	std_4B_MULT_OUT: OUT STD_LOGIC_VECTOR(7 downto 0)
);
end component;

begin
	--increment a
	incrementa: std_4B_FA PORT MAP (std_4B_FA_IN1 => a, std_4B_FA_IN2 => "0001", std_4B_FA_CARRYIN => '0', std_4B_FA_CARRYOUT => carryout, std_4B_FA_OUT => inc_a4);
	inc_a8 <= (inc_a4(3), inc_a4(3), inc_a4(3), inc_a4(3), inc_a4(3), inc_a4(2),inc_a4(1), inc_a4(0));
	--increment b
	incrementb: std_4B_FA PORT MAP (std_4B_FA_IN1 => b, std_4B_FA_IN2 => "0001", std_4B_FA_CARRYIN => '0', std_4B_FA_CARRYOUT => carryout, std_4B_FA_OUT => inc_b4);
	inc_b8 <= (inc_b4(3), inc_b4(3), inc_b4(3), inc_b4(3), inc_b4(3), inc_b4(2),inc_b4(1), inc_b4(0));

	--decrement a
	decrementa: std_4B_FA PORT MAP (std_4B_FA_IN1 => a, std_4B_FA_IN2 => "1111", std_4B_FA_CARRYIN => '0', std_4B_FA_CARRYOUT => carryout, std_4B_FA_OUT => dec_a4);
	dec_a8 <= (dec_a4(3), dec_a4(3), dec_a4(3), dec_a4(3), dec_a4(3), dec_a4(2),dec_a4(1), dec_a4(0));	
	--decrement b
	decrementb: std_4B_FA PORT MAP (std_4B_FA_IN1 => b, std_4B_FA_IN2 => "1111", std_4B_FA_CARRYIN => '0', std_4B_FA_CARRYOUT => carryout, std_4B_FA_OUT => dec_b4);
	dec_b8 <= (dec_b4(3), dec_b4(3), dec_b4(3), dec_b4(3), dec_b4(3), dec_b4(2),dec_b4(1), dec_b4(0));
        --multiplication 
        multiplication: STD_4B_MULT PORT MAP (std_4B_MULT_IN1 => a , std_4B_MULT_IN2 => b ,std_4B_MULT_OUT => mul );
        --addition 
        addition : std_4B_FA PORT MAP (std_4B_FA_IN1 => a, std_4B_FA_IN2 => b, std_4B_FA_CARRYIN => '0', std_4B_FA_CARRYOUT => carryout, std_4B_FA_OUT =>add4);
        add8 <= (add4(3),add4(3),add4(3),add4(3),add4(3),add4(2),add4(1),add4(0));
        --subtraction
	notb <= not b;
        subtraction :std_4B_FA PORT MAP(std_4B_FA_IN1 => a, std_4B_FA_IN2 => notb,std_4B_FA_CARRYIN => '1', std_4B_FA_CARRYOUT => carryout, std_4B_FA_OUT =>sub4);
        sub8<= (sub4(3),sub4(3),sub4(3),sub4(3),sub4(3),sub4(2),sub4(1),sub4(0));
        --transfer b
        trans_b4 <= b ;
        trans_b8 <= (trans_b4(3),trans_b4(3),trans_b4(3),trans_b4(3),trans_b4(3),trans_b4(2),trans_b4(1),trans_b4(0));

mux_2: muxA port map ( input0A => inc_a8, input1A => dec_a8, input2A => mul, input3A => inc_b8, input4A => dec_b8, input5A => trans_b8, input6A => add8, input7A => sub8,selA=>sel2, out_muxA => arithmeticout);
end arithmetic;





LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY muxA is
PORT (
	input0A: IN STD_LOGIC_VECTOR  (7 downto 0);
	input1A: IN STD_LOGIC_VECTOR  (7 downto 0);
	input2A: IN STD_LOGIC_VECTOR  (7 downto 0);
	input3A: IN STD_LOGIC_VECTOR  (7 downto 0);
	input4A: IN STD_LOGIC_VECTOR  (7 downto 0);
	input5A: IN STD_LOGIC_VECTOR  (7 downto 0);
	input6A: IN STD_LOGIC_VECTOR  (7 downto 0);
	input7A: IN STD_LOGIC_VECTOR  (7 downto 0);
	selA: IN BIT_VECTOR (2 downto 0);
	out_muxA: OUT STD_LOGIC_VECTOR  (7 downto 0)
	);
END muxA;
ARCHITECTURE arithmetic OF muxA is
BEGIN
arithmeticselection: process( input0A, input1A, input2A ,input3A,input4A, input5A, input6A, input7A, selA)
 
BEGIN 
case selA is 

	when "000" => out_muxA <= input0A;
	when "001" => out_muxA <= input1A;
	when "010" => out_muxA <= input2A;
	when "011" => out_muxA <= input3A;
	when "100" => out_muxA <= input4A;
	when "101" => out_muxA <= input5A;
	when "110" => out_muxA <= input6A;
	when "111" => out_muxA <= input7A;

	--default case needed to be synthesizable

 end case;
end process arithmeticselection;

end arithmetic;






LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity alu is
port (      
        a_std: in std_logic_vector (3 downto 0);
	b_std: in std_logic_vector (3 downto 0);
	selalu: in bit_vector (3 downto 0);
	outalu: out std_logic_vector ( 7 downto 0)
);
end alu;
architecture std_alu of alu is
component arithmeticunit is
port (
	a: in std_logic_vector (3 downto 0);
	b: in std_logic_vector (3 downto 0);
	sel2: in bit_vector (2 downto 0);
	arithmeticout: out std_logic_vector ( 7 downto 0)
);
end component;
component logicalunit is
port (
	a: in std_logic_vector (3 downto 0);
	b: in std_logic_vector (3 downto 0);
	sel0: in bit_vector (2 downto 0);
	logicalout: out std_logic_vector ( 3 downto 0)
);
end component;
component muxalu is
PORT (
	inputArithmetic: IN STD_LOGIC_VECTOR  (7 downto 0);
	inputLogical: IN STD_LOGIC_VECTOR  (7 downto 0);

	selectionbit: IN BIT;
	out_alu: OUT STD_LOGIC_VECTOR  (7 downto 0)
	);
END component;

signal AR_U8 : std_logic_vector (7 downto 0);
signal operation_sel : bit_vector (2 downto 0);
signal L_U4:std_logic_vector (3 downto 0);
signal L_U8:std_logic_vector (7 downto 0);
signal muxalu_sel: bit ;
begin 
operation_sel <= (selalu(2),selalu(1),selalu(0));
L_U8<= ('0', '0','0','0', L_U4(3), L_U4(2),L_U4(1), L_U4(0));
 muxalu_sel<=(selalu(3));

A_unit:arithmeticunit port map(a=> a_std ,b=> b_std ,sel2=> operation_sel ,arithmeticout=>AR_U8);
L_unit:logicalunit port map (a=> a_std ,b=> b_std ,sel0=> operation_sel ,logicalout=>L_U4);
muxalu_std:muxalu port map (inputArithmetic=>AR_U8,inputLogical=>L_U8,selectionbit=>muxalu_sel,out_alu=>outalu);

end std_alu;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
entity alu_tb is
end alu_tb;
architecture alu_tb_ARCHITECTURE of alu_tb is
component alu
port(a_std: in std_logic_vector (3 downto 0);
b_std: in std_logic_vector (3 downto 0);
selalu: in bit_vector (3 downto 0);
outalu: out std_logic_vector ( 7 downto 0)
);
end component;
signal a_testvector : std_logic_vector (3 downto 0);
signal b_testvector : std_logic_vector (3 downto 0);
signal sel_testvector : bit_vector (3 downto 0);
signal output : std_logic_vector ( 7 downto 0);
constant timeincrement : time := 10 ns;
begin
UUT : alu port map (a_std => a_testvector, b_std => b_testvector, selalu => sel_testvector, outalu => output);
TESTING: PROCESS
BEGIN
--ARITHMETIC UNIT TESTING--
--INCREMENT A, A IS A POSITIVE NUMBER %CORRECT
a_testvector <= "0110";
b_testvector <= "0011";
sel_testvector <= "0000";
wait for timeincrement;
--INCREMENT A, A IS A NEGATIVE NUMBER %CORRECT
a_testvector <= "1001";
wait for timeincrement;
--DECREMENT A, A IS A POSITIVE NUMBER %CORRECT
a_testvector <= "0101";
sel_testvector <= "0001";
wait for timeincrement;
--DECREMENT A, A IS A NEGATIVE NUMBER %CORRECT
a_testvector <= "1011";
wait for timeincrement;
--MULTIPLY A AND B, BOTH POSITIVE %CORRECT
a_testvector <= "0110";
b_testvector <= "0011";
sel_testvector <= "0010";
wait for timeincrement;
--MULTIPLY A AND B, A POSITIVE B NEGATIVE %WRONG, 6 * -5 GAVE 01000010, MSB IS NOT 1, NOT A NEGATIVE NUMBER? %MULTIPLY NOT SIGNED YET APPARENTLY
a_testvector <= "0110";
b_testvector <= "1011";
sel_testvector <= "0010";
wait for timeincrement;
--MULTIPLY A AND B, A NEGATIVE B POSITIVE %MULTIPLY NOT SIGNED APPARENTLY, DID NOT BOTHER CHECKING CORRECTNESS
a_testvector <= "1110";
b_testvector <= "0011";
sel_testvector <= "0010";
wait for timeincrement;
--MULTIPLY A AND B, A NEGATIVE B NEGATIVE %MULTIPLY NOT SIGNED APPARENTLY, DID NOT BOTHER CHECKING CORRECTNESS
a_testvector <= "1110";
b_testvector <= "1011";
sel_testvector <= "0010";
wait for timeincrement;
--INCREMENT B, B IS A POSITIVE NUMBER %CORRECT
b_testvector <= "0011";
sel_testvector <= "0011";
wait for timeincrement;
--INCREMENT B, B IS A NEGATIVE NUMBER %CORRECT
b_testvector <= "1011";
sel_testvector <= "0011";
wait for timeincrement;
--DECREMENT B, B IS A POSITIVE NUMBER %CORRECT
b_testvector <= "0011";
sel_testvector <= "0100";
wait for timeincrement;
--DECREMENT B, B IS A NEGATIVE NUMBER %CORRECT
b_testvector <= "1011";
sel_testvector <= "0100";
wait for timeincrement;
--TRANSFER B, B IS A POSITIVE NUMBER %CORRECT
b_testvector <= "0011";
sel_testvector <= "0101";
wait for timeincrement;
--TRANSFER B, B IS A NEGATIVE NUMBER %CORRECT
b_testvector <= "1011";
sel_testvector <= "0101";
wait for timeincrement;
--ADD A and B, POSITIVE POSITIVE %CORRECT
a_testvector <= "0010";
b_testvector <= "0011";
sel_testvector <= "0110";
wait for timeincrement;
--ADD A and B, POSITIVE NEGATIVE %CORRECT
a_testvector <= "0110";
b_testvector <= "1011";
sel_testvector <= "0110";
wait for timeincrement;
--ADD A and B, NEGATIVE POSITIVE %CORRECT
a_testvector <= "1010";
b_testvector <= "0011";
sel_testvector <= "0110";
wait for timeincrement;
--ADD A and B, NEGATIVE NEGATIVE %CORRECT
a_testvector <= "1010";
b_testvector <= "1111";
sel_testvector <= "0110";
wait for timeincrement;
--SUBTRACT A AND B %CORRECT
a_testvector <= "0111";
b_testvector <= "0011";
sel_testvector <= "0111";
wait for timeincrement;
--LOGIC UNIT TESTING--
--COMPLEMENT A %CORRECT
a_testvector <= "0111";
sel_testvector <= "1000";
wait for timeincrement;
--COMPLEMENT B %CORRECT
b_testvector <= "1001";
sel_testvector <= "1001";
wait for timeincrement;
--A AND B %CORRECT
a_testvector <= "0111";
b_testvector <= "1101";
sel_testvector <= "1010";
wait for timeincrement;
--A OR B %CORRECT
a_testvector <= "0101";
b_testvector <= "1101";
sel_testvector <= "1011";
wait for timeincrement;
--A XOR B %CORRECT
a_testvector <= "0111";
b_testvector <= "1101";
sel_testvector <= "1100";
wait for timeincrement;
--A XNOR B %CORRECT
a_testvector <= "0111";
b_testvector <= "1101";
sel_testvector <= "1101";
wait for timeincrement;
--A NAND B %CORRECT
a_testvector <= "0110";
b_testvector <= "1100";
sel_testvector <= "1110";
wait for timeincrement;
--A NOR B %CORRECT
a_testvector <= "0110";
b_testvector <= "1100";
sel_testvector <= "1111";
wait for timeincrement;
end process;
end alu_tb_ARCHITECTURE;