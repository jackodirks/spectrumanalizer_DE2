LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.all;

ENTITY fft_to_sram_fsm IS
  PORT(
    reset, clk, n2_in, fft_in, avalon_ack : IN STD_LOGIC;
    addr_offset : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    avalon_write, fft_out, n2_out, addr_reset, addr_enable : OUT STD_LOGIC;
    avalon_addr : OUT STD_LOGIC_VECTOR(18 DOWNTO 0)
  );
END fft_to_sram_fsm;

ARCHITECTURE fft_to_sram_fsm OF fft_to_sram_fsm IS
TYPE state IS (waiting_for_nios, waiting_for_fft, write, increase_offset, evaluate,reset_offset);
SIGNAL present_state, next_state : state := waiting_for_nios;
SIGNAL addr_sig : STD_LOGIC_VECTOR(18 DOWNTO 0) := (OTHERS => '0');
CONSTANT start_addr : UNSIGNED(18 DOWNTO 0) := to_unsigned(16#4B000#,19);
SIGNAL temp_addr : UNSIGNED(18 DOWNTO 0) := (OTHERS => '0');
BEGIN
  --seqencial part: reset
    PROCESS(reset, clk)
    BEGIN
        IF reset = '1' THEN
          present_state <= reset_offset;
        ELSIF rising_edge(clk) THEN
          present_state <= next_state;
        END IF;
      END PROCESS;
      
    --Concurrent Part: actual state machine
      PROCESS(reset, clk, n2_in, fft_in, avalon_ack, addr_offset, present_state)
      BEGIN
          CASE present_state IS
            
            WHEN waiting_for_nios =>
              IF n2_in = '1' THEN
                  next_state <= waiting_for_fft;
              ELSE
                  next_state <= waiting_for_nios;
              END IF;
              n2_out <= '1';
              avalon_write <= '0';
              fft_out <='1';
              addr_reset <= '0';
              addr_enable <= '0';
              
            WHEN waiting_for_fft =>
              IF fft_in = '1' THEN
                next_state <= write;
              ELSE
                next_state <= waiting_for_fft;
              END IF;
              n2_out <= '0';
              avalon_write <= '0';
              fft_out <='1';
              addr_reset <= '0';
              addr_enable <= '0';
              
            WHEN write =>
              IF avalon_ack = '1' THEN
                next_state <= increase_offset;
              ELSE
                next_state <= write;
              END IF;
              n2_out <= '0';
              avalon_write <= '1';
              fft_out <='0';
              addr_reset <= '0';
              addr_enable <= '0';
              
            WHEN increase_offset =>
              next_state <= evaluate;
              n2_out <= '0';
              avalon_write <= '0';
              fft_out <='1';
              addr_reset <= '0';
              addr_enable <= '1'; 
              
            WHEN evaluate =>
              IF TO_INTEGER(UNSIGNED(addr_offset)) = 63 THEN
                next_state <= waiting_for_nios;
              ELSIF UNSIGNED(addr_offset) = TO_UNSIGNED(127,19) THEN
                next_state <= reset_offset;
              ELSE
                next_state <= waiting_for_fft;
              END IF;
              n2_out <= '0';
              avalon_write <= '0';
              fft_out <='1';
              addr_reset <= '0';
              addr_enable <= '0';
              
            WHEN reset_offset =>
              next_state <= waiting_for_nios;
              n2_out <= '0';
              avalon_write <= '0';
              fft_out <='1';
              addr_reset <= '1';
              addr_enable <= '0';
                     
          END CASE;
      END PROCESS;
      --Address output
      temp_addr (6 DOWNTO 0) <= UNSIGNED(addr_offset);
      avalon_addr <= STD_LOGIC_VECTOR(start_addr + (temp_addr sll 4));
         
END ARCHITECTURE;