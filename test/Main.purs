
module Test.Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (log, CONSOLE)
import Control.Monad.Eff.Exception (throwException, error, EXCEPTION)

import Data.Array as A
import Data.Foldable (for_)
import Data.Ord.Down (Down(..))
import Data.Ord.Min (Min(..))
import Data.Ord.Max (Max(..))
import Data.Tuple (Tuple(..))
import Data.Tuple.Nested (Tuple3, tuple3, uncurry3)

type EffT a = forall eff. Eff (exception :: EXCEPTION, console :: CONSOLE | eff) a

assertEq :: forall a. Show a => Eq a => a -> a -> EffT Unit
assertEq x y
  | x == y = pure unit
  | otherwise = throwException $ error $ show x <> " /= " <> show y

main :: EffT Unit
main = do
  log "Down provides an inverted Ord instance"
  let arr = [1,2,2,6,3,4,6]
  assertEq (A.sortBy (comparing Down) arr) (A.reverse (A.sort arr))

  log "Min is a well-behaved Semigroup"
  associativityOf Min

  log "Min is a well-behaved Monoid"
  identityOf Min

  log "Max is a well-behaved Semigroup"
  associativityOf Max

  log "Min is a well-behaved Monoid"
  identityOf Max

  log "top/bottom"
  assertEq (fromDown (top :: Down Int)) (bottom :: Int)
  assertEq (fromDown (bottom :: Down Int)) (top :: Int)

associativityOf
  :: forall a
   . Semigroup a
  => Eq a
  => Show a
  => (Ordering -> a)
  -> EffT Unit
associativityOf f =
  for_ orderings3 (uncurry3 \x y z ->
      let x' = f x
          y' = f y
          z' = f z
      in assertEq ((x' <> y') <> z') (x' <> (y' <> z')))

identityOf
  :: forall a
   . Monoid a
  => Eq a
  => Show a
  => (Ordering -> a)
  -> EffT Unit
identityOf f =
  for_ orderings (\x ->
    let x' = f x
    in assertEq (x' <> mempty) x')

orderings :: Array Ordering
orderings = [LT, EQ, GT]

orderings2 :: Array (Tuple Ordering Ordering)
orderings2 = Tuple <$> orderings <*> orderings

orderings3 :: Array (Tuple3 Ordering Ordering Ordering)
orderings3 = tuple3 <$> orderings <*> orderings <*> orderings

fromDown :: forall a. Down a -> a
fromDown (Down a) = a
