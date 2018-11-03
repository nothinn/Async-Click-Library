----------------------------------------------------------------------------------
-- Demux
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.defs.all;

entity demux is
    generic(
        PHASE_INIT : std_logic := '0';
	    PHASE_INIT_B: std_logic := '0';
	    PHASE_INIT_C: std_logic := '0'
	    );
	port(
        rst: in  std_logic;
		-- Input port
		ch_in_a_req : in  std_logic;
		ch_in_a_data: in std_logic_vector(DATA_WIDTH-1 downto 0);
		ch_in_a_ack : out std_logic;

		-- Select port 
		ch_in_sel_req : in  std_logic;
		ch_in_sel_ack : out std_logic;
		selector: in std_logic;

		-- Output channel 1
		ch_out_b_req : out std_logic;
		ch_out_b_data : out std_logic_vector(DATA_WIDTH-1 downto 0);
		ch_out_b_ack : in  std_logic;
		-- Output channel 2
		ch_out_c_req : out std_logic;
		ch_out_c_data: out std_logic_vector(DATA_WIDTH-1 downto 0);
		ch_out_c_ack : in  std_logic
	    );
end demux;

architecture Behavioral of demux is

	signal phase : std_logic;
	signal click : std_logic;
	
	signal sel_ready : std_logic;
	signal data_reg : word_t;
	
	signal phase_b : std_logic;
	signal phase_c : std_logic;
	
	-- Choice 
	signal b_ready, b_selected : std_logic;
	signal c_ready, c_selected : std_logic;

begin
    
	-- Control Path   
    ch_in_sel_ack <= phase;
    ch_in_a_ack <= phase;
    ch_out_b_req <= phase_b;
    ch_out_b_data <= data_reg;
    ch_out_c_req <= phase_c;
    ch_out_c_data <= data_reg;
    
    -- Selector trigger
    sel_ready <= (ch_in_sel_req and not(phase) and ch_in_a_req) or (not(ch_in_sel_req) and phase and not(ch_in_a_req)) after ANDOR3_DELAY + NOT1_DELAY;
	
	b_ready <= phase_b xnor ch_out_b_ack after XOR_DELAY + NOT1_DELAY;
    c_ready <= phase_c xnor ch_out_c_ack after XOR_DELAY + NOT1_DELAY;
    
    -- Select an option
    b_selected <= b_ready and sel_ready and selector after AND3_DELAY;
    c_selected <= c_ready and sel_ready and not(selector) after AND3_DELAY;
    
    click <= b_selected or c_selected after OR2_DELAY;

	clock_regs : process(click, rst)
        begin
            if rst = '1' then
                phase <= PHASE_INIT;
                phase_b <= PHASE_INIT_B;
                phase_c <= PHASE_INIT_C;
                data_reg <= (others => '0');
            elsif rising_edge(click) then
                phase <= not phase after REG_CQ_DELAY;
                phase_b <= phase_b xor selector after REG_CQ_DELAY;
                phase_c <= phase_c xor not(selector) after REG_CQ_DELAY;
                data_reg <= ch_in_a_data after REG_CQ_DELAY;
            end if;
    end process clock_regs;
	
end Behavioral;
