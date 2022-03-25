{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE KindSignatures #-}
module MustacheApi(
  renderDockerCompose
)where

import Data.Aeson
import Data.Semigroup ((<>))
import Data.Text (Text)
import GHC.Generics
import Text.Mustache
import qualified Text.Mustache.Compile.TH as TH
import qualified Data.ByteString.Lazy as B

decoder :: Either a b -> b
decoder (Left _) = error "Error"
decoder (Right x) = x

renderDockerCompose mustacheFile jsonFile = do
  mainTemplate <- compileMustacheFile mustacheFile -- (1)
  a <- B.readFile jsonFile
  let r =  decoder (eitherDecode a :: Either String Value)
  let template = mainTemplate 
  return $ renderMustache template r 