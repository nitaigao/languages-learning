module Main where

draw words = do
  foldl (++) "" words

data Image = Image Int Int [String]
  deriving (Show)

unknown = putStrLn "Unknown command"
quit = putStrLn "Quitting"

coords input = map (\x -> (read x::Int)) (tail (words input))
initialize input image = do 
  let (x:y:_) = coords input in
    Image x y (take (x * y) (repeat "0"))
    
columnize col cols (x:xs) = do
  let text = if col == 0 then [x] ++ "\n" else [x]
  let new_col = if col == 0 then cols else col - 1
  append text (columnize new_col cols xs)
  
columnize _ _ [] = "\n\n"  

render col (Image x y d) = do
  let output = foldl (++) "" d
  columnize x x output

ready image = do 
  putStrLn "Enter a command: "
  input <- getLine
  let command = head (words input)
  case command of 
    "X" -> quit
    "I" -> do
      ready image' where image' = initialize input image
    "S" -> do
      let text = render 0 image in putStrLn text
      ready image
    _   -> do 
      unknown
      ready image

main = do
  let image = Image 0 0 []
  ready image
