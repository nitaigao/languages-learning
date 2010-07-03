module Main where

module StringSplit where

import List

split :: String -> String -> [String]
  split tok splitme = unfoldr (sp1 tok) splitme
    where sp1 _ "" = Nothing
      sp1 t s = case find (t `isSuffixOf`) (inits s) of
        Nothing -> Just (s, "")
          Just p -> Just (take ((length p) - (length t)) p,
            drop (length p) s)

main = do
  putStrLn "Whats your name?"
  name <- getLine
  putStrLn ("Hello, " ++ name)
