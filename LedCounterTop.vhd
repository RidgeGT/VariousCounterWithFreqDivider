-- LedCounterTop.vhd
-- Ridge Tejuco
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LedCounterTop is
    Port(
        OnboardClock, pause_top, reset_top,divider_reset, direction_top: in std_logic;
        select_top: in std_logic_vector(2 downto 0);
        LedOut: out std_logic_vector (7 downto 0)
    );
end LedCounterTop;

architecture Behavioral of LedCounterTop is
component FrequencyDivider is
    port(
        clk,reset:in std_logic;
        DOUT: out std_logic
    );
end component;

component GrayCounter is
    port(
        gray_clk,gray_reset,gray_direction,gray_pause:in std_logic;
        gray_DOUT: out std_logic_vector(7 downto 0);
        binary_DOUT: out std_logic_vector(7 downto 0)
    );
end component;

component RingCounter is
    port(
        clk,reset,direction,pause:in std_logic;
        DOUT: out std_logic_vector(7 downto 0)
    );
end component;

component JohnsonCounter is
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
-- LedCounterTop.vhd Continued
end component;

component FibCounter is
    port(
        clk,reset,direction,pause:in std_logic;
        DOUT: out std_logic_vector(7 downto 0)
    );
end component;

component CounterMultiplexer is
    Port (
        counter_select: in std_logic_vector(2 downto 0);
        FibIn,GrayIn,BinIn,BCDIn,JohnIn,RingIn: in std_logic_vector(7 downto 0);
        LED: out std_logic_vector(7 downto 0)
     );
end component;

signal oneHz: std_logic;
signal BinMuxIn,RingMuxIn,JohnMuxIn: std_logic_vector(7 downto 0);
signal GrayMuxIn,BCDMuxIn,FibMuxIn : std_logic_vector(7 downto 0);
signal pause_sig,reset_sig,direction_sig: std_logic;
signal select_sig: std_logic_vector(2 downto 0);
signal OutSig: std_logic_vector(7 downto 0);

begin
    pause_sig <= pause_top;
    reset_sig <= reset_top;
    direction_sig <= direction_top;
    select_sig <= select_top;
    FreqDiv: FrequencyDivider
    port map(
        clk => OnboardClock,
        reset => divider_reset,
        DOUT => oneHz
    );
    
    BinGrayCntr: GrayCounter
    port map(
        gray_clk => oneHz, gray_reset => reset_sig,
        gray_direction => direction_sig, gray_pause => pause_sig,
        gray_DOUT => GrayMuxIn, binary_DOUT => BinMuxIn
    );
    RingCntr: RingCounter
    port map(
        clk => oneHz,reset => reset_sig,
        direction => direction_sig, pause => pause_sig,
     -- LedCounterTop.vhd Continued
DOUT => RingMuxIn
    );
    JohnCntr: JohnsonCounter
    port map(
        clk => oneHz,reset => reset_sig,
        direction => direction_sig, pause => pause_sig,
        DOUT => JohnMuxIn
    );
    
    BCDCntr: BCDCounter
    port map(
        clk => oneHz,reset => reset_sig,
        direction => direction_sig, pause => pause_sig,
        DOUT => BCDMuxIn
    );
    
    FibCntr: FibCounter
    port map(
        clk => oneHz,reset => reset_sig,
        direction => direction_sig, pause => pause_sig,
        DOUT => FibMuxIn
    );  
    CntrMux: CounterMultiplexer
    port map(
        counter_select => select_sig,
        FibIn => FibMuxIn,GrayIn => GrayMuxIn,
        BinIn => BinMuxIn ,BCDIn => BCDMuxIn,
        JohnIn => JohnMuxIn,RingIn => RingMuxIn, 
        LED => OutSig
    );
    LedOut <= OutSig;
end Behavioral;