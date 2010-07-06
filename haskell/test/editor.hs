module Main where

render col (rows, cols, []) = do putStr "\n\n"
render col (rows, cols, (x:xs)) = do
  let column = if col == cols then 0 else col  
  putStr (if column == 0 then "\n" ++ x else x)
  render (column + 1) (rows, cols, xs)

coords input = map (\x -> (read x::Int)) (tail (words input))
create image input = let (x:y:_) = coords input in (x, y, take (x * y) (repeat "0"))

color_coord (cols, rows, image) input = do
  let (x:y:_) = coords input
  let (command:_) = words input
  let (color) = last input
  let index = x + (y * cols)
  (cols, rows, concat [take index image, [[color]], drop (index + 1) image])

commands = [("I", create), ("L",color_coord)]

ready image = do
  putStrLn "Enter a command:"
  input <- getLine
  let (command:_) = filter (\x -> fst x == head (words input)) commands
  let image' = (snd command) image input
  if input == "S" 
    then render 0 image
    else return () 
  ready image'

main = do
  ready (0,0,[])
  return ()
