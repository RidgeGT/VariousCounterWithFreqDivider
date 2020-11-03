--BCDCounter.vhd;
-- Ridge Tejuco
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity BCDCounter is
	port(
    	clk,reset,direction,pause:in std_logic;
    	DOUT: out std_logic_vector(7 downto 0)
	);
end BCDCounter;
architecture behavioral of BCDCounter is
signal digit1,digit2: unsigned (3 downto 0);
begin
	process(clk)
	begin
    	if clk = '1' and clk' event then
        	if reset = '1' then
            	digit1 <= (others => '0');
            	digit2 <= (others => '0');
        	elsif pause = '1' then
            	digit1 <= digit1;
            	digit2 <= digit2;
        	elsif direction = '1' then
            	if(digit1 = "1001" and digit2 = "1001")then
                	digit1 <= (others => '0');
                	digit2 <= (others => '0');
            	elsif(digit1 = "1001") then
                	digit1 <= (others => '0');
                	digit2 <= digit2 + 1;
            	else
                	digit1 <= digit1 + 1;
            	end if;
        	else
            	if(digit1 = "0000" and digit2 = "0000")then
                	digit1 <= ("1001");
                	digit2 <= ("1001");
            	elsif(digit1 = "0000") then
                	digit1 <= ("1001");
                	digit2 <= digit2 - 1;
            	else
                	digit1 <= digit1 - 1;
            	end if;
        	end if;
    	end if;
	end process;
	DOUT <= std_logic_vector(digit2&digit1);
end architecture;
