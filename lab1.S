.global lab1
.syntax unified
.thumb

/*
 * Лабораторна робота №2
 * Варіант 4
 *
 * Функція:
 * якщо a*b >= 10:
 *     result = (a | b) * c
 * якщо a*b < 10:
 *     result = (a*b) * c
 *
 * Для демонстрації в GDB:
 * a = 4
 * b = 3
 * c = 5
 *
 * a*b = 4*3 = 12
 * 12 >= 10, тому використовується перша гілка:
 * a | b = 4 | 3 = 7
 * result = 7 * 5 = 35
 *
 * Очікуваний результат:
 * r0 = 35
 */

#define A #4
#define B #3
#define C #5

lab1:
    // Зберігаємо адресу повернення
    push {lr}

    // Завантажуємо значення a, b, c у регістри
    mov r0, A          // r0 = a
    mov r1, B          // r1 = b
    mov r2, C          // r2 = c

    // Обчислюємо a*b
    mul r3, r0, r1     // r3 = a*b

    // Порівнюємо a*b з 10
    cmp r3, #10

    // Якщо a*b >= 10, переходимо до першої гілки
    bge greater_or_equal

less_than:
    /*
     * Гілка для випадку a*b < 10
     * result = (a*b) * c
     */
    mul r0, r3, r2     // r0 = (a*b)*c
    b done

greater_or_equal:
    /*
     * Гілка для випадку a*b >= 10
     * result = (a | b) * c
     */
    orr r4, r0, r1     // r4 = a | b
    mul r0, r4, r2     // r0 = (a | b)*c

done:
    // Повертаємося у start.S
    pop {pc}
