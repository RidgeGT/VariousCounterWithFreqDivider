--CounterTB.vhd;
-- Ridge Tejuco
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity CounterTB is
--  Port ( );
end CounterTB;
architecture Behavioral of CounterTB is
component GrayCounter is
	port(
    	gray_clk,gray_reset,gray_direction,gray_pause:in std_logic;
    	gray_DOUT: out std_logic_vector(7 downto 0);
    	binary_DOUT: out std_logic_vector(7 downto 0)
	);
end component;
component JohnsonCounter is
	port(
    	clk,reset,direction,pause:in std_logic;
    	DOUT: out std_logic_vector(7 downto 0)
	);
end component;
component FibCounter is
	port(
    	clk,reset,direction,pause:in std_logic;
    	DOUT: out std_logic_vector(7 downto 0)
	);
end component;
component RingCounter is
	port(
    	clk,reset,direction,pause:in std_logic;
    	DOUT: out std_logic_vector(7 downto 0)
	);
end component;
component BCDCounter is
	port(
    	clk,reset,direction,pause:in std_logic;
    	DOUT: out std_logic_vector(7 downto 0)
	);
end component;
signal clk_sig,reset_sig,direction_sig,pause_sig: std_logic := '0';
signal gray_out_sig,binary_out_sig: std_logic_vector(7 downto 0);
signal johnson_out_sig,Fib_out_sig: std_logic_vector(7 downto 0);
signal ring_out_sig,BCD_out_sig: std_logic_vector(7 downto 0);
constant cp: time := 10 ns;
begin
	DUT0: GrayCounter
	port map(
    	gray_clk => clk_sig, gray_reset => reset_sig,
    	gray_direction => direction_sig,gray_pause => pause_sig,
    	gray_DOUT => gray_out_sig,
    	binary_DOUT => binary_out_sig
	);
	DUT1: JohnsonCounter
	port map(
    	clk => clk_sig, reset => reset_sig,
    	direction => direction_sig,pause => pause_sig,
    	DOUT => johnson_out_sig
	);
	DUT2: FibCounter
	port map(
    	clk => clk_sig, reset => reset_sig,
    	direction => direction_sig,pause => pause_sig,
    	DOUT => fib_out_sig
	);
	DUT3: RingCounter
    	port map(
    	clk => clk_sig, reset => reset_sig,
    	direction => direction_sig,pause => pause_sig,
    	DOUT => ring_out_sig
	);
	DUT4: BCDCounter
	port map(
    	clk => clk_sig, reset => reset_sig,
    	direction => direction_sig,pause => pause_sig,
    	DOUT => BCD_out_sig
	);
	clock_gen:process(clk_sig)
	begin
    	clk_sig <= not clk_sig after cp/2;
	end process;
    	stim: process
	begin
    	-- pause_sig <= '0';
    	-- direction_sig <= '1';
    	reset_sig <= '1';
    	wait for cp;
    	reset_sig <= '0';
    	direction_sig <= '1';
    	wait for 15*cp;
    	pause_sig <= '1';
    	wait for 8*cp;
    	pause_sig <= '0';
    	direction_sig <= '0';
    	wait for 15*cp;
    	wait;
	end process;
end Behavioral;
