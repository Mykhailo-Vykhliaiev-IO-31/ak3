.syntax unified
.cpu cortex-m4
.thumb

// Глобальні процедури для виводу
.global dbgput
.global dbgput_line

#define SYS_WRITE0 #0x04

.section .rodata

// Новий рядок
nl:
    .asciz "\n"

.section .text

/*
 * dbgput
 * Виводить рядок через semihosting.
 * На вході:
 * r0 - адреса рядка.
 */
dbgput:
    push {lr}

    // r1 = адреса рядка
    mov r1, r0

    // r0 = код операції SYS_WRITE0
    mov r0, SYS_WRITE0

    // Semihosting-виклик
    bkpt #0xAB

    pop {pc}

/*
 * dbgput_line
 * Виводить рядок і переводить курсор на новий рядок.
 */
dbgput_line:
    push {lr}

    // Вивід основного рядка
    bl dbgput

    // Вивід символу нового рядка
    ldr r0, =nl
    bl dbgput

    pop {pc}
