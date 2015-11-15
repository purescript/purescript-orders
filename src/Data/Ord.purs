
-- | A module defining some useful types and instances surrounding the `Ord`
-- | type class.

module Data.Ord where

import Prelude
import Data.Function
import Data.Monoid

invert :: Ordering -> Ordering
invert GT = LT
invert EQ = EQ
invert LT = GT

comparing :: forall a b. (Ord b) => (a -> b) -> (a -> a -> Ordering)
comparing f = compare `on` f

-- | A newtype wrapper which provides a reversed `Ord` instance. This allows
-- | you to do things like:
-- |
-- |     > sortBy (comparing Down) [1,2,3]
-- |     [3,2,1]
-- |
newtype Down a = Down a

instance eqDown :: (Eq a) => Eq (Down a) where
  eq (Down x) (Down y) = x == y

instance showDown :: (Show a) => Show (Down a) where
  show (Down a) = "(Down " <> show a <> ")"

instance ordDown :: (Ord a) => Ord (Down a) where
  compare (Down x) (Down y) = invert (compare x y)

-- | Clamp a value between a minimum and a maximum. For example:
-- |
-- |     let f = clamp 0 10
-- |     f (-5) == 0
-- |     f 5    == 5
-- |     f 15   == 10
-- |
clamp :: forall a. (Ord a) => a -> a -> a -> a
clamp low hi x = min hi (max low x)

-- | Test whether a value is between a minimum and a maximum. For example:
-- |
-- |     let f = between 0 10
-- |     f (-5) == false
-- |     f 5    == true
-- |     f 15   == false
-- |
between :: forall a. (Ord a) => a -> a -> a -> Boolean
between low hi x = low <= x && x <= hi

-- | Take the minimum of two values. If they compare to `EQ`, the first
-- | argument is chosen.
min :: forall a. (Ord a) => a -> a -> a
min x y =
  case compare x y of
    LT -> x
    EQ -> x
    GT -> y

-- | Take the maximum of two values. If they compare to `EQ`, the first
-- | argument is chosen.
max :: forall a. (Ord a) => a -> a -> a
max x y =
  case compare x y of
    LT -> y
    EQ -> x
    GT -> x

-- | Provides a `Semigroup` based on the `min` function. If the type
-- | has a `Bounded` instance, then a `Monoid` instance can be provided
-- | too. For example:
-- |
-- |     runMin (Min 5 <> Min 6) = 5
-- |     mempty :: Min Ordering = Min GT
-- |
newtype Min a = Min a

runMin :: forall a. Min a -> a
runMin (Min a) = a

instance eqMin :: (Eq a) => Eq (Min a) where
  eq = eq `on` runMin

instance showMin :: (Show a) => Show (Min a) where
  show (Min a) = "(Min " <> show a <> ")"

instance ordMin :: (Ord a) => Ord (Min a) where
  compare = compare `on` runMin

instance semigroupMin :: (Ord a) => Semigroup (Min a) where
  append (Min x) (Min y) = Min (min x y)

instance monoidMin :: (Ord a, Bounded a) => Monoid (Min a) where
  mempty = Min top

-- | Provides a `Semigroup` based on the `max` function. If the type
-- | has a `Bounded` instance, then a `Monoid` instance can be provided
-- | too. For example:
-- |
-- |     runMax (Max 5 <> Max 6) = 6
-- |     mempty :: Max Ordering = Max LT
-- |
newtype Max a = Max a

runMax :: forall a. Max a -> a
runMax (Max a) = a

instance eqMax :: (Eq a) => Eq (Max a) where
  eq = eq `on` runMax

instance showMax :: (Show a) => Show (Max a) where
  show (Max a) = "(Max " <> show a <> ")"

instance ordMax :: (Ord a) => Ord (Max a) where
  compare = compare `on` runMax

instance semigroupMax :: (Ord a) => Semigroup (Max a) where
  append (Max x) (Max y) = Max (max x y)

instance monoidMax :: (Ord a, Bounded a) => Monoid (Max a) where
  mempty = Max bottom
