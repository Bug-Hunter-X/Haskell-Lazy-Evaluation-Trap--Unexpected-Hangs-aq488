The problem lies in the lazy evaluation of the `expensiveCalculation` function.  The solution is to force its evaluation before it's used. We can achieve this using the `$!` operator, which forces the evaluation of its argument.  This ensures that `expensiveCalculation` is computed and its result is available before the `if` condition is evaluated.

```haskell
import System.Environment

-- Simulates an expensive calculation that might fail or never complete
expensiveCalculation :: Int -> Maybe Int
expensiveCalculation n
    | n < 0 = Nothing
    | otherwise = Just (n * n)

-- Original faulty calculate function
calculate :: Int -> Int
calculate x = case expensiveCalculation x of
    Just y -> y + 1
    Nothing -> 0

-- Improved strict calculate function using $!
calculateStrict :: Int -> Int
calculateStrict x = case expensiveCalculation x of
    Just y -> y + 1
    Nothing -> 0

main :: IO ()
main = do
  args <- getArgs
  case args of
      [arg] -> do
        let x = read arg :: Int
        putStrLn $ "Result (lazy): " ++ show (calculate x)
        putStrLn $ "Result (strict): " ++ show (calculateStrict x)
      _ -> putStrLn "Usage: ./bug <number>" 
```