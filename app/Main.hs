{-# LANGUAGE BlockArguments #-}
module Main where

import Lib
import System.Environment
import Data.List
import Text.Printf
import PortainerApi
import PortainerTypes
import qualified Data.ByteString as B
import Network.Wreq
import Control.Lens
import Data.Aeson.Lens
import Data.Map as Map
import qualified Data.Text as T

main = do
    user <- getEnv "portainerUser"
    password <- getEnv "portainerPass"
    url <- getEnv "portainerUrl"
    let config = PortainerConfig url $ CredentialsAuth user password
    resp <- portainerAuthPost config
    let jwt = getJwt resp :: T.Text
    resStacks <- portaineGetStacks config jwt
    portainerLogoutPost config jwt
    let stack = getStacks resStacks
    print "oh"


