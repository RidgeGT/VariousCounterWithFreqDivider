--FrequencyDivider.vhd
-- Ridge Tejuco
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
entity FrequencyDivider is
	port(
    	clk,reset:in std_logic;
    	DOUT: out std_logic
	);
end FrequencyDivider;
architecture behavioral of FrequencyDivider is
signal count: unsigned(0 downto 0);
begin
	process(clk)
	begin
    	if clk = '1' and clk' event then
        	if reset = '1' then
            	count <= (others => '0');
        	else
            	count <= count + 1;
        	end if;
    	end if;
	end process;
	DOUT <= and_reduce(std_logic_vector(count));
end architecture;
