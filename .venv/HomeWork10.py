# 1. Простая функция: Напишите функцию greet, которая принимает одно имя в качестве
# аргумента и выводит строку "Hello, [name]!".

def greet(name):
    #print('HelLo', name)
    print(f'HelLo {name}')
greet(input('Enter name '))

# def greet (name):
#     return f'Hello, {name}'
# print(greet(input('Enter name ')))

#2. Функция сложения: Напишите функцию, которая принимает два числа в качестве
#аргументов и возвращает их разницу.


def sumNum(a,b):
    razn = a - b
    return razn
print('Разность чисел = ', sumNum(int(input('Enter first num ')),int(input('Enter second num '))))

# def razn(a,b):
#     return a - b
# print(razn(int(input('Enter a ')), int(input('Enter b '))))

#sumNum = lambda a,b : a - b
#print(sumNum(int(input()),int(input())))

#3. Функция с дефолтным параметром: Напишите функцию welcome, которая принимает
#два аргумента — имя и сообщение, причем сообщение по умолчанию равно "Welcome!".
#Функция должна выводить сообщение вида: "Welcome, [name]!".


def welcome(name, message = 'Welcome'):
    print(f'{message}, {name}!')
welcome(input('Enter name '))



#4. Функция с несколькими аргументами: Напишите функцию multiply, которая
#принимает любое количество чисел в качестве аргументов и возвращает их произведение.

def multiply(*args):
    result = 1
    for i in args:
        result *= i
    return result
print(multiply(1,3,5,6))

myList = []
def multiply(data):
    count = 1
    x = int(input('Enter count args '))
    for i in range(x):
        myList.append(int(input(f'Enter val {i+1} ')))
    for i in data:
        count *=i
    return count
print('Prod our args = ',multiply(myList))

#5. Функция для деления: Напишите функцию divide, которая принимает два числа и
#возвращает результат их деления. Предположите, что второй аргумент всегда будет
#ненулевым. Примените эту функцию для нескольких пар чисел.

def divide(a,b):
    div = a/b
    return div
print(divide(int(input()),int(input())))
print(divide(int(input()),int(input())))
print(divide(int(input()),int(input())))