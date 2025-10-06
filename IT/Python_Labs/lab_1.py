def task23(number):
    return number % 10


def task22(n):
    tens = n // 100
    twens = (n - tens * 100) // 20
    fifs = (n - tens * 100 - twens * 20) // 15
    sixs = (n - tens * 100 - twens * 20 - fifs * 15) // 6
    twos = (n - tens * 100 - twens * 20 - fifs * 15 - sixs * 6) // 2
    return [tens, twens, fifs, sixs, twos]


def task14():
    return 100 / 2 ** 2


def task13():
    return 2 ** 5


def task12():
    return 17 - 45 // 8


def task5():
    string = 'Привет, я маленькая, но уже программа!'
    print(string)


def task4(rubbles, number):
    return rubbles // number


def task3(n):
    return n + ((n % 2) + 1)


def task2(number):
    return number % 10


def main():
   # n = int(input())
    print(task22(137))


if __name__ == '__main__':
    main()
