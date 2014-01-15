LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.all;

ENTITY rotary_encoder_debouncer IS
  PORT(
    clk, rst : IN STD_LOGIC;
    count_done : OUT STD_LOGIC
  );
END rotary_encoder_debouncer;

ARCHITECTURE debouncer OF rotary_encoder_debouncer IS
BEGIN
  PROCESS(clk, rst)
  VARIABLE counter : INTEGER RANGE 0 TO 500000 := 0;
  CONSTANT value : INTEGER RANGE 0 TO 50000 := 50000; --TODO: fix
  
  BEGIN
      IF RISING_EDGE(clk) THEN
        IF rst = '1' THEN
          count_done <= '0';
          counter := 0;
        ELSE
          IF counter /= value THEN
            counter := counter + 1;
            count_done <= '0';
          ELSE
            count_done <= '1';
          END IF;            
        END IF;
      END IF;
  END PROCESS;
END ARCHITECTURE;
