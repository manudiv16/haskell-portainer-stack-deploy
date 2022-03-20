module Lib
    ( argloop
    ) where

import Data.Char ( ord, chr )
import Data.List

argloop :: [String] -> IO ()
argloop [] =
    putStrLn ""
argloop (x:xs) =
    do
    putStr $ caesarcode x
    putStr " "
    argloop xs


caesarcode :: [Char] -> [Char]
caesarcode = (<$>) caesarMod 



caesarMod :: Char -> Char
caesarMod  = chr . (+) 4 . ord 

