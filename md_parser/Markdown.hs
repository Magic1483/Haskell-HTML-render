-- module Markup (
--     Document,
--     Structure(..)
-- )
-- where

-- https://learn-haskell.blog/04-markup/02-parsing_01.html
-- 04

import Numeric.Natural
import Data.Maybe

type Document
    = [Structure]

data Structure
    = Heading           Natural String
    | Paragraph         String
    | UnorderedList     [String]
    | OrderedList       [String]
    | CodeBlock         [String]
    deriving Show


-- maybe work as wrapper (Rust result for example )
-- maybe defaultValue function maybeValue
-- maybe "default" show (Just 11) -> 11
-- maybe "default" show Nothing   -> "default"

parse :: String -> Document
parse = parseLines Nothing . lines

parseLines :: Maybe Structure -> [String] -> Document
parseLines context txts = 
  case txts of 
    [] -> maybeToList context
    -- rest is remaining of txts
    currentLine : rest ->
      let 
        line = trim currentLine
      in
        if line == ""              
          then
            (maybe id (:) context) (parseLines Nothing rest)
          else
            case context of
              Just (Paragraph p) 
                -> parseLines (Just (Paragraph (unwords [p, line]))) rest
              _ -> maybe id (:) context (parseLines (Just (Paragraph line)) rest)

trim :: String -> String
trim = unwords . words

main:: IO()
main = putStrLn "hi looser"


