-- LedCounterTopTB.vhd
-- Ridge Tejuco
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity LedCounterTopTB is
--  Port ( );
end LedCounterTopTB;
architecture Behavioral of LedCounterTopTB is
component LedCounterTop is
	Port(
    	OnboardClock, pause_top, reset_top,divider_reset, direction_top: in std_logic;
    	select_top: in std_logic_vector(2 downto 0);
    	LedOut: out std_logic_vector (7 downto 0)
	);
end component;
signal clock: std_logic := '0';
signal pause_sig,reset_sig,divider_reset_sig,direction_sig: std_logic;
signal LedSig: std_logic_vector(7 downto 0);
signal select_count: unsigned (2 downto 0);
constant cp: time := 10 ns;
begin
	DUT: LedCounterTop
	port map(
    	OnboardClock => clock,
    	pause_top => pause_sig,
    	reset_top => reset_sig,
    	divider_reset => divider_reset_sig,
    	direction_top => direction_sig,
    	select_top => std_logic_vector(select_count),
    	LedOut => LedSig
	);
	clock_gen: process(clock)
	begin
    	clock <= not clock after cp/2;
	end process;
	stim: process
	begin
    	divider_reset_sig <= '1';
    	select_count <= "000";
    	pause_sig <= '0';
    	direction_sig <= '1';
    	wait for cp;
    	divider_reset_sig <= '0';
    	-- 000 Binary  
    	-- 001 Ring
    	-- 010 John
    	-- 011 Gray
-- LedCounterTopTB.vhd    	
-- 100 BCD
    	-- 101+ Fib
    	for ii in 0 to 5 loop
        	reset_sig <= '1';
        	wait for 2*cp;
        	reset_sig <= '0';
        	direction_sig <= '1';
        	wait for 16*cp;
        	pause_sig <= '1';
        	wait for 8*cp;
        	pause_sig <= '0';
        	direction_sig <= '0';
        	wait for 24*cp;
        	select_count <= select_count + 1;
    	end loop;
    	wait;
	end process;
end Behavioral;
