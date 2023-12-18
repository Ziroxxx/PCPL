import unittest
from main import *

class Test(unittest.TestCase):
    def data(self):
        self.prepss = [prep(1, 'Иванов Иван Иванович', 120, 3),
             prep(2, 'Антонов Петр Петрович', 100, 1),
             prep(3, 'Келдыш Елизавета Петровна', 110, 1),
             prep(4, 'Масленников Константин Юрьевич', 5, 2),
             prep(5, 'Афанасьев Геннадий Иванович', 6, 2)]

        self.coursess = [course(1, 'Курс Математический анализ'),
               course(2, 'АСОИУ'),
               course(3, 'Курс Физика'),

               course(11, 'Математический анализ (дополнительный)'),
               course(22, 'Модели данных (дополнительный)'),
               course(33, 'Физика (дополнительный)')]

        self.courses_prepss = [prep_course(1, 3),
                     prep_course(2, 1),
                     prep_course(3, 1),
                     prep_course(4, 2),
                     prep_course(5, 2),

                     prep_course(1, 11),
                     prep_course(2, 22),
                     prep_course(4, 33)]
    def testSolution1(self):
        self.data()
        res = solution1(one_to_many(self.prepss, self.coursess), self.coursess)
        self.assertEqual(res,
        {'Курс Математический анализ': ['Антонов Петр Петрович', 'Келдыш Елизавета Петровна'], 'Курс Физика': ['Иванов Иван Иванович']})

    def testSolution2(self):
        self.data()
        res = solution2(one_to_many(self.prepss, self.coursess), self.coursess)
        self.assertEqual(res,
                          [('АСОИУ', 5.5), ('Курс Математический анализ', 105.0), ('Курс Физика', 120.0)])

    def testSolution3(self):
        self.data()
        res = solution3(many_to_many(self.prepss, self.coursess, self.courses_prepss), self.prepss)
        self.assertEqual(res,
                          {'Антонов Петр Петрович': ['Курс Математический анализ', 'Модели данных (дополнительный)'], 'Афанасьев Геннадий Иванович': ['АСОИУ']})



if __name__ == '__main__':
    unittest.main()
