----------------------------------------------------------------------------------
-- Fork
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.defs.all;

entity Fork is
    generic ( 
       PHASE_INIT : std_logic := '0');
	port(
	   rst:         in std_logic;
	   clk:         out std_logic;
	   -- Input channel
       a_req_in:    in std_logic;
       a_ack_out:   out std_logic;
	   -- Output channel 1
       b_req_out:   out std_logic;
       b_ack_in:    in std_logic;
       -- Output channel 2
       c_req_out:   out std_logic;
       c_ack_in:    in std_logic
	);
end Fork;

architecture arch of Fork is

	signal click: std_logic;
	signal phase: std_logic := PHASE_INIT;
	signal and_acks_high_in: std_logic;
	signal and_acks_low_in: std_logic;
	
	attribute dont_touch : string;
    attribute dont_touch of  phase : signal is "true";   
    attribute dont_touch of  click : signal is "true"; 

begin
	-- Control Path
	b_req_out <= phase;
	c_req_out <= phase;
	a_ack_out <= phase;

	-- Click control circuit F()
	and_acks_high_in <= b_ack_in and c_ack_in;
	and_acks_low_in  <= (not b_ack_in) and (not c_ack_in);

    click <= (a_req_in and and_acks_low_in and not(phase)) or (not(a_req_in) and and_acks_high_in and phase) after AND2_DELAY + AND3_DELAY + OR2_DELAY; 

	clock_regs: process(click, rst)
	begin
	    if rst = '1' then
	       phase <= PHASE_INIT;
	    else
            if rising_edge(click) then
                phase <= not phase after REG_CQ_DELAY;
            end if;
        end if;
	end process clock_regs;
    
    clk <= click;
    
end arch;