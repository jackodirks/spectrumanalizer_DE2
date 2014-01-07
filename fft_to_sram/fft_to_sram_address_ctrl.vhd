LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;

ENTITY fft_to_sram_address_cntrl IS
  PORT(
    clk, incr_addr, rst : IN STD_LOGIC;
    buffer_done, nios2_cntrl_out : OUT STD_LOGIC;
    avalon_write_address :  OUT std_logic_vector(18 downto 0)
  );
END fft_to_sram_address_cntrl;

ARCHITECTURE fft_to_sram_address_cntrl OF fft_to_sram_address_cntrl IS

BEGIN
  PROCESS(clk,incr_addr)
  CONSTANT startAddr : UNSIGNED (18 DOWNTO 0) := to_unsigned(16#4B000#,19);
  CONSTANT midAddr : UNSIGNED (18 DOWNTO 0) := to_unsigned(16#4B400#,19);
  CONSTANT endAddr : UNSIGNED (18 DOWNTO 0) := to_unsigned(16#4B800#,19);
  VARIABLE curAddr : UNSIGNED (18 DOWNTO 0) := startAddr;
  VARIABLE last_known_incr_addr : STD_LOGIC := '0';
  VARIABLE buffer_done_out : STD_LOGIC := '1';
  VARIABLE nios2_cntrl_out_out: STD_LOGIC := '0';
  BEGIN
    IF RISING_EDGE(clk) THEN
      IF rst = '1' THEN
        curAddr := startAddr;
        buffer_done_out := '1';
        nios2_cntrl_out_out := '0';
      ELSE
        IF incr_addr /= last_known_incr_addr THEN
            last_known_incr_addr := incr_addr;
            IF incr_addr = '1' THEN
              curAddr := curAddr + 16;
              IF curAddr = midAddr THEN
                buffer_done_out := '1';
                nios2_cntrl_out_out := '1';
              ELSIF curAddr = endAddr THEN
                curAddr := startAddr;
                buffer_done_out := '1';
                nios2_cntrl_out_out := '0';
              ELSE
                buffer_done_out := '0';
              END IF; --Mid/EndAddr check
            END IF; --IF IncrAddr = 1
        END IF; --incr addr
      END IF; --RST
      buffer_done <= buffer_done_out;
      nios2_cntrl_out <= nios2_cntrl_out_out;
      avalon_write_address <= STD_LOGIC_VECTOR(curAddr);
    END IF; --RISING EDGE
  END PROCESS;
  
END ARCHITECTURE;