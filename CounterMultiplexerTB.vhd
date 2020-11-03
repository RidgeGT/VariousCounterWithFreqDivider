-- CounterMultiplexerTB.vhd
-- Ridge Tejuco
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity CounterMultiplexerTB is
--  Port ( );
end CounterMultiplexerTB;
architecture Behavioral of CounterMultiplexerTB is
component CounterMultiplexer is
	Port (
    	counter_select: in std_logic_vector(2 downto 0);
    	FibIn, GrayIn, BinIn,BCDIn,JohnIn,RingIn: in std_logic_vector(7 downto 0);
    	LED: out std_logic_vector(7 downto 0)
 	);
end component;
signal FibSig,GraySig,BinSig,BCDSig,JohnSig,RingSig: std_logic_vector(7 downto 0);
signal LEDSig: std_logic_vector(7 downto 0);
signal selCnt: unsigned (2 downto 0);
constant cp: time := 10 ns;
begin
	DUT: CounterMultiplexer
	port map(
    	counter_select => std_logic_vector(selCnt),
    	FibIn => FibSig,
    	GrayIn => GraySig,
    	BinIn => BinSig,
    	BCDIn => BCDSig,
    	JohnIn => JohnSig,
    	RingIn => RingSig,
    	LED => LEDSig
	);
	STIM: process
	begin
    	BinSig <= "00000001";
    	RingSig <= "00000010";
    	JohnSig <= "00000100";
    	GraySig <= "00001000";
    	BCDSig <= "00010000";
    	FibSig <= "00100000";
    	-- Rather than attaching the counter modules to each signal
    	-- This test bench represents each counter by a one hot value
    	selCnt <= "000";
    	for ii in 0 to 7 loop
        	wait for cp;
        	selCnt <= selCnt + 1;
    	end loop;
    	wait;
	end process;
end Behavioral;
