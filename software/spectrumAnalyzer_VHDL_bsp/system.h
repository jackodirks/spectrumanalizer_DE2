/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'cpu' in SOPC Builder design 'nios2VGA'
 * SOPC Builder design path: ../../nios2VGA.sopcinfo
 *
 * Generated: Wed Feb 05 18:54:36 CET 2014
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
#define ALT_CPU_BREAK_ADDR 0x82820
#define ALT_CPU_CPU_FREQ 200000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "tiny"
#define ALT_CPU_DATA_ADDR_WIDTH 0x14
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x4b020
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 200000000
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
#define ALT_CPU_RESET_ADDR 0x4b000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x82820
#define NIOS2_CPU_FREQ 200000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_DATA_ADDR_WIDTH 0x14
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x4b020
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
#define NIOS2_RESET_ADDR 0x4b000


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
 * FFT_in_0 configuration
 *
 */

#define ALT_MODULE_CLASS_FFT_in_0 altera_avalon_pio
#define FFT_IN_0_BASE 0x830a0
#define FFT_IN_0_BIT_CLEARING_EDGE_REGISTER 0
#define FFT_IN_0_BIT_MODIFYING_OUTPUT_REGISTER 0
#define FFT_IN_0_CAPTURE 0
#define FFT_IN_0_DATA_WIDTH 32
#define FFT_IN_0_DO_TEST_BENCH_WIRING 0
#define FFT_IN_0_DRIVEN_SIM_VALUE 0
#define FFT_IN_0_EDGE_TYPE "NONE"
#define FFT_IN_0_FREQ 200000000
#define FFT_IN_0_HAS_IN 1
#define FFT_IN_0_HAS_OUT 0
#define FFT_IN_0_HAS_TRI 0
#define FFT_IN_0_IRQ -1
#define FFT_IN_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define FFT_IN_0_IRQ_TYPE "NONE"
#define FFT_IN_0_NAME "/dev/FFT_in_0"
#define FFT_IN_0_RESET_VALUE 0
#define FFT_IN_0_SPAN 16
#define FFT_IN_0_TYPE "altera_avalon_pio"


/*
 * FFT_in_1 configuration
 *
 */

#define ALT_MODULE_CLASS_FFT_in_1 altera_avalon_pio
#define FFT_IN_1_BASE 0x83090
#define FFT_IN_1_BIT_CLEARING_EDGE_REGISTER 0
#define FFT_IN_1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define FFT_IN_1_CAPTURE 0
#define FFT_IN_1_DATA_WIDTH 32
#define FFT_IN_1_DO_TEST_BENCH_WIRING 0
#define FFT_IN_1_DRIVEN_SIM_VALUE 0
#define FFT_IN_1_EDGE_TYPE "NONE"
#define FFT_IN_1_FREQ 200000000
#define FFT_IN_1_HAS_IN 1
#define FFT_IN_1_HAS_OUT 0
#define FFT_IN_1_HAS_TRI 0
#define FFT_IN_1_IRQ -1
#define FFT_IN_1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define FFT_IN_1_IRQ_TYPE "NONE"
#define FFT_IN_1_NAME "/dev/FFT_in_1"
#define FFT_IN_1_RESET_VALUE 0
#define FFT_IN_1_SPAN 16
#define FFT_IN_1_TYPE "altera_avalon_pio"


/*
 * FFT_in_2 configuration
 *
 */

#define ALT_MODULE_CLASS_FFT_in_2 altera_avalon_pio
#define FFT_IN_2_BASE 0x83080
#define FFT_IN_2_BIT_CLEARING_EDGE_REGISTER 0
#define FFT_IN_2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define FFT_IN_2_CAPTURE 0
#define FFT_IN_2_DATA_WIDTH 32
#define FFT_IN_2_DO_TEST_BENCH_WIRING 0
#define FFT_IN_2_DRIVEN_SIM_VALUE 0
#define FFT_IN_2_EDGE_TYPE "NONE"
#define FFT_IN_2_FREQ 200000000
#define FFT_IN_2_HAS_IN 1
#define FFT_IN_2_HAS_OUT 0
#define FFT_IN_2_HAS_TRI 0
#define FFT_IN_2_IRQ -1
#define FFT_IN_2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define FFT_IN_2_IRQ_TYPE "NONE"
#define FFT_IN_2_NAME "/dev/FFT_in_2"
#define FFT_IN_2_RESET_VALUE 0
#define FFT_IN_2_SPAN 16
#define FFT_IN_2_TYPE "altera_avalon_pio"


/*
 * FFT_in_3 configuration
 *
 */

#define ALT_MODULE_CLASS_FFT_in_3 altera_avalon_pio
#define FFT_IN_3_BASE 0x83070
#define FFT_IN_3_BIT_CLEARING_EDGE_REGISTER 0
#define FFT_IN_3_BIT_MODIFYING_OUTPUT_REGISTER 0
#define FFT_IN_3_CAPTURE 0
#define FFT_IN_3_DATA_WIDTH 32
#define FFT_IN_3_DO_TEST_BENCH_WIRING 0
#define FFT_IN_3_DRIVEN_SIM_VALUE 0
#define FFT_IN_3_EDGE_TYPE "NONE"
#define FFT_IN_3_FREQ 200000000
#define FFT_IN_3_HAS_IN 1
#define FFT_IN_3_HAS_OUT 0
#define FFT_IN_3_HAS_TRI 0
#define FFT_IN_3_IRQ -1
#define FFT_IN_3_IRQ_INTERRUPT_CONTROLLER_ID -1
#define FFT_IN_3_IRQ_TYPE "NONE"
#define FFT_IN_3_NAME "/dev/FFT_in_3"
#define FFT_IN_3_RESET_VALUE 0
#define FFT_IN_3_SPAN 16
#define FFT_IN_3_TYPE "altera_avalon_pio"


/*
 * FFT_in_4 configuration
 *
 */

#define ALT_MODULE_CLASS_FFT_in_4 altera_avalon_pio
#define FFT_IN_4_BASE 0x83050
#define FFT_IN_4_BIT_CLEARING_EDGE_REGISTER 0
#define FFT_IN_4_BIT_MODIFYING_OUTPUT_REGISTER 0
#define FFT_IN_4_CAPTURE 0
#define FFT_IN_4_DATA_WIDTH 32
#define FFT_IN_4_DO_TEST_BENCH_WIRING 0
#define FFT_IN_4_DRIVEN_SIM_VALUE 0
#define FFT_IN_4_EDGE_TYPE "NONE"
#define FFT_IN_4_FREQ 200000000
#define FFT_IN_4_HAS_IN 1
#define FFT_IN_4_HAS_OUT 0
#define FFT_IN_4_HAS_TRI 0
#define FFT_IN_4_IRQ -1
#define FFT_IN_4_IRQ_INTERRUPT_CONTROLLER_ID -1
#define FFT_IN_4_IRQ_TYPE "NONE"
#define FFT_IN_4_NAME "/dev/FFT_in_4"
#define FFT_IN_4_RESET_VALUE 0
#define FFT_IN_4_SPAN 16
#define FFT_IN_4_TYPE "altera_avalon_pio"


/*
 * FFT_in_5 configuration
 *
 */

#define ALT_MODULE_CLASS_FFT_in_5 altera_avalon_pio
#define FFT_IN_5_BASE 0x83040
#define FFT_IN_5_BIT_CLEARING_EDGE_REGISTER 0
#define FFT_IN_5_BIT_MODIFYING_OUTPUT_REGISTER 0
#define FFT_IN_5_CAPTURE 0
#define FFT_IN_5_DATA_WIDTH 32
#define FFT_IN_5_DO_TEST_BENCH_WIRING 0
#define FFT_IN_5_DRIVEN_SIM_VALUE 0
#define FFT_IN_5_EDGE_TYPE "NONE"
#define FFT_IN_5_FREQ 200000000
#define FFT_IN_5_HAS_IN 1
#define FFT_IN_5_HAS_OUT 0
#define FFT_IN_5_HAS_TRI 0
#define FFT_IN_5_IRQ -1
#define FFT_IN_5_IRQ_INTERRUPT_CONTROLLER_ID -1
#define FFT_IN_5_IRQ_TYPE "NONE"
#define FFT_IN_5_NAME "/dev/FFT_in_5"
#define FFT_IN_5_RESET_VALUE 0
#define FFT_IN_5_SPAN 16
#define FFT_IN_5_TYPE "altera_avalon_pio"


/*
 * FFT_in_6 configuration
 *
 */

#define ALT_MODULE_CLASS_FFT_in_6 altera_avalon_pio
#define FFT_IN_6_BASE 0x83030
#define FFT_IN_6_BIT_CLEARING_EDGE_REGISTER 0
#define FFT_IN_6_BIT_MODIFYING_OUTPUT_REGISTER 0
#define FFT_IN_6_CAPTURE 0
#define FFT_IN_6_DATA_WIDTH 32
#define FFT_IN_6_DO_TEST_BENCH_WIRING 0
#define FFT_IN_6_DRIVEN_SIM_VALUE 0
#define FFT_IN_6_EDGE_TYPE "NONE"
#define FFT_IN_6_FREQ 200000000
#define FFT_IN_6_HAS_IN 1
#define FFT_IN_6_HAS_OUT 0
#define FFT_IN_6_HAS_TRI 0
#define FFT_IN_6_IRQ -1
#define FFT_IN_6_IRQ_INTERRUPT_CONTROLLER_ID -1
#define FFT_IN_6_IRQ_TYPE "NONE"
#define FFT_IN_6_NAME "/dev/FFT_in_6"
#define FFT_IN_6_RESET_VALUE 0
#define FFT_IN_6_SPAN 16
#define FFT_IN_6_TYPE "altera_avalon_pio"


/*
 * FFT_in_7 configuration
 *
 */

#define ALT_MODULE_CLASS_FFT_in_7 altera_avalon_pio
#define FFT_IN_7_BASE 0x83020
#define FFT_IN_7_BIT_CLEARING_EDGE_REGISTER 0
#define FFT_IN_7_BIT_MODIFYING_OUTPUT_REGISTER 0
#define FFT_IN_7_CAPTURE 0
#define FFT_IN_7_DATA_WIDTH 32
#define FFT_IN_7_DO_TEST_BENCH_WIRING 0
#define FFT_IN_7_DRIVEN_SIM_VALUE 0
#define FFT_IN_7_EDGE_TYPE "NONE"
#define FFT_IN_7_FREQ 200000000
#define FFT_IN_7_HAS_IN 1
#define FFT_IN_7_HAS_OUT 0
#define FFT_IN_7_HAS_TRI 0
#define FFT_IN_7_IRQ -1
#define FFT_IN_7_IRQ_INTERRUPT_CONTROLLER_ID -1
#define FFT_IN_7_IRQ_TYPE "NONE"
#define FFT_IN_7_NAME "/dev/FFT_in_7"
#define FFT_IN_7_RESET_VALUE 0
#define FFT_IN_7_SPAN 16
#define FFT_IN_7_TYPE "altera_avalon_pio"


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
#define ALT_STDERR_BASE 0x83110
#define ALT_STDERR_DEV jtag_uart
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart"
#define ALT_STDIN_BASE 0x83110
#define ALT_STDIN_DEV jtag_uart
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart"
#define ALT_STDOUT_BASE 0x83110
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
#define VGA_CHARACTER_BUFFER_AVALON_CHAR_BUFFER_SLAVE_BASE 0x80000
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
#define VGA_CHARACTER_BUFFER_AVALON_CHAR_CONTROL_SLAVE_BASE 0x83100
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
#define VGA_PIXEL_BUFFER_BASE 0x830e0
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
#define CONTROL_IN_BASE 0x830c0
#define CONTROL_IN_BIT_CLEARING_EDGE_REGISTER 0
#define CONTROL_IN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CONTROL_IN_CAPTURE 0
#define CONTROL_IN_DATA_WIDTH 8
#define CONTROL_IN_DO_TEST_BENCH_WIRING 0
#define CONTROL_IN_DRIVEN_SIM_VALUE 0
#define CONTROL_IN_EDGE_TYPE "NONE"
#define CONTROL_IN_FREQ 200000000
#define CONTROL_IN_HAS_IN 1
#define CONTROL_IN_HAS_OUT 0
#define CONTROL_IN_HAS_TRI 0
#define CONTROL_IN_IRQ -1
#define CONTROL_IN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CONTROL_IN_IRQ_TYPE "NONE"
#define CONTROL_IN_NAME "/dev/control_in"
#define CONTROL_IN_RESET_VALUE 0
#define CONTROL_IN_SPAN 16
#define CONTROL_IN_TYPE "altera_avalon_pio"


/*
 * control_out configuration
 *
 */

#define ALT_MODULE_CLASS_control_out altera_avalon_pio
#define CONTROL_OUT_BASE 0x830b0
#define CONTROL_OUT_BIT_CLEARING_EDGE_REGISTER 0
#define CONTROL_OUT_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CONTROL_OUT_CAPTURE 0
#define CONTROL_OUT_DATA_WIDTH 8
#define CONTROL_OUT_DO_TEST_BENCH_WIRING 0
#define CONTROL_OUT_DRIVEN_SIM_VALUE 0
#define CONTROL_OUT_EDGE_TYPE "NONE"
#define CONTROL_OUT_FREQ 200000000
#define CONTROL_OUT_HAS_IN 0
#define CONTROL_OUT_HAS_OUT 1
#define CONTROL_OUT_HAS_TRI 0
#define CONTROL_OUT_IRQ -1
#define CONTROL_OUT_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CONTROL_OUT_IRQ_TYPE "NONE"
#define CONTROL_OUT_NAME "/dev/control_out"
#define CONTROL_OUT_RESET_VALUE 0
#define CONTROL_OUT_SPAN 16
#define CONTROL_OUT_TYPE "altera_avalon_pio"


/*
 * green_led_pio configuration
 *
 */

#define ALT_MODULE_CLASS_green_led_pio altera_avalon_pio
#define GREEN_LED_PIO_BASE 0x830d0
#define GREEN_LED_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define GREEN_LED_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define GREEN_LED_PIO_CAPTURE 0
#define GREEN_LED_PIO_DATA_WIDTH 9
#define GREEN_LED_PIO_DO_TEST_BENCH_WIRING 0
#define GREEN_LED_PIO_DRIVEN_SIM_VALUE 0
#define GREEN_LED_PIO_EDGE_TYPE "NONE"
#define GREEN_LED_PIO_FREQ 200000000
#define GREEN_LED_PIO_HAS_IN 0
#define GREEN_LED_PIO_HAS_OUT 1
#define GREEN_LED_PIO_HAS_TRI 0
#define GREEN_LED_PIO_IRQ -1
#define GREEN_LED_PIO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define GREEN_LED_PIO_IRQ_TYPE "NONE"
#define GREEN_LED_PIO_NAME "/dev/green_led_pio"
#define GREEN_LED_PIO_RESET_VALUE 0
#define GREEN_LED_PIO_SPAN 16
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
#define JTAG_UART_BASE 0x83110
#define JTAG_UART_IRQ 16
#define JTAG_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_NAME "/dev/jtag_uart"
#define JTAG_UART_READ_DEPTH 64
#define JTAG_UART_READ_THRESHOLD 8
#define JTAG_UART_SPAN 8
#define JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_WRITE_DEPTH 64
#define JTAG_UART_WRITE_THRESHOLD 8


/*
 * red_led_pio configuration
 *
 */

#define ALT_MODULE_CLASS_red_led_pio altera_avalon_pio
#define RED_LED_PIO_BASE 0x830f0
#define RED_LED_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define RED_LED_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define RED_LED_PIO_CAPTURE 0
#define RED_LED_PIO_DATA_WIDTH 18
#define RED_LED_PIO_DO_TEST_BENCH_WIRING 0
#define RED_LED_PIO_DRIVEN_SIM_VALUE 0
#define RED_LED_PIO_EDGE_TYPE "NONE"
#define RED_LED_PIO_FREQ 200000000
#define RED_LED_PIO_HAS_IN 0
#define RED_LED_PIO_HAS_OUT 1
#define RED_LED_PIO_HAS_TRI 0
#define RED_LED_PIO_IRQ -1
#define RED_LED_PIO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RED_LED_PIO_IRQ_TYPE "NONE"
#define RED_LED_PIO_NAME "/dev/red_led_pio"
#define RED_LED_PIO_RESET_VALUE 0
#define RED_LED_PIO_SPAN 16
#define RED_LED_PIO_TYPE "altera_avalon_pio"


/*
 * rotary_in configuration
 *
 */

#define ALT_MODULE_CLASS_rotary_in altera_avalon_pio
#define ROTARY_IN_BASE 0x83060
#define ROTARY_IN_BIT_CLEARING_EDGE_REGISTER 0
#define ROTARY_IN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define ROTARY_IN_CAPTURE 0
#define ROTARY_IN_DATA_WIDTH 8
#define ROTARY_IN_DO_TEST_BENCH_WIRING 0
#define ROTARY_IN_DRIVEN_SIM_VALUE 0
#define ROTARY_IN_EDGE_TYPE "NONE"
#define ROTARY_IN_FREQ 200000000
#define ROTARY_IN_HAS_IN 1
#define ROTARY_IN_HAS_OUT 0
#define ROTARY_IN_HAS_TRI 0
#define ROTARY_IN_IRQ -1
#define ROTARY_IN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ROTARY_IN_IRQ_TYPE "NONE"
#define ROTARY_IN_NAME "/dev/rotary_in"
#define ROTARY_IN_RESET_VALUE 0
#define ROTARY_IN_SPAN 16
#define ROTARY_IN_TYPE "altera_avalon_pio"


/*
 * sys_clk_timer configuration
 *
 */

#define ALT_MODULE_CLASS_sys_clk_timer altera_avalon_timer
#define SYS_CLK_TIMER_ALWAYS_RUN 0
#define SYS_CLK_TIMER_BASE 0x83000
#define SYS_CLK_TIMER_COUNTER_SIZE 32
#define SYS_CLK_TIMER_FIXED_PERIOD 0
#define SYS_CLK_TIMER_FREQ 200000000
#define SYS_CLK_TIMER_IRQ 1
#define SYS_CLK_TIMER_IRQ_INTERRUPT_CONTROLLER_ID 0
#define SYS_CLK_TIMER_LOAD_VALUE 199999
#define SYS_CLK_TIMER_MULT 0.0010
#define SYS_CLK_TIMER_NAME "/dev/sys_clk_timer"
#define SYS_CLK_TIMER_PERIOD 1
#define SYS_CLK_TIMER_PERIOD_UNITS "ms"
#define SYS_CLK_TIMER_RESET_OUTPUT 0
#define SYS_CLK_TIMER_SNAPSHOT 1
#define SYS_CLK_TIMER_SPAN 32
#define SYS_CLK_TIMER_TICKS_PER_SEC 1000.0
#define SYS_CLK_TIMER_TIMEOUT_PULSE_OUTPUT 0
#define SYS_CLK_TIMER_TYPE "altera_avalon_timer"


/*
 * sysid configuration
 *
 */

#define ALT_MODULE_CLASS_sysid altera_avalon_sysid_qsys
#define SYSID_BASE 0x83108
#define SYSID_ID 0
#define SYSID_IRQ -1
#define SYSID_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_NAME "/dev/sysid"
#define SYSID_SPAN 8
#define SYSID_TIMESTAMP 1391342627
#define SYSID_TYPE "altera_avalon_sysid_qsys"

#endif /* __SYSTEM_H_ */
