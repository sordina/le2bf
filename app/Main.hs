{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Maybe
import Data.Tuple
import Data.List.Split
import Options.Generic
import Prelude hiding (reverse)

data Ending = Unix | DOS | Mac deriving (Eq, Ord, Show)

data Options = Options { reverse :: Bool } deriving (Eq, Ord, Show, Generic)

instance ParseRecord Options

main :: IO ()
main = do
  o <- getRecord "" :: IO Options
  if (reverse o) then interact bf2le
                 else interact le2bf
  putStrLn "" -- Could make things non-isomorphic, but looks better and shouldn't be a big problem due to pairs behaviour.

le2bf :: String -> String
le2bf = mapMaybe fuck . chunksOf 2 . lexer

bf2le :: String -> String
bf2le = concatMap unfuck

lexer :: String -> [Ending]
lexer []                = []
lexer ('\r' : '\n' : t) = DOS    : lexer t
lexer ('\r' : ' '  : t) = Mac    : lexer t
lexer ('\n' : ' '  : t) = Unix   : lexer t
lexer (_    :        t) =          lexer t

translations :: [([Ending], Char)]
translations = [ ([Unix, Unix], '>')
               , ([Unix, DOS ], '<')
               , ([Unix, Mac ], '+')
               , ([DOS,  Unix], '-')
               , ([DOS,  DOS ], '.')
               , ([DOS,  Mac ], ',')
               , ([Mac,  Unix], '[')
               , ([Mac,  DOS ], ']')
               ]

translations' :: [(Char, [Ending])]
translations' = map swap translations

fuck :: [Ending] -> Maybe Char
fuck = flip lookup translations

unfuck :: Char -> [Char]
unfuck x = case x of '\r' -> []
                     '\n' -> []
                     _    -> maybe [x] ((x:) . concatMap emit) (lookup x translations')

emit :: Ending -> String
emit Unix = "\n "
emit Mac  = "\r "
emit DOS  = "\r\n"
