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

render col (Image x y d) = do
  foldr (++) "\n\n" d

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
