def task30(name, year):
    f"{name}, вам исполнится 77 лет в {year}"


def task29(name, age):
    return f"Hello {name}. You are {age} years old"


def task28(number):
    return "Для числа {} следующим будет число {}, предыдущим числом будет {}".format(number, number - 1, number + 1)


def task27(name, sername):
    return "Здравствуйте, {sername} {name}!".format(sername=sername, name=name)


def task26():
    print('_ /~~~\\')
    print(' //^ ^\\\\')
    print('(/(_*_)\\)')
    print("_/''*''\\_")
    print("(/_)^(_\\))")


def task25(string):
    string_list = list(string)
    while 'z' in string_list or 'w' in string_list:
        string_list.remove('w')
        string_list.remove('z')
    return ''.join(string_list)


def task24(string):
    return string.replace(' ', ',')


def task19(string):
    string_split = string.split()
    new_string = []
    for i in range(len(string_split)):
        new_string.append(task18(string_split[i].capitalize()))
    return ' '.join(new_string)


def task18(string):
    string_list = list(string)
    for i in range(len(string_list)):
        if string_list[i].islower():
            string_list[i] = string_list[i].upper()
        else:
            string_list[i] = string_list[i].lower()
    return ''.join(string_list)


def task17(string):
    return string.lower()


def task16(string):
    return string.upper()


def task15(string):
    return string[::-1]


def task14(string):
    return string[1::2]


def task13(string):
    return string[::2]


def task12(string):
    return string[-4:]


def task11(string):
    return string[:3]


def task5(string):
    return string[0]


def task4(string):
    return string[-1]


def main():
    string = "wwww"
    print(task28(int(input())))


if __name__ == '__main__':
    main()
