module Html
  ( Html,
    Title,
    Structure,
    html_,
    p_,
    h1_,
    ul_,
    append_,
    render,
    code_,
    link_,
    getStructureString
  )
where

newtype Html = Html String

newtype Structure = Structure String

type Title = String

-- styles
cs :: String = "style=background-color:rgb(237,231,225);width:fit-content;padding:1rem"
body_style :: String = "style=width:50%;margin:auto;margin-top:10px"
link_style ::String = "width:100%"
-- html PRINTER (⌐■_■)
html_ :: Title -> Structure -> Html
html_ title content =
  Html
    ( el
        "html"
        ( el "head" (el "title" (escape title) "") ""
            <> el "body" (getStructureString content) body_style
        )
        ""
    )

-- Structures
p_ :: String -> Structure
p_ text = Structure (el "p" text "")

link_ :: String -> String -> Structure
link_ text link = Structure ("<a href=" <> link <> " style=" <> link_style <> ">" <> text <> "</a>")

h1_ :: String -> Structure
h1_ text = Structure (el "h1" text "")

ul_ :: [Structure] -> Structure
ul_ = Structure . el "ul" "" . concat . map (el "li" "" . getStructureString)

code_ :: String -> Structure
code_ code = Structure (el "pre" code cs)

-- !

el :: String -> String -> String -> String
el tag content style = "<" <> tag <> " "  <>  style   <> ">" <> content <> "</" <> tag <> ">"

append_ :: [Structure] -> Structure
append_ arr = Structure (concatMap getStructureString arr)

getStructureString :: Structure -> String
getStructureString content =
  case content of
    Structure s -> s

render :: Html -> String
render html =
  case html of
    Html s -> s

escape :: String -> String
escape =
  let escapeChar c =
        case c of
          '<' -> "&lt;"
          '>' -> "&gt;"
          '&' -> "&amp;"
          '"' -> "&quot;"
          '\'' -> "&#39;"
          _ -> [c]
   in concat . map escapeChar