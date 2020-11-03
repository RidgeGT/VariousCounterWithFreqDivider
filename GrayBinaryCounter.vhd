--GrayBinaryCounter.vhd;
-- Ridge Tejuco
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity GrayCounter is
	port(
    	gray_clk,gray_reset,gray_direction,gray_pause:in std_logic;
    	gray_DOUT: out std_logic_vector(7 downto 0);
    	binary_DOUT: out std_logic_vector(7 downto 0)
	);
end GrayCounter;

architecture behavioral of GrayCounter is
component BinaryCounter is
	port(
    	clk,reset,direction,pause:in std_logic;
    	DOUT: out std_logic_vector(7 downto 0)
	);
end component;
signal BinOut: std_logic_vector(7 downto 0);
begin
	BinCntr: BinaryCounter
	port map(clk => gray_clk,reset => gray_reset,
    	direction => gray_direction,
    	pause => gray_pause,
    	DOUT => BinOut
	);
	binary_DOUT <= BinOut;
	gray_DOUT(7) <= BinOut(7);
	gray_DOUT(6) <= BinOut(7) xor BinOut(6);
	gray_DOUT(5) <= BinOut(6) xor BinOut(5);
	gray_DOUT(4) <= BinOut(5) xor BinOut(4);
	gray_DOUT(3) <= BinOut(4) xor BinOut(3);
	gray_DOUT(2) <= BinOut(3) xor BinOut(2);
	gray_DOUT(1) <= BinOut(2) xor BinOut(1);
	gray_DOUT(0) <= BinOut(1) xor BinOut(0);
end architecture; 
