module Main where

render col (rows, cols, []) = do putStr "\n\n"
render col (rows, cols, (x:xs)) = do
  let column = if col == cols then 0 else col  
  putStr (if column == 0 then "\n" ++ x else x)
  render (column + 1) (rows, cols, xs)

coords input = map (\x -> (read x::Int)) (tail (words input))
create image input = let (x:y:_) = coords input in ready (x, y, take (x * y) (repeat "0"))

color_coord (cols, rows, image) input = do
  let (x:y:_) = coords input
  let (command:_) = words input
  let (color) = last input
  let index = x + (y * cols)
  ready (cols, rows, concat [take index image, [[color]], drop (index + 1) image])

commands = [("I", create), ("L",color_coord)]

ready image = do
  putStrLn "Enter a command:"
  input <- getLine
  if input == "S"
    then render 0 image
      else let (command:_) = filter (\x -> fst x == head (words input)) commands in (snd command) image input
  ready image

main = do
  ready (0,0,[])
  return ()
