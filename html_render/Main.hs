import Html

main:: IO()
main = writeFile "index.html" (render myhtml)

code_example = "def testFunc: \n\
\ print('Hello from python') \n\
\ return None"


myhtml :: Html
myhtml = html_ 
  "Haskell HTML Render"
  (append_ 
    [
      (h1_ "Haskell HTML Render"),
      (append_ 
        [
          (p_ "Example "),
          (p_ (getStructureString (link_ "Book about it" "https://learn-haskell.blog/02-hello.html"))),
          (p_ (getStructureString (link_ "Escape Characters in HTML" "https://www.w3.org/TR/html4/charset.html#h-5.3.1"))),
          (h1_ "Links to WebRTC sources"),
          
          (p_ (getStructureString (link_ "WebRTC docs" "https://webrtc.github.io/samples/"))),
          (p_ (getStructureString (link_ "example with video" "https://github.com/cjb/serverless-webrtc/tree/master"))),
          (p_ (getStructureString (link_ "https://jameshfisher.com/2017/01/16/tiny-serverless-webrtc/" "https://jameshfisher.com/2017/01/16/tiny-serverless-webrtc/"))),

          (p_ "I broke lists with added styles "),
          (code_ code_example)
        ]
      )
    ]
  )

