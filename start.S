.syntax unified
.cpu cortex-m4
.thumb

// Глобальні мітки
.global vtable
.global __hard_reset__

// bootload знаходиться у файлі bootloader.S
.extern bootload

.type vtable, %object
.type __hard_reset__, %function

// Секція таблиці переривань
.section .interrupt_vector,"a",%progbits

// Векторна таблиця
vtable:
    .word __stack_start
    .word __hard_reset__+1
    .size vtable, .-vtable

// Секція коду
.section .text

// Точка старту програми
__hard_reset__:
    // Ініціалізація stack pointer
    ldr r0, =__stack_start
    mov sp, r0

    // Запуск bootloader
    bl bootload

// Нескінченний цикл після завершення
_loop:
    b _loop

.size __hard_reset__, .-__hard_reset__
