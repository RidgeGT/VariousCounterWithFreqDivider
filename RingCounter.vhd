--RingCounter.vhd;
-- Ridge Tejuco
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity RingCounter is
	port(
    	clk,reset,direction,pause:in std_logic;
    	DOUT: out std_logic_vector(7 downto 0)
	);
end RingCounter;

architecture behavioral of RingCounter is
signal count: unsigned (7 downto 0);
begin
	DOUT <= std_logic_vector(count);
	process(clk)
	begin
    	if clk = '1' and clk' event then
        	if reset = '1' then
            	count <= "00000001";
        	elsif pause = '1' then
            	count <= count;
        	elsif direction = '0' then
            	count <=  count(0) & count(7 downto 1);
        	else
            	count <= count(6 downto 0) & count(7);
        	end if;
    	end if;
	end process;
end architecture;
