/*
 * main.c
 * Лабораторна робота 4.1
 * STM32CubeIDE + QEMU
 *
 * Завдання:
 * налаштувати пін PD15 як вихід і реалізувати блимання синім світлодіодом
 * на платі STM32F4-Discovery.
 *
 * PD15 - синій світлодіод.
 */

#include <stdint.h>

/*
 * Базові адреси периферії STM32F407VG
 */
#define RCC_BASE        0x40023800UL
#define GPIOD_BASE      0x40020C00UL

/*
 * Регістри RCC
 */
#define RCC_AHB1ENR     (*(volatile uint32_t *)(RCC_BASE + 0x30))

/*
 * Регістри GPIOD
 */
#define GPIOD_MODER     (*(volatile uint32_t *)(GPIOD_BASE + 0x00))
#define GPIOD_OTYPER    (*(volatile uint32_t *)(GPIOD_BASE + 0x04))
#define GPIOD_OSPEEDR   (*(volatile uint32_t *)(GPIOD_BASE + 0x08))
#define GPIOD_PUPDR     (*(volatile uint32_t *)(GPIOD_BASE + 0x0C))
#define GPIOD_ODR       (*(volatile uint32_t *)(GPIOD_BASE + 0x14))

/*
 * Біти для налаштування GPIOD
 */
#define RCC_AHB1ENR_GPIODEN  (1UL << 3)
#define LED_PIN              15

/*
 * Проста програмна затримка.
 * volatile потрібен, щоб компілятор не оптимізував цикл.
 */
static void delay(volatile uint32_t count)
{
    while (count--)
    {
        __asm volatile ("nop");
    }
}

/*
 * Ініціалізація піна PD15 як GPIO Output.
 */
static void gpio_init(void)
{
    /*
     * Увімкнення тактування порту GPIOD.
     * Без цього регістри GPIOD не працюватимуть.
     */
    RCC_AHB1ENR |= RCC_AHB1ENR_GPIODEN;

    /*
     * Налаштування режиму PD15.
     * Для кожного піна в MODER використовується 2 біти.
     * 00 - input
     * 01 - output
     * 10 - alternate function
     * 11 - analog
     *
     * Для PD15 потрібно встановити 01.
     */
    GPIOD_MODER &= ~(3UL << (LED_PIN * 2));
    GPIOD_MODER |=  (1UL << (LED_PIN * 2));

    /*
     * Output type:
     * 0 - push-pull
     * 1 - open-drain
     */
    GPIOD_OTYPER &= ~(1UL << LED_PIN);

    /*
     * Output speed:
     * 00 - low speed
     */
    GPIOD_OSPEEDR &= ~(3UL << (LED_PIN * 2));

    /*
     * Pull-up / pull-down:
     * 00 - no pull-up, no pull-down
     */
    GPIOD_PUPDR &= ~(3UL << (LED_PIN * 2));
}

int main(void)
{
    /*
     * Налаштовуємо порт GPIOD і пін PD15.
     */
    gpio_init();

    while (1)
    {
        /*
         * Перемикаємо стан PD15.
         * Якщо світлодіод був вимкнений - увімкнеться.
         * Якщо був увімкнений - вимкнеться.
         */
        GPIOD_ODR ^= (1UL << LED_PIN);

        /*
         * Затримка між перемиканнями.
         */
        delay(500000);
    }
}
