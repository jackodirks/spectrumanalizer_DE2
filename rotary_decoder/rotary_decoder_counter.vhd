LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.all;

ENTITY rotary_encoder_counter IS
  PORT(
    clk, rst, increment, decrement : IN STD_LOGIC;
    count_value : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) --(2^7 - 1) 127 <= maxval 
  );
END rotary_encoder_counter;

ARCHITECTURE counter OF rotary_encoder_counter IS
BEGIN
  PROCESS(clk, rst, increment, decrement)
  VARIABLE counter : UNSIGNED(6 DOWNTO 0) := (OTHERS => '0');
  BEGIN
    IF RISING_EDGE(clk) THEN
      IF rst = '1' THEN
        counter := (OTHERS => '0');
      ELSIF decrement = '1' AND counter /= 0 THEN
        counter := counter - 1;
      ELSIF increment = '1' AND counter /= to_unsigned(99,7) THEN
        counter := counter + 1;
      END IF; --input check
      count_value <= STD_LOGIC_VECTOR(counter);
    END IF; --rising_edge
  END PROCESS;
END ARCHITECTURE;