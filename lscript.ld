MEMORY
{
    FLASH (rx)  : ORIGIN = 0x08000000, LENGTH = 1M
    RAM   (rwx) : ORIGIN = 0x20000000, LENGTH = 128K
}

__stack_start = ORIGIN(RAM) + LENGTH(RAM);

SECTIONS
{
    .interrupt_vector :
    {
        KEEP(*(.interrupt_vector))
    } > FLASH

    .text :
    {
        *(.text*)
        *(.rodata*)
    } > FLASH

    .bss :
    {
        *(.bss*)
        *(COMMON)
    } > RAM
}
