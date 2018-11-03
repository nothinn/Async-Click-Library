----------------------------------------------------------------------------------
-- MUX
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.defs.all;

entity buff_mux is
	--generic for initializing the phase registers
	generic(PHASE_INIT : std_logic := '0';
	       PHASE_INIT_A: std_logic := '0';
	       PHASE_INIT_B: std_logic := '0');
	port(
        rst     : in  std_logic; -- rst line
		-- Input from channel 1
		ch_in_a_req : in  std_logic;
		ch_in_a_data: in std_logic_vector(DATA_WIDTH-1 downto 0);
		ch_in_a_ack : out std_logic;

		-- Input from channel 2
		ch_in_b_req : in std_logic;
		ch_in_b_data: in std_logic_vector(DATA_WIDTH-1 downto 0);
		ch_in_b_ack : out std_logic;

		-- Output port 
		ch_out_c_req : out std_logic;
		ch_out_c_data: out std_logic_vector(DATA_WIDTH-1 downto 0);
		ch_out_c_ack : in  std_logic;
		
        -- Select port
        ch_in_sel_req : in std_logic;
        ch_in_sel_ack: out std_logic;
        selector: in std_logic_vector(0 downto 0)
	);
end buff_mux;

architecture arch of buff_mux is

	-- the registers
	signal phase : std_logic;
	signal data_reg : word_t;
	-- register control
	signal phase_a : std_logic;
	signal phase_b : std_logic;
	-- Clock
	signal click : std_logic;
	signal pulse : std_logic;
	-- control gates
	signal a_ready, b_ready : std_logic;
	signal selected_a, selected_b : std_logic;
	
	attribute dont_touch : string;
    attribute dont_touch of  phase, phase_a, phase_b, data_reg, pulse : signal is "true";   
    attribute dont_touch of  click : signal is "true";  

begin
	-- Control Path
	ch_in_sel_ack <= phase;
	ch_out_c_req <= phase;
	ch_out_c_data <= data_reg;
	ch_in_a_ack <= phase_a;
	ch_in_b_ack <= phase_b;
	
	--input state
	a_ready <= phase_a xor ch_in_a_req after XOR_DELAY;
	b_ready <= phase_b xor ch_in_b_req after XOR_DELAY;
	
	--Selector triggered pulse
    pulse <= (ch_in_sel_req and not(phase) and not(ch_out_c_ack)) or (not(ch_in_sel_req) and phase and ch_out_c_ack) after AND3_DELAY + OR2_DELAY;
	
	--check if selected
	selected_a <= a_ready and pulse after AND3_DELAY;
	selected_b <= b_ready and pulse after AND3_DELAY;
	
	--Generate clock tick
	click <= selected_a or selected_b after OR2_DELAY;

	
	reg : process(click, rst)
    begin
        if rst = '1' then
            phase <= PHASE_INIT;
            phase_a <= PHASE_INIT_A;
            phase_b <= PHASE_INIT_B;
            data_reg <= (others => '0');
        elsif rising_edge(click) then
            -- Click control register loops back to itself
            phase <= not phase after REG_CQ_DELAY;
            phase_a <= phase_a xor selector(0) after REG_CQ_DELAY;
            phase_b <= phase_b xor not(selector(0)) after REG_CQ_DELAY;
            if selector(0) = '1' then
                data_reg <= ch_in_a_data after REG_CQ_DELAY;
            else
                data_reg <= ch_in_b_data after REG_CQ_DELAY;
            end if;
        end if;
    end process;


end arch;
