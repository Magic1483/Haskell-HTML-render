-- module Markup (
--     Document,
--     Structure(..)
-- )
-- where

-- https://learn-haskell.blog/04-markup/02-parsing_01.html
-- 04

module Markdown where

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
    -- Heading 1 
    ('*':' ' : line) : rest -> 
      maybe id (:) context (Heading 1 (trim line) : parseLines Nothing rest)
    
    -- Unordered list
    ('-':' ' : line) : rest -> 
      case context of
        Just (UnorderedList list) -> 
          parseLines (Just (UnorderedList (list <> [trim line]))) rest
        
        _ -> maybe id (:) context (parseLines (Just(UnorderedList [trim line])) rest)
        
    -- Unordered list
    ('#':' ' : line) : rest -> 
      case context of
        Just (OrderedList list) -> 
          parseLines (Just (OrderedList (list <> [trim line]))) rest
        
        _ -> maybe id (:) context (parseLines (Just(OrderedList [trim line])) rest)
    -- Code block
    ('>':' ' : line) : rest -> 
      case context of
        Just (CodeBlock code) -> 
          parseLines (Just (CodeBlock (code <> [trim line]))) rest
        
        _ -> maybe id (:) context (parseLines (Just(CodeBlock [line])) rest)
    
    -- Paragraph
    currentLine : rest -> 
      let line = trim currentLine
      in 
        if line == "" then 
          maybe id (:) context (parseLines Nothing rest)
        else
          case context of
            Just(Paragraph p) -> 
              parseLines (Just (Paragraph (unwords [p,line]))) rest
            _ -> maybe id (:) context (parseLines (Just (Paragraph line)) rest)

    
trim :: String -> String
-- We can represent it as trim s = unwords ( words s )
trim = unwords . words 





