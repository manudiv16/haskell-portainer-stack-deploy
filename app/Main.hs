{-# LANGUAGE BlockArguments #-}
module Main where

import Lib ()
import System.Environment ( getEnv )
import MustacheApi (renderDockerCompose)
import PortainerApi
    ( getJwt,
      getStacks,
      portaineGetStacks,
      portainerAuthPost,
      portainerLogoutPost )
import PortainerTypes
    ( CredentialsAuth(CredentialsAuth),
      PortainerConfig(PortainerConfig) )
import Control.Lens
import qualified Data.Text as T
import qualified Data.Text.Lazy.IO as TIO


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
    a <-renderDockerCompose "docker-compose.yml" "foo.json" 
    TIO.putStrLn a


