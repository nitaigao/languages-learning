module Main where

draw image input = do
  (render(0, image))

render (col,(rows, cols,[])) = do putStr "\n\n"
render (col,(rows,cols,(x:xs))) = do
  let column = if col == cols then 0 else col  
  putStr (if column == 0 then "\n" ++ x else x)
  render (column + 1,(rows, cols, xs))

create image input = do
  let (x:y:_) = map (\x -> (read x::Int)) (tail (words input))
  let (command:_) = words input
  let d = take (x * y) (repeat "0")
  putStrLn ("Created a new image of dimensions " ++ show x ++ " by " ++ show y)
  ready (x, y, d)

commands = [("I", create), ("S", draw)]

ready image = do
  putStrLn "Enter a command:"
  input <- getLine
  let (command:_) = filter (\x -> fst x == head (words input)) commands in (snd command) image input
  (ready image)

main = do
  (ready (0,0,[]))
