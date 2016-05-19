module Data.Ord.Down where

import Data.Bounded (class Bounded, top, bottom)
import Data.Eq (class Eq, (==))
import Data.Ord (class Ord, compare)
import Data.Ordering (invert)
import Data.Semigroup ((<>))
import Data.Show (class Show, show)

-- | A newtype wrapper which provides a reversed `Ord` instance. For example:
-- |
-- |     sortBy (comparing Down) [1,2,3] = [3,2,1]
-- |
newtype Down a = Down a

instance eqDown :: Eq a => Eq (Down a) where
  eq (Down x) (Down y) = x == y

instance ordDown :: Ord a => Ord (Down a) where
  compare (Down x) (Down y) = invert (compare x y)

instance boundedDown :: Bounded a => Bounded (Down a) where
  top = bottom
  bottom = top

instance showDown :: Show a => Show (Down a) where
  show (Down a) = "(Down " <> show a <> ")"
