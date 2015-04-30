
-- | A module defining some useful types and instances surrounding the `Ord`
-- | type class.

module Data.Ord where

import Data.Function

invert :: Ordering -> Ordering
invert GT = LT
invert EQ = EQ
invert LT = GT

-- | A newtype wrapper which provides a reversed `Ord` instance. This allows
-- | you to do things like:
-- |
-- |     > sortBy (compare `on` Down) [1,2,3]
-- |     [3,2,1]
newtype Down a = Down a

instance eqDown :: (Eq a) => Eq (Down a) where
  eq (Down x) (Down y) = x == y

instance showDown :: (Show a) => Show (Down a) where
  show (Down a) = "(Down " <> show a <> ")"

instance ordDown :: (Ord a) => Ord (Down a) where
  compare (Down x) (Down y) = invert (compare x y)
