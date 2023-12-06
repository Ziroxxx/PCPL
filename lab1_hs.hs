module Main where

import System.Environment (getArgs)

-- Функция, находящая корни биквадратного уравнения
solveBiQuadratic :: (Ord a, Floating a, RealFloat a) => a -> a -> a -> [a]
solveBiQuadratic a b c
    | x1 == 0 = filter (not.isNaN) [sqrt x1, sqrt x2, -sqrt x2]
    | x2 == 0 = filter (not.isNaN) [sqrt x1, -sqrt x1, sqrt x2]
    | discriminant >= 0 = filter (not.isNaN) [sqrt x1, -sqrt x1, sqrt x2, -sqrt x2]
    | otherwise = []
  where
    discriminant = b * b - 4 * a * c
    x1 = (-b + sqrt discriminant) / (2 * a)
    x2 = (-b - sqrt discriminant) / (2 * a)

-- Функция для чтения коэффициентов как с клавиатуры, так и через аргументы командной строки
readCoefficients :: IO (Double, Double, Double)
readCoefficients = do
    args <- getArgs
    case args of
        [a, b, c] -> return (read a, read b, read c)
        _ -> do
            putStrLn "Введите значение a:"
            a <- readLn
            putStrLn "Введите значение b:"
            b <- readLn
            putStrLn "Введите значение c:"
            c <- readLn
            return (a, b, c)

main :: IO ()
main = do
    (a, b, c) <- readCoefficients

    let roots = solveBiQuadratic a b c
    if null roots
        then putStrLn "Уравнение имеет комплексные корни или нет действительных корней"
        else do
            putStrLn "Корни биквадратного уравнения:"
            mapM_ print roots
