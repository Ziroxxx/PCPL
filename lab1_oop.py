import sys
import math

class eq:
   def __init__(self):
       self.a = self.get_coef(1, 'Введите коэффициент А:')
       self.b = self.get_coef(2, 'Введите коэффициент B:')
       self.c = self.get_coef(3, 'Введите коэффициент C:')

   def get_coef(self, index, prompt):
       try:
           # Пробуем прочитать коэффициент из командной строки
           coef_str = sys.argv[index]
       except:
           # Вводим с клавиатуры
           print(prompt)
           coef_str = input()
       # Переводим строку в действительное число
       coef = float(coef_str)
       return coef

   def get_roots(self, a, b, c):
       result_quadro = []
       D = b * b - 4 * a * c
       if D == 0.0:
           root = -b / (2.0 * a)
           result_quadro.append(root)
       elif D > 0.0:
           sqD = math.sqrt(D)
           root1 = (-b + sqD) / (2.0 * a)
           root2 = (-b - sqD) / (2.0 * a)
           result_quadro.append(root1)
           result_quadro.append(root2)
       result = []
       for i in range(0, len(result_quadro)):
           if result_quadro[i] > 0.0:
               result.append(math.sqrt(result_quadro[i]))
               result.append(-1 * math.sqrt(result_quadro[i]))
           elif result_quadro[i] == 0.0:
               result.append(math.sqrt(result_quadro[i]))
       return result

   def printroots(self):
       roots = self.get_roots(self.a, self.b, self.c)
       # Вывод корней
       len_roots = len(roots)
       if len_roots == 0:
           print('Нет корней')
       elif len_roots == 1:
           print('Один корень: {}'.format(roots[0]))
       elif len_roots == 2:
           print('Два корня: {} и {}'.format(roots[0], roots[1]))
       elif len_roots == 3:
           print('Три корня: {}, {} и {}'.format(roots[0], roots[1], roots[2]))
       elif len_roots == 4:
           print('Четыре корня: {}, {}, {} и {}'.format(roots[0], roots[1], roots[2], roots[3]))


def main():
    eq1 = eq()
    eq1.printroots()


if __name__ == "__main__":
    main()