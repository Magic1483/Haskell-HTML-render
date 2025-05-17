-- Convert.hs

module Convert where

import qualified Markdown
import qualified Html

convert :: Html.Title -> Markdown.Document -> Html.Html
convert title = Html.html_ title . foldMap convertStructure

convertStructure :: Markdown.Structure -> Html.Structure
convertStructure structure =
  case structure of
    Markdown.Heading n txt ->
      Html.h_ n txt

    Markdown.Paragraph p ->
      Html.p_ p

    Markdown.UnorderedList list ->
      Html.ul_ $ map Html.p_ list

    Markdown.OrderedList list ->
      Html.ol_ $ map Html.p_ list

    Markdown.CodeBlock list ->
      Html.code_ (unlines list)