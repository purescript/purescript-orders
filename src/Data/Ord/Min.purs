module Data.Ord.Min where

import Data.BoundedOrd (class BoundedOrd, top)
import Data.Eq (class Eq, (==))
import Data.Monoid (class Monoid)
import Data.Ord (class Ord, compare, min)
import Data.Semigroup (class Semigroup, (<>))
import Data.Show (class Show, show)

-- | Provides a `Semigroup` based on the `min` function. If the type
-- | has a `BoundedOrd` instance, then a `Monoid` instance can be provided
-- | too. For example:
-- |
-- |     runMin (Min 5 <> Min 6) = 5
-- |     mempty :: Min Ordering = Min GT
-- |
newtype Min a = Min a

runMin :: forall a. Min a -> a
runMin (Min a) = a

instance eqMin :: Eq a => Eq (Min a) where
  eq (Min x) (Min y) = x == y

instance ordMin :: Ord a => Ord (Min a) where
  compare (Min x) (Min y) = compare x y

instance semigroupMin :: Ord a => Semigroup (Min a) where
  append (Min x) (Min y) = Min (min x y)

instance monoidMin :: BoundedOrd a => Monoid (Min a) where
  mempty = Min top

instance showMin :: Show a => Show (Min a) where
  show (Min a) = "(Min " <> show a <> ")"
