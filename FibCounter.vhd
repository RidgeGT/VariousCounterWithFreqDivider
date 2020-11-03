--FibCounter.vhd;
-- Ridge Tejuco
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity FibCounter is
	port(
    	clk,reset,direction,pause:in std_logic;
    	DOUT: out std_logic_vector(7 downto 0)
	);
end FibCounter;
architecture behavioral of FibCounter is
signal count,temp: unsigned (7 downto 0);
begin
	DOUT <= std_logic_vector(temp);
	process(clk)
	begin
    	if clk = '1' and clk' event then
        	if reset = '1' then
            	temp <= (others => '0');
            	count <= "00000001";
        	elsif pause = '1' then
            	count <= count;
            	temp <= temp;
        	elsif direction = '1' then
            	temp <= count;
            	count <= count + temp;
        	else
            	count <= temp;
            	temp <= count - temp;
        	end if;
    	end if;
	end process;
end architecture;
