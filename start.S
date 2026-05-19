.syntax unified
.cpu cortex-m4
.thumb

// Оголошення глобальних міток
.global vtable
.global __hard_reset__

/*
 * Таблиця векторів виключень.
 * Перший елемент - початкова адреса стеку.
 * Другий елемент - адреса обробника скидання.
 */
.type vtable, %object
.type __hard_reset__, %function

vtable:
    .word __stack_start
    .word __hard_reset__+1
    .size vtable, .-vtable

/*
 * Обробник скидання.
 * Саме з нього починається виконання програми.
 */
__hard_reset__:
    // Ініціалізуємо стек
    ldr r0, =__stack_start
    mov sp, r0

    // Викликаємо основну функцію лабораторної роботи
    bl lab1

_loop:
    // Нескінченний цикл після завершення lab1
    b _loop

.size __hard_reset__, .-__hard_reset__
