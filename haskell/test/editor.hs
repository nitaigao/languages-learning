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
    
columnize :: Int -> Int -> [Char] -> String
columnize col cols (x:xs) = do
  let new_col = if col == cols - 1 then 0 else col + 1
  let text = if col == cols - 1 then [x] ++ "\n" else [x]
  text ++ (columnize new_col cols xs)
  
columnize _ _ [] = "" 

render (Image x y d) = do
  let output = foldl (++) "" d
  columnize 0 x output

pixel input (Image x y d) = do
  let (cx:cy:_) = coords input
  let (command:_) = words input
  let (color) = last input : []
  let index = cx + (cy * x)
  Image x y (concat [(take index d), [color], (drop (index + 1) d)])

ready image = do 
  putStrLn "Enter a command: "
  input <- getLine
  let command = head (words input)
  case command of 
    "X" -> quit
    "I" -> do
      ready image' where image' = initialize input image
    "S" -> do
      let text = render image in putStrLn text
      ready image
    "L" -> do
      ready image' where image' = pixel input image
    _   -> do 
      unknown
      ready image

main = do
  let image = Image 0 0 []
  ready image
