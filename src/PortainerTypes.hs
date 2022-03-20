{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}

module PortainerTypes
( PortainerConfig(..)
  ,CredentialsAuth(..)
) where

import Data.Aeson ( ToJSON )
import GHC.Generics ( Generic )

data CredentialsAuth = CredentialsAuth {
  username :: String
  , password :: String
} deriving (Generic, ToJSON, Show)

data PortainerConfig = PortainerConfig {
  url :: String
  , credentials :: CredentialsAuth
} deriving (Generic, ToJSON, Show)