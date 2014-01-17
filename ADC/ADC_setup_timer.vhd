library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

ENTITY ADC_setup_timer IS
	PORT
	(
		clock_50m	: IN STD_LOGIC;
		reset		: IN STD_LOGIC;
		done		: OUT STD_LOGIC
	);
END ADC_setup_timer;


ARCHITECTURE ADC_setup_timer OF ADC_setup_timer IS
	
BEGIN
process (clock_50m)
	 variable   cnt    : integer range 0 to 32;
    begin
        if (rising_edge(clock_50m)) then
            if reset = '1' then
                -- Reset the counter to 0
                cnt := 0;
					 done <= '0';
				else
                -- Increment the counter if counting is enabled
					 if cnt /= 16 then
                cnt := cnt + 1;
					 end if;
					 if cnt = 16 then
					 done <= '1';
					 else
					 done <= '0';
					 end if;
            end if;
        end if;
    end process;

END ADC_setup_timer;
