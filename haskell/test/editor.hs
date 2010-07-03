module Main where

ready image = do
  putStrLn "Enter a command:"
  input <- getLine
  let (command:_) = words input
  case command of
    "I" -> create image input
    "S" -> render (0,image)
  (ready image)

render (col,(rows, cols,[])) = do putStr "\n\n"
render (col,(rows,cols,(x:xs))) = do
  let column = if col == cols then 0 else col  
  putStr (if column == 0 then "\n" ++ x else x)
  render (column + 1,(rows, cols, xs))

create image input = do
  let commands = words input 
  let (command:x:y:_) = commands
  let xn = (read x::Int)
  let yn = (read x::Int)
  let d = take ((read x::Int) * (read y::Int)) (repeat "0")
  putStrLn ("Created a new image of dimensions " ++ x ++ " by " ++ y)
  ready (xn, yn, d)
  
main = do
  (ready (0,0,[]))
