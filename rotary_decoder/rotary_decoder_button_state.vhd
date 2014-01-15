LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.all;

ENTITY rotary_decoder_button_state IS
  PORT (
    invert_output, clk : IN STD_LOGIC;
    button_state : OUT STD_LOGIC
  );
END rotary_decoder_button_state;

ARCHITECTURE rotary_decoder_button_state OF rotary_decoder_button_state IS
SIGNAL value : STD_LOGIC := '0';
BEGIN
  PROCESS(invert_output, clk)
  BEGIN
    IF RISING_EDGE(clk) THEN
      IF invert_output = '1' THEN
        value <= NOT value;
      END IF; --Invert output
    END IF; --Rising_edge
  END PROCESS;
    button_state <= value;
END ARCHITECTURE;