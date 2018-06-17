module Main where

import Lib
import Happstack.Server
import Happstack.Server.Types
import Data.Hash.MD5
import System.Environment
import Data.Maybe

main :: IO ()
main = do
  port <- fmap read $ getEnv "PORT"
  print port
  let config = Conf
        { port = port
        , validator = Nothing
        , logAccess = Just logMAccess
        , timeout = 1000
        , threadGroup = Nothing
        }
  simpleHTTP config myApp

myApp :: ServerPart String
myApp = dir "getToken" $ path $ \account -> ok $
  let version = "1"
      expired = "10000"
      appID = "fe28615cf12e443983130a00cb07c939"
      appCertificate = "31b43406da9348fa82d507438134721a"
      content = account ++ appID ++ appCertificate ++ expired
      contentMD5Hash = md5s $ Str content
  in version ++ ":"
     ++ appID ++ ":"
     ++ expired ++ ":"
     ++ contentMD5Hash
