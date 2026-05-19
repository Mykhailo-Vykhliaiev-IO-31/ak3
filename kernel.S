.syntax unified
.cpu cortex-m4
.thumb

/*
 * kernel.S
 * Основна програма.
 * Виконує обчислення з лабораторної роботи №2.
 *
 * Варіант ЛР2:
 * якщо a*b >= 10:
 *     result = (a | b) * c
 * якщо a*b < 10:
 *     result = (a*b) * c
 *
 * a = 4
 * b = 3
 * c = 5
 *
 * a*b = 12
 * 12 >= 10
 * a | b = 7
 * result = 7 * 5 = 35
 */

.global kernel_main

.extern dbgput_line

.section .rodata

msg:
    .asciz "kernel started"

resmsg:
    .asciz "result: 35"

.section .text

kernel_main:
    push {lr}

    // Повідомлення про запуск kernel
    ldr r0, =msg
    bl dbgput_line

    // Завантаження значень a, b, c
    mov r0, #4          // r0 = a
    mov r1, #3          // r1 = b
    mov r2, #5          // r2 = c

    // Обчислення a*b
    mul r3, r0, r1      // r3 = a*b = 12

    // Порівняння a*b з 10
    cmp r3, #10

    // Якщо a*b >= 10, перейти до greater_equal
    bge greater_equal

less_than:
    // result = (a*b)*c
    mul r5, r3, r2
    b print_result

greater_equal:
    // result = (a | b)*c
    orr r4, r0, r1      // r4 = a | b = 7
    mul r5, r4, r2      // r5 = 35

print_result:
    // Вивід результату в консоль
    ldr r0, =resmsg
    bl dbgput_line

    pop {pc}
