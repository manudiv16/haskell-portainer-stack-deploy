{-# LANGUAGE OverloadedStrings #-}


module PortainerApi
    ( portainerAuthPost
      ,portainerLogoutPost
      ,getJwt
      ,portaineGetStacks
      ,getStacks
    ) where

import PortainerTypes ( PortainerConfig(PortainerConfig) )
import System.Environment ( getEnv )
import Control.Lens ( (&), (^.), (.~) )
import Data.Aeson.Lens ( key, AsPrimitive(_String), AsValue )
import Data.Aeson ( Value, ToJSON(toJSON) )
import GHC.Generics ()
import qualified Data.Text as T
import Data.Text.Encoding (encodeUtf8)
import Data.Map as Map ( Map )
import Network.Wreq
    ( asJSON,
      asValue,
      getWith,
      post,
      postWith,
      defaults,
      header,
      responseBody,
      Response,
      FormParam((:=)) )

type RespA = Response [Map String Value]
type Resp = Response (Map String Value)

portainerAuthPost :: PortainerConfig -> IO (Response Value)
portainerAuthPost (PortainerConfig url credentials)  = asValue =<< post (url ++"/auth") (toJSON credentials)  

portainerLogoutPost (PortainerConfig url _ ) jwt = postWith opts (url++"/auth/logout") ["num":=(3::Int)] 
  where opts = defaults & header "Authorization" .~ [encodeUtf8 jwt]

portaineGetStacks :: PortainerConfig -> T.Text -> IO RespA
portaineGetStacks (PortainerConfig url _ ) jwt = asJSON =<< getWith opts (url++"/stacks") ::IO RespA
  where opts = defaults & header "Authorization" .~ [encodeUtf8 jwt]

getJwt :: AsValue body1 => Response body1 -> T.Text
getJwt resp = resp ^. responseBody . key "jwt" . _String

getStacks :: Response body0 -> body0
getStacks resp = resp ^. responseBody 
