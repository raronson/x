{-# LANGUAGE RankNTypes #-}
module X.Control.Monad.Trans.Either (
    module X
  , firstEitherT
  , secondEitherT
  , eitherTFromMaybe
  , hoistEitherT
  ) where

import           Control.Monad.Trans.Either as X (
                     EitherT (..)
                   , eitherT
                   , bimapEitherT
                   , left
                   , right
                   , hoistEither
                   , mapEitherT
                   )

firstEitherT :: Functor f => (e -> e') -> EitherT e f a -> EitherT e' f a
firstEitherT f =
  bimapEitherT f id

secondEitherT :: Functor f => (a -> a') -> EitherT e f a -> EitherT e f a'
secondEitherT =
  bimapEitherT id

eitherTFromMaybe :: Functor f => e -> f (Maybe a) -> EitherT e f a
eitherTFromMaybe e =
  EitherT . fmap (maybe (Left e) Right)

hoistEitherT :: (forall t. m t -> n t) -> EitherT e m a -> EitherT e n a
hoistEitherT f = EitherT . f . runEitherT