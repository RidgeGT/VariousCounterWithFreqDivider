--CounterMultiplexer.vhd
-- Ridge Tejuco
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity CounterMultiplexer is
	Port (
    	counter_select: in std_logic_vector(2 downto 0);
    	FibIn,GrayIn,BinIn,BCDIn,JohnIn,RingIn: in std_logic_vector(7 downto 0);
    	LED: out std_logic_vector(7 downto 0)
 	);
end CounterMultiplexer;
architecture Behavioral of CounterMultiplexer is
begin
process(counter_select,BinIn,RingIn,JohnIn,GrayIn,BCDIn,FibIn)
begin
	case counter_select is
    	when "000" => LED <= BinIn;
    	when "001" => LED <= RingIn;
    	when "010" => LED <= JohnIn;
    	when "011" => LED <= GrayIn;
    	when "100" => LED <= BCDIn;
    	when others => LED <= FibIn;
	end case;
end process;
end Behavioral;
