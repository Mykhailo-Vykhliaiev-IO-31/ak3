/*
 * Скрипт лінкера для kernel.
 * Kernel має виконуватися з RAM, починаючи з адреси 0x20000000.
 */

ENTRY(__kernel_reset__)

MEMORY
{
    RAM (rxw) : ORIGIN = 0x20000000, LENGTH = 128K
}

__stack_start = ORIGIN(RAM) + LENGTH(RAM);
_ram_start = ORIGIN(RAM);

SECTIONS
{
    . = ORIGIN(RAM);

    .interrupt_vector :
    {
        KEEP(*(.interrupt_vector))
    } > RAM

    .text :
    {
        *(.text*)
    } > RAM

    .rodata :
    {
        *(.rodata*)
    } > RAM

    .data :
    {
        *(.data*)
    } > RAM

    .bss :
    {
        *(.bss*)
        *(COMMON)
    } > RAM
}
