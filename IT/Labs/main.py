def tsk_14():
    A, B, C = input().split()
    print("Код Символа", A, 'равен', ord(A))
    print("Код Символа", B, 'равен', ord(B))
    print("Код Символа", C, 'равен', ord(C))


def tsk_13():
    print(input() * 3)


def tsk_11():
    a1, a2, a3 = map(int, input().split())

    rez1 = a1 ** 2 - (a2 ** 2 + a3 ** 2)
    rez2 = a3 ** 2 - (a2 ** 2 + a1 ** 2)
    rez3 = a2 ** 2 - (a1 ** 2 + a3 ** 2)
    print(not (rez1 and rez2 and rez3))


def tsk_10():
    a = int(input())
    print(a > 9 and a < 100)


def tsk_9():
    print(input(), end=' - Сказала Она!')


def tsk_8():
    a1 = input()
    a2 = input()
    a3 = input()
    print(a1, a2, a3, sep="---", end='\n')


def tsk_7():
    print(*input().split(), sep=',', end='\n')


def tsk_6():
    x1 = float(input())
    x2 = float(input())
    print(abs(x1 - x2))


def tsk_5():
    X, Y, Z = map(int, input().split())
    print(X * 3 + (3 + 2) * Y + (3 + 2 + 7) * Z)


def tsk_4():
    number = float(input())
    print(round(number, 2), round(number, 3))


def tsk_3():
    age = int(input())
    print(age + 1)


def tsk_2():
    f = int(input())
    c = ((f - 32) * 5) / 9
    print(c)


def main():
    tsk_11()

if __name__ == '__main__':
    main()
