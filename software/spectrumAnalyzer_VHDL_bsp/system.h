/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'cpu' in SOPC Builder design 'nios2VGA'
 * SOPC Builder design path: ../../nios2VGA.sopcinfo
 *
 * Generated: Fri Jan 03 19:36:50 CET 2014
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_qsys"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x80820
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "tiny"
#define ALT_CPU_DATA_ADDR_WIDTH 0x14
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x4b820
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 0
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0x14
#define ALT_CPU_NAME "cpu"
#define ALT_CPU_RESET_ADDR 0x4b800


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x80820
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_DATA_ADDR_WIDTH 0x14
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x4b820
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 0
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE_LOG2 0
#define NIOS2_ICACHE_SIZE 0
#define NIOS2_INST_ADDR_WIDTH 0x14
#define NIOS2_RESET_ADDR 0x4b800


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_AVALON_TIMER
#define __ALTERA_NIOS2_QSYS
#define __ALTERA_UP_AVALON_SRAM
#define __ALTERA_UP_AVALON_VIDEO_CHARACTER_BUFFER_WITH_DMA
#define __ALTERA_UP_AVALON_VIDEO_PIXEL_BUFFER_DMA


/*
 * SRAM configuration
 *
 */

#define ALT_MODULE_CLASS_SRAM altera_up_avalon_sram
#define SRAM_BASE 0x0
#define SRAM_IRQ -1
#define SRAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SRAM_NAME "/dev/SRAM"
#define SRAM_SPAN 524288
#define SRAM_TYPE "altera_up_avalon_sram"


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone II"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart"
#define ALT_STDERR_BASE 0x81080
#define ALT_STDERR_DEV jtag_uart
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart"
#define ALT_STDIN_BASE 0x81080
#define ALT_STDIN_DEV jtag_uart
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart"
#define ALT_STDOUT_BASE 0x81080
#define ALT_STDOUT_DEV jtag_uart
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "nios2VGA"


/*
 * VGA_Character_buffer_avalon_char_buffer_slave configuration
 *
 */

#define ALT_MODULE_CLASS_VGA_Character_buffer_avalon_char_buffer_slave altera_up_avalon_video_character_buffer_with_dma
#define VGA_CHARACTER_BUFFER_AVALON_CHAR_BUFFER_SLAVE_BASE 0x90000
#define VGA_CHARACTER_BUFFER_AVALON_CHAR_BUFFER_SLAVE_IRQ -1
#define VGA_CHARACTER_BUFFER_AVALON_CHAR_BUFFER_SLAVE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define VGA_CHARACTER_BUFFER_AVALON_CHAR_BUFFER_SLAVE_NAME "/dev/VGA_Character_buffer_avalon_char_buffer_slave"
#define VGA_CHARACTER_BUFFER_AVALON_CHAR_BUFFER_SLAVE_SPAN 8192
#define VGA_CHARACTER_BUFFER_AVALON_CHAR_BUFFER_SLAVE_TYPE "altera_up_avalon_video_character_buffer_with_dma"


/*
 * VGA_Character_buffer_avalon_char_control_slave configuration
 *
 */

#define ALT_MODULE_CLASS_VGA_Character_buffer_avalon_char_control_slave altera_up_avalon_video_character_buffer_with_dma
#define VGA_CHARACTER_BUFFER_AVALON_CHAR_CONTROL_SLAVE_BASE 0x81070
#define VGA_CHARACTER_BUFFER_AVALON_CHAR_CONTROL_SLAVE_IRQ -1
#define VGA_CHARACTER_BUFFER_AVALON_CHAR_CONTROL_SLAVE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define VGA_CHARACTER_BUFFER_AVALON_CHAR_CONTROL_SLAVE_NAME "/dev/VGA_Character_buffer_avalon_char_control_slave"
#define VGA_CHARACTER_BUFFER_AVALON_CHAR_CONTROL_SLAVE_SPAN 8
#define VGA_CHARACTER_BUFFER_AVALON_CHAR_CONTROL_SLAVE_TYPE "altera_up_avalon_video_character_buffer_with_dma"


/*
 * VGA_Pixel_Buffer configuration
 *
 */

#define ALT_MODULE_CLASS_VGA_Pixel_Buffer altera_up_avalon_video_pixel_buffer_dma
#define VGA_PIXEL_BUFFER_BASE 0x81050
#define VGA_PIXEL_BUFFER_IRQ -1
#define VGA_PIXEL_BUFFER_IRQ_INTERRUPT_CONTROLLER_ID -1
#define VGA_PIXEL_BUFFER_NAME "/dev/VGA_Pixel_Buffer"
#define VGA_PIXEL_BUFFER_SPAN 16
#define VGA_PIXEL_BUFFER_TYPE "altera_up_avalon_video_pixel_buffer_dma"


/*
 * control_in configuration
 *
 */

#define ALT_MODULE_CLASS_control_in altera_avalon_pio
#define CONTROL_IN_BASE 0x81030
#define CONTROL_IN_BIT_CLEARING_EDGE_REGISTER 0
#define CONTROL_IN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CONTROL_IN_CAPTURE 0
#define CONTROL_IN_DATA_WIDTH 8
#define CONTROL_IN_DO_TEST_BENCH_WIRING 0
#define CONTROL_IN_DRIVEN_SIM_VALUE 0
#define CONTROL_IN_EDGE_TYPE "NONE"
#define CONTROL_IN_FREQ 50000000
#define CONTROL_IN_HAS_IN 1
#define CONTROL_IN_HAS_OUT 0
#define CONTROL_IN_HAS_TRI 0
#define CONTROL_IN_IRQ -1
#define CONTROL_IN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CONTROL_IN_IRQ_TYPE "NONE"
#define CONTROL_IN_NAME "/dev/control_in"
#define CONTROL_IN_RESET_VALUE 0
#define CONTROL_IN_SPAN 64
#define CONTROL_IN_TYPE "altera_avalon_pio"


/*
 * control_out configuration
 *
 */

#define ALT_MODULE_CLASS_control_out altera_avalon_pio
#define CONTROL_OUT_BASE 0x81020
#define CONTROL_OUT_BIT_CLEARING_EDGE_REGISTER 0
#define CONTROL_OUT_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CONTROL_OUT_CAPTURE 0
#define CONTROL_OUT_DATA_WIDTH 8
#define CONTROL_OUT_DO_TEST_BENCH_WIRING 0
#define CONTROL_OUT_DRIVEN_SIM_VALUE 0
#define CONTROL_OUT_EDGE_TYPE "NONE"
#define CONTROL_OUT_FREQ 50000000
#define CONTROL_OUT_HAS_IN 0
#define CONTROL_OUT_HAS_OUT 1
#define CONTROL_OUT_HAS_TRI 0
#define CONTROL_OUT_IRQ -1
#define CONTROL_OUT_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CONTROL_OUT_IRQ_TYPE "NONE"
#define CONTROL_OUT_NAME "/dev/control_out"
#define CONTROL_OUT_RESET_VALUE 0
#define CONTROL_OUT_SPAN 64
#define CONTROL_OUT_TYPE "altera_avalon_pio"


/*
 * green_led_pio configuration
 *
 */

#define ALT_MODULE_CLASS_green_led_pio altera_avalon_pio
#define GREEN_LED_PIO_BASE 0x81040
#define GREEN_LED_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define GREEN_LED_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define GREEN_LED_PIO_CAPTURE 0
#define GREEN_LED_PIO_DATA_WIDTH 9
#define GREEN_LED_PIO_DO_TEST_BENCH_WIRING 0
#define GREEN_LED_PIO_DRIVEN_SIM_VALUE 0
#define GREEN_LED_PIO_EDGE_TYPE "NONE"
#define GREEN_LED_PIO_FREQ 50000000
#define GREEN_LED_PIO_HAS_IN 0
#define GREEN_LED_PIO_HAS_OUT 1
#define GREEN_LED_PIO_HAS_TRI 0
#define GREEN_LED_PIO_IRQ -1
#define GREEN_LED_PIO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define GREEN_LED_PIO_IRQ_TYPE "NONE"
#define GREEN_LED_PIO_NAME "/dev/green_led_pio"
#define GREEN_LED_PIO_RESET_VALUE 0
#define GREEN_LED_PIO_SPAN 64
#define GREEN_LED_PIO_TYPE "altera_avalon_pio"


/*
 * hal configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK SYS_CLK_TIMER
#define ALT_TIMESTAMP_CLK none


/*
 * jtag_uart configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart altera_avalon_jtag_uart
#define JTAG_UART_BASE 0x81080
#define JTAG_UART_IRQ 16
#define JTAG_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_NAME "/dev/jtag_uart"
#define JTAG_UART_READ_DEPTH 64
#define JTAG_UART_READ_THRESHOLD 8
#define JTAG_UART_SPAN 32
#define JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_WRITE_DEPTH 64
#define JTAG_UART_WRITE_THRESHOLD 8


/*
 * red_led_pio configuration
 *
 */

#define ALT_MODULE_CLASS_red_led_pio altera_avalon_pio
#define RED_LED_PIO_BASE 0x81060
#define RED_LED_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define RED_LED_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define RED_LED_PIO_CAPTURE 0
#define RED_LED_PIO_DATA_WIDTH 18
#define RED_LED_PIO_DO_TEST_BENCH_WIRING 0
#define RED_LED_PIO_DRIVEN_SIM_VALUE 0
#define RED_LED_PIO_EDGE_TYPE "NONE"
#define RED_LED_PIO_FREQ 50000000
#define RED_LED_PIO_HAS_IN 0
#define RED_LED_PIO_HAS_OUT 1
#define RED_LED_PIO_HAS_TRI 0
#define RED_LED_PIO_IRQ -1
#define RED_LED_PIO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RED_LED_PIO_IRQ_TYPE "NONE"
#define RED_LED_PIO_NAME "/dev/red_led_pio"
#define RED_LED_PIO_RESET_VALUE 0
#define RED_LED_PIO_SPAN 64
#define RED_LED_PIO_TYPE "altera_avalon_pio"


/*
 * sys_clk_timer configuration
 *
 */

#define ALT_MODULE_CLASS_sys_clk_timer altera_avalon_timer
#define SYS_CLK_TIMER_ALWAYS_RUN 0
#define SYS_CLK_TIMER_BASE 0x81000
#define SYS_CLK_TIMER_COUNTER_SIZE 32
#define SYS_CLK_TIMER_FIXED_PERIOD 0
#define SYS_CLK_TIMER_FREQ 50000000
#define SYS_CLK_TIMER_IRQ 1
#define SYS_CLK_TIMER_IRQ_INTERRUPT_CONTROLLER_ID 0
#define SYS_CLK_TIMER_LOAD_VALUE 49999
#define SYS_CLK_TIMER_MULT 0.0010
#define SYS_CLK_TIMER_NAME "/dev/sys_clk_timer"
#define SYS_CLK_TIMER_PERIOD 1
#define SYS_CLK_TIMER_PERIOD_UNITS "ms"
#define SYS_CLK_TIMER_RESET_OUTPUT 0
#define SYS_CLK_TIMER_SNAPSHOT 1
#define SYS_CLK_TIMER_SPAN 128
#define SYS_CLK_TIMER_TICKS_PER_SEC 1000.0
#define SYS_CLK_TIMER_TIMEOUT_PULSE_OUTPUT 0
#define SYS_CLK_TIMER_TYPE "altera_avalon_timer"


/*
 * sysid configuration
 *
 */

#define ALT_MODULE_CLASS_sysid altera_avalon_sysid_qsys
#define SYSID_BASE 0x81078
#define SYSID_ID 0
#define SYSID_IRQ -1
#define SYSID_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_NAME "/dev/sysid"
#define SYSID_SPAN 8
#define SYSID_TIMESTAMP 1388773300
#define SYSID_TYPE "altera_avalon_sysid_qsys"

#endif /* __SYSTEM_H_ */
