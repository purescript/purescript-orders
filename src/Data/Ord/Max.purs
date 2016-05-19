module Data.Ord.Max where

import Data.Bounded (class Bounded, bottom)
import Data.Eq (class Eq, (==))
import Data.Monoid (class Monoid)
import Data.Ord (class Ord, compare, max)
import Data.Semigroup (class Semigroup, (<>))
import Data.Show (class Show, show)

-- | Provides a `Semigroup` based on the `max` function. If the type has a
-- | `Bounded` instance, then a `Monoid` instance is provided too. For example:
-- |
-- |     runMax (Max 5 <> Max 6) = 6
-- |     mempty :: Max Ordering = Max LT
-- |
newtype Max a = Max a

runMax :: forall a. Max a -> a
runMax (Max a) = a

instance eqMax :: Eq a => Eq (Max a) where
  eq (Max x) (Max y) = x == y

instance ordMax :: Ord a => Ord (Max a) where
  compare (Max x) (Max y) = compare x y

instance semigroupMax :: Ord a => Semigroup (Max a) where
  append (Max x) (Max y) = Max (max x y)

instance monoidMax :: Bounded a => Monoid (Max a) where
  mempty = Max bottom

instance showMax :: Show a => Show (Max a) where
  show (Max a) = "(Max " <> show a <> ")"
