module Main where

main = do
  putStrLn "Whats your name?"
  name <- getLine
  putStrLn ("Hello, " ++ name)
