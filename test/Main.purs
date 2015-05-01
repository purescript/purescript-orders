
module Test.Main where

import Console (log, print)
import Control.Monad.Eff

import Data.Ord

-- | Sort the elements of an array in increasing order, where elements are compared using
-- | the specified partial ordering, creating a new array.
sortBy :: forall a. (a -> a -> Ordering) -> Array a -> Array a
sortBy comp xs = sortJS comp' xs
  where
  comp' x y = case comp x y of
    GT -> 1
    EQ -> 0
    LT -> -1

sort :: forall a. (Ord a) => Array a -> Array a
sort = sortBy compare

foreign import sortJS
  """
  function sortJS (f) {
    return function (l) {
      return l.slice().sort(function (x, y) {
        return f(x)(y);
      });
    };
  }
  """ :: forall a. (a -> a -> Int) -> Array a -> Array a

assertEq :: forall a e. (Eq a, Show a) => a -> a -> Eff e Unit
assertEq x y
  | x == y    = return unit
  | otherwise = throwError (show x <> " /= " <> show y)

foreign import throwError
  """
  function throwError(msg) {
    throw new Error(msg)
  }
  """ :: forall e. String -> Eff e Unit

foreign import reverse
  """
  function reverse(xs) {
    return xs.slice().reverse()
  }
  """ :: forall a. Array a -> Array a

main = do
  let arr = [1,2,2,6,3,4,6]
  assertEq (sortBy (comparing Down) arr) (reverse (sort arr))
