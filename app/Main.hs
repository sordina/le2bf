module Main where

import Lib
import Data.Maybe
import Data.List.Split

data Ending = Unix | DOS | Mac deriving (Eq, Ord, Show)

main :: IO ()
main = interact extract >> putStrLn ""

extract :: String -> String
extract = mapMaybe fuck . chunksOf 2 . lexer

lexer :: String -> [Ending]
lexer []                = []
lexer ('\r' : '\n' : t) = DOS    : lexer t
lexer ('\r' :        t) = Mac    : lexer t 
lexer ('\n' :        t) = Unix   : lexer t 
lexer (_    :        t) =          lexer t

fuck [Unix, Unix] = Just '>'
fuck [Unix, DOS ] = Just '<'
fuck [Unix, Mac ] = Just '+'
fuck [DOS,  Unix] = Just '-'
fuck [DOS,  DOS ] = Just '.'
fuck [DOS,  Mac ] = Just ','
fuck [Mac,  Unix] = Just '['
fuck [Mac,  DOS ] = Just ']'
fuck _            = Nothing
