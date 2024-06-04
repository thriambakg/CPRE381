-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_TPU_MV_Element.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the TPU MAC unit.
--              
-- 01/03/2020 by H3::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_TPU_MV_Element to reflect the new testbench.
entity tb_rippleAdder is

 generic(gCLK_HPER   : time := 10 ns); 

end tb_rippleAdder;

architecture mixed of tb_rippleAdder is

-- Define the total clock period time


-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.

constant cCLK_PER  : time := gCLK_HPER * 2;
component rippleAdder is
generic(N : integer := 32);
  port(i1 		            : in std_logic_vector(N-1 downto 0);
       i2 		            : in std_logic_vector(N-1 downto 0);
       cin 		            : in std_logic;
       s1 		            : out std_logic_vector(N-1 downto 0);
       cout_n 		        : out std_logic);
end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset, cin_s, cout_n_s : std_logic := '0';
signal i1_s,i2_s : std_logic_vector(31 downto 0);
signal s1_s : std_logic_vector(31 downto 0);

-- TODO: change input and output signals as needed.


begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: rippleAdder
  generic map(N => 32)
  port map(
            i1 => i1_s,
			i2 => i2_s,
			cin => cin_s,
			s1 => s1_s,
			cout_n => cout_n_s);
  --You can also do the above port map in one line using the below format: http://www.ics.uci.edu/~jmoorkan/vhdlref/compinst.html

  
  --This first process is to setup the clock for the test bench

	P_CLK: process
  begin
    CLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    CLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;
	  
	  

  -- This process resets the sequential components of the design.
  -- It is held to be 1 across both the negative and positive edges of the clock
  -- so it works regardless of whether the design uses synchronous (pos or neg edge)
  -- or asynchronous resets.
   
	P_RST: process
	  begin
		reset <= '0';   
		wait for gCLK_HPER/2;
		reset <= '1';
		wait for gCLK_HPER*2;
		reset <= '0';
		wait;
	  end process;  
  -- Assign inputs for each test case.
  -- TODO: add test cases as needed.
  P_TEST_CASES: process
  begin
	i1_s <= "00000000000001111110000000000000";
	i2_s <= "00000000000000000011111111111111";
	cin_s <= '0';
	-- EXPECT:out = 0
	wait for gCLK_HPER*2;
	i1_s <= "00000000000000000000000000000000";
	i2_s <= "11111111111111111110000000111111";
	cin_s <= '1';
	-- EXPECT:out = 0
	wait for gCLK_HPER*2;
	i1_s <= "00000000000000000001111111000000";
	i2_s <= "00000000001111111110000000111111";
	cin_s <= '1';
	-- EXPECT:out = 0
	wait for gCLK_HPER*2;


	
	
  end process;

end mixed;
