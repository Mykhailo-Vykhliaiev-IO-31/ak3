.syntax unified
.cpu cortex-m4
.thumb

/*
 * bootloader.S
 * Варіант 0:
 * LDR, STR
 * інкремент адреси
 * числовий зсув 4 байти
 */

.global bootload

.extern kernel_main
.extern dbgput_line

.section .rodata

bootmsg:
    .asciz "bootloader started"

.section .text

bootload:
    push {lr}

    // Вивід повідомлення bootloader
    ldr r0, =bootmsg
    bl dbgput_line

    /*
     * Демонстрація роботи з пам'яттю для варіанту 0:
     * LDR, STR
     * інкремент адреси
     * числовий зсув 4 байти
     */

    // r1 - значення, яке будемо записувати в пам'ять
    mov r1, #77

    // r6 - адреса початку області пам'яті
    ldr r6, =mem_area

    // r7 - окремий регістр з тією ж адресою для читання
    ldr r7, =mem_area

    // STR з пост-інкрементом на 4 байти
    // записує r1 у пам'ять за адресою r6, після чого r6 = r6 + 4
    str r1, [r6], #4

    // LDR з пост-інкрементом на 4 байти
    // читає значення з пам'яті за адресою r7, після чого r7 = r7 + 4
    ldr r2, [r7], #4

    // Запуск основної програми kernel
    bl kernel_main

    pop {pc}

// Оперативна пам'ять для перевірки LDR/STR
.section .bss
.align 2
mem_area:
    .space 16
