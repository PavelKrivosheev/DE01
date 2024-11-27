#1 Напишите код, который пытается преобразовать введённое пользователем значение в число.
# Обработайте исключение ValueError, если пользователь введёт строку, не являющуюся числом.

x = input('Enter value ')
try:
    y = int(x)
except ValueError as m:
    print(f'Exception is : {m}')
else:
    print('Success')

#2 Напишите программу, которая обрабатывает ввод целого числа пользователем. Если ввод
# некорректен (например, буквы), программа должна вывести сообщение об ошибке.

x = input('Введите число ')
try:
    y = int(x)
except ValueError:
    print('Ошибка. Введите целое число')
else:
    print(f'Вы ввели число - {y}')

#3 Напишите программу, которая просит пользователя ввести индекс элемента в списке и
# выводит этот элемент. Обработайте исключение IndexError на случай ввода
#недопустимого индекса.

myList = []
x = int(input('Введите кол-во '))
for i in range(x):
    myList.append(int(input(f'Введите элемент {i+1} ')))

try:
    n = int(input('Введите номер элемента '))
    n = n - 1
    if (n >= 0) and (n <= len(myList)):
        print('Искомое значение: ', myList[n])
    else:
        print('Номер элемента не может быть отрицательным')
except IndexError:
    print('Элемента с таким индексом не существует')

#4 Напишите функцию, которая принимает список чисел и возвращает их среднее значение.
# Обработайте исключение ZeroDivisionError, если список пустой.

myList = []
def myFunc(data):
    x = int(input('Введите количество элементов '))
    for i in range(x):
        data.append(int(input(f'Введите элемент {i+1} ')))
    return f'Average val = {sum(data)/len(data)}'
try:
    print(myFunc(myList))
except ValueError:
    print('Ошибка. Введите число')
except ZeroDivisionError:
    print('Ошибка. Ведите число больше 0')

#5 Напишите код, который использует try-except-else-finally, чтобы обработать
# ошибку деления на ноль и вывести сообщение после завершения блока try.

myStr = '0123'
x = int(input('Введите делитель '))
try:
    myFile = open('../.venv/Practice.txt', 'w+')
    for i in myStr:
        print(i, file=myFile)
    myFile.seek(0)
    for i in myFile:
        i = int(i)
        n = i // x
        print(n, end=',')
except ZeroDivisionError:
    print('Ошибка.Деление на ноль')
else:
    print(f'\nОперация завершена')
finally:
    myFile.close()
    print(f'File close: True/None\n{myFile.closed}')

#6 Напишите программу, которая запрашивает у пользователя два числа и выполняет деление.
# Если ввод не является числом или деление на ноль, программа должна обрабатывать эти
# исключения и продолжать запрашивать ввод до тех пор, пока не будут введены корректные
#значения.


while True:
    a = input('Введите первое число ')
    try:
        a = int(a)
        break
    except ValueError:
        print('Неверное значение. Введите пожалуйста число')
while True:
    b = input('Введите второе число ')
    try:
        b = int(b)
        n = a/b
        print('Answer -', n)
        break
    except ValueError:
        print('Неверное значение. Введите пожалуйста число')
    except ZeroDivisionError:
        print('Ошибка. На 0 делить нельзя.')

# Вариант 2
# while True:
#     a = input('Введите первое число ')
#     b = input('Введите второе число ')
#     try:
#         a = int(a)
#         b = int(b)
#         n = a / b
#         print('Answer -', n)
#         break
#     except ValueError:
#         print('Неверное значение. Введите пожалуйста число')
#     except ZeroDivisionError:
#         print('Ошибка. На 0 делить нельзя.')

#7 Напишите функцию, которая принимает список и индекс. Если индекс выходит за пределы
# списка, функция должна выбрасывать пользовательское исключение и обрабатывать его в
# основной программе.

class myExcep(Exception): # Создание своего исключения
    pass # Обозначает, что мы не хотим передавать свойства методы базового класса, а только наследовать от него
def myFunc(list, index):
    if index >= len(list):
        raise myExcep('Не существует элемента с таким индексом')
    if index < 0:
       raise myExcep('Не существует элемента с таким индексом')

myList = [1,2,3]
try:
    n = int(input('Введите индекс '))
    myFunc(myList,n)
except myExcep as m:
    print(m)
else:
    print('Элемент с таким индексом существует')


#8 Напишите программу, которая обрабатывает несколько возможных исключений:
#ValueError, ZeroDivisionError и IndexError. Программа должна просить
#пользователя ввести список чисел и индекс, по которому будет выполнено деление элемента
#списка на введённое число.

#Вариант 1
myList = []
x = input('Введите количество элементов в списке ')
try:
    x = int(x)
    n = x/x
    for i in range(x):
        if i == int(i):
            myList.append(int(input(f'Введите {i+1}-й - ')))
    try:
        n = int(input('Введите индекс '))
        index = n - 1
        div = myList[index] / n
        print('Результат программы - ', div)
    except IndexError:
        print('Индекс не определен')
    except ZeroDivisionError:
        print('Ошибка деления на 0')
except ValueError:
    print('Введите целое число')
except ZeroDivisionError:
    print('Введите значение больше 0')


#Вариант2
# myList = []
# x = input('Введите количество элементов в списке ')
# try:
#     x = int(x)
#     n = x/x
# except ValueError:
#     print('Введите целое число')
# except ZeroDivisionError:
#     print('Введите число больше 0')
# else:
#     try:
#         for i in range(x):
#             if i == int(i):
#                 myList.append(int(input(f'Введите {i+1}-й - ')))
#     except ValueError:
#         print('Введите целое число')
#     else:
#         try:
#             n = int(input('Введите индекс '))
#             index = n - 1
#             div = myList[index] / n
#             print('Результат программы - ', div)
#         except IndexError:
#             print('Индекс не определен')
#         except ZeroDivisionError:
#             print('Ошибка деления на 0')

