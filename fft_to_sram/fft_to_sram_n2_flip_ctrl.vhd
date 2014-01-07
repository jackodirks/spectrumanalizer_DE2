LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY fft_to_sram_n2_flip_ctrl IS
  PORT(
    n2_flip_reset, clk, nios_ctrl_in, rst : IN STD_LOGIC;
    nios2_ctrl_has_flipped : OUT STD_LOGIC
  );
END fft_to_sram_n2_flip_ctrl;

ARCHITECTURE fft_to_sram_n2_flip_ctrl OF fft_to_sram_n2_flip_ctrl IS
BEGIN
  PROCESS(n2_flip_reset,nios_ctrl_in,clk)
  VARIABLE last_known_nios, last_known_flip_reset, nios2_ctrl_flipped: STD_LOGIC :='0';
  BEGIN
    IF RISING_EDGE(clk) THEN
      IF rst = '1' THEN
        nios2_ctrl_flipped := '0';
        last_known_nios := '0';
        last_known_flip_reset := '0';
        nios2_ctrl_flipped := '0';
    ELSE
          IF last_known_nios /= nios_ctrl_in THEN
            nios2_ctrl_flipped := '1';
				last_known_nios := nios_ctrl_in;
          END IF; --Flip check
          IF last_known_flip_reset /= n2_flip_reset THEN --If the signal is different from last time
            last_known_flip_reset := n2_flip_reset; --Equalize it
            IF n2_flip_reset = '1' THEN -- And check if its 1.
              nios2_ctrl_flipped := '0';
            END IF; --Flip reset
          END IF; --Check n2_flip_rst
    END IF; --rst
        nios2_ctrl_has_flipped <= nios2_ctrl_flipped;
		  --nios2_ctrl_has_flipped <= '1';
    END IF; --RISING EDGE
  END PROCESS;
END ARCHITECTURE;
