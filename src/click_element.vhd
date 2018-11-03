----------------------------------------------------------------------------------
-- Click element
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.defs.all;

entity click_element is
  generic ( 
            DATA_WIDTH_1: natural := DATA_WIDTH;
            VALUE: natural := 0;
            PHASE_INIT : std_logic := '0');
  port (    rst : in std_logic;
            -- Input channel
            ch_in_ack : out std_logic;
            ch_in_req : in std_logic;
            ch_in_data : in std_logic_vector(DATA_WIDTH_1-1 downto 0);
            -- Output channel
            ch_out_req : out std_logic;
            ch_out_data : out std_logic_vector(DATA_WIDTH_1-1 downto 0);
            ch_out_ack : in std_logic);
end click_element;

architecture behavioral of click_element is

signal phase : std_logic;
signal data_sig: std_logic_vector(DATA_WIDTH_1-1 downto 0);
signal click : std_logic;

attribute dont_touch : string;
attribute dont_touch of  phase : signal is "true";   
attribute dont_touch of  data_sig : signal is "true";  
attribute dont_touch of  click : signal is "true";  

begin
ch_out_req <= phase;
ch_in_ack <= phase;
ch_out_data <= data_sig;

clock_regs: process(click, rst)
begin
    if rst = '1' then
        phase <= PHASE_INIT;
        data_sig <= std_logic_vector(to_unsigned(VALUE, DATA_WIDTH_1));
    elsif rising_edge(click) then
        phase <= not phase after REG_CQ_DELAY;
        data_sig <= ch_in_data after REG_CQ_DELAY;
    end if;
end process;

click <= (not(ch_in_req) and phase and ch_out_ack) or (not(ch_out_ack) and not(phase) and ch_in_req) after AND3_DELAY + OR2_DELAY;


end behavioral;