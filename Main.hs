import Html

main:: IO()
main = writeFile "index.html" (render myhtml)

code_example = "def testFunc: \n\
\ print('Hello from python') \n\
\ return None"


myhtml :: Html
myhtml = html_ 
  "Haskell HTML Render (^///^)"
  (append_ 
    [
      (h1_ "Haskell HTML Render (^///^)"),
      (append_ 
        [
          (p_ "Example "),
          (link_ "Book about it" "https://learn-haskell.blog/02-hello.html"),
          (p_ "I broke lists with added styles :-D"),
          (code_ code_example)
        ]
      )
    ]
  )

