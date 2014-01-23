-- *************************************************************************
-- Author : Wernher Korff																	*
-- Function : follows clock signal when ready is '1' and converting is '0'	*
-- *************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY clock_control IS
PORT(
	clock : IN STD_LOGIC := '0';
	ready : IN STD_LOGIC := '0';
	converting : IN STD_LOGIC := '0';
	clk : OUT STD_LOGIC := '0');
END clock_control;

ARCHITECTURE control OF clock_control IS
	BEGIN
	PROCESS(clock, ready, converting)
	BEGIN
		CASE ready AND NOT converting IS
		WHEN '1' =>
			clk <= clock;
		WHEN OTHERS =>
			clk <= '0';
		END CASE;
	END PROCESS;
END control; 