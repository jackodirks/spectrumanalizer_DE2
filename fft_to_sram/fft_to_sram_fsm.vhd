LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY fft_to_sram_fsm IS
  PORT(
    reset, clk, nios2_ctrl_has_flipped, fft_ctrl_in, buffer_done, avalon_ack : IN STD_LOGIC;
    avalon_write, fft_ctrl_out, nios_flip_reset, incr_addr : OUT STD_LOGIC
  );
END fft_to_sram_fsm;

ARCHITECTURE fft_to_sram_fsm OF fft_to_sram_fsm IS
TYPE state IS (waiting_for_nios, waiting_for_fft, send_data, evaluate);
SIGNAL present_state, next_state : state := waiting_for_nios;
BEGIN
  --seqencial part: reset
    PROCESS(reset, clk)
    BEGIN
        IF reset = '1' THEN
          present_state <= waiting_for_nios;
        ELSIF rising_edge(clk) THEN
          present_state <= next_state;
        END IF;
      END PROCESS;
    --Concurrent Part: actual state machine
      PROCESS(nios2_ctrl_has_flipped, fft_ctrl_in, buffer_done, avalon_ack)
      BEGIN
          CASE present_state IS
            
            WHEN waiting_for_nios =>
              IF nios2_ctrl_has_flipped = '1' THEN
                  next_state <= waiting_for_fft;
              ELSE
                  next_state <= waiting_for_nios;
              END IF;
              nios_flip_reset <= '0';
              avalon_write <= '0';
              fft_ctrl_out <='1';
              incr_addr <= '0';
              
            WHEN waiting_for_fft =>
              IF fft_ctrl_in = '1' THEN
                next_state <= send_data;
              ELSE
                next_state <= waiting_for_fft;
              END IF;
              nios_flip_reset <= '1';
              avalon_write <= '0';
              fft_ctrl_out <='1';
              incr_addr <= '0';
              
            WHEN send_data =>
              IF avalon_ack = '1' THEN
                next_state <= evaluate;
              ELSE
                next_state <= send_data;
              END IF;
              nios_flip_reset <= '0';
              avalon_write <= '1';
              fft_ctrl_out <='0';
              incr_addr <= '0';
              
            WHEN evaluate =>
              IF buffer_done = '1' THEN
                next_state <= waiting_for_nios;
              ELSIF fft_ctrl_in = '1' THEN
                next_state <= send_data;
              ELSE 
                next_state <= evaluate;
              END IF;
              nios_flip_reset <= '0';
              avalon_write <= '0';
              fft_ctrl_out <='1';
              incr_addr <= '1';
              
          END CASE;
      END PROCESS;   
END ARCHITECTURE;