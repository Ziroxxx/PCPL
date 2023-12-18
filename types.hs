module Main where

import System.Environment (getArgs)
import Control.Exception

--АДТ Отвечающий за кол-во корней уравнения
data Roots = NoRoots
           | OneRoot Double
           | TwoRoots Double Double
           | ThreeRoots Double Double Double
           | FourRoots Double Double Double Double

numberOfRoots :: Roots -> String
numberOfRoots NoRoots = "Нет корней или уравнение не является биквадратным!"
numberOfRoots (OneRoot x1) =  "Один корень: " ++ show x1
numberOfRoots (TwoRoots x1 x2) = "Два корня: " ++ show x1 ++ ", " ++ show x2
numberOfRoots (ThreeRoots x1 x2 x3) = "Три корня: " ++ show x1 ++ ", " ++ show x2 ++ ", " ++ show x3
numberOfRoots (FourRoots  x1 x2 x3 x4) = "Четыре корня: " ++ show x1 ++ ", " ++ show x2 ++ ", " ++ show x3 ++ ", " ++ show x4

solve :: (Double, Double, Double) -> Roots
solve (a, b, c)
    | discr < 0 || discr == 0 && x < 0 || a == 0 = NoRoots
    | discr == 0 && x == 0 = OneRoot 0
    | discr == 0 && x > 0 = TwoRoots (sqrt x) ((-1) * sqrt x)
    | x1 > 0 && x2 < 0 = TwoRoots (sqrt x1) ((-1) * sqrt x1)
    | x1 < 0 && x2 > 0 = TwoRoots (sqrt x2) ((-1) * sqrt x2)
    | x1 > 0 && x2 == 0 = ThreeRoots (sqrt x1) ((-1) * sqrt x1) 0
    | x1 == 0 && x2 > 0 = ThreeRoots (sqrt x2) ((-1) * sqrt x2) 0
    | x1 > 0 && x2 > 0 = FourRoots (sqrt x1) ((-1) * sqrt x1) (sqrt x2) ((-1) * sqrt x2)
    where
        discr = b ^ 2 - 4 * a * c
        x = (-b) / (2 * a)
        x1 = (-b + sqrt discr) / (2 * a)
        x2 = (-b - sqrt discr) / (2 * a)

-- Функция для безопасного считывания коэффициентов из строки
readSafe :: Read a => IO a
readSafe = do
    input <- getLine
    case reads input of
        [(value, "")] -> return value
        _ -> putStrLn "Ошибка: Некорректный ввод. Попробуйте снова." >> readSafe

readCoefficients :: IO (Double, Double, Double)
readCoefficients = do
    args <- getArgs
    case args of
        [a, b, c] -> return (read a, read b, read c)
        _ -> do
            putStrLn "Введите значение a:"
            a <- readSafe `catch` (\(ex :: SomeException) -> print ex >> readSafe)
            putStrLn "Введите значение b:"
            b <- readSafe `catch` (\(ex :: SomeException) -> print ex >> readSafe)
            putStrLn "Введите значение c:"
            c <- readSafe `catch` (\(ex :: SomeException) -> print ex >> readSafe)
            return (a, b, c)

main :: IO ()
main = do
    (a, b, c) <- readCoefficients
    putStr $ numberOfRoots $ solve (a, b, c)

