
-- | A module defining some useful types and instances surrounding the `Ord`
-- | type class.

module Data.Ord where

import Data.Function
import Data.Monoid.Inf
import Data.Monoid.Sup

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
newtype Down a = Down a

instance eqDown :: (Eq a) => Eq (Down a) where
  eq (Down x) (Down y) = x == y

instance showDown :: (Show a) => Show (Down a) where
  show (Down a) = "(Down " <> show a <> ")"

instance ordDown :: (Ord a) => Ord (Down a) where
  compare (Down x) (Down y) = invert (compare x y)

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

-- | This newtype allows you to make a `Lattice` from any type which has an
-- | `Ord` instance, using `sup` = `max`, and `inf` = `min`.
newtype MinMax a = MinMax a

instance eqMinMax :: (Eq a) => Eq (MinMax a) where
  eq (MinMax x) (MinMax y) = x == y

instance showMinMax :: (Show a) => Show (MinMax a) where
  show (MinMax a) = "(MinMax " <> show a <> ")"

instance ordMinMax :: (Ord a) => Ord (MinMax a) where
  compare (MinMax x) (MinMax y) = compare x y

instance latticeMinMax :: (Ord a) => Lattice (MinMax a) where
  sup = max
  inf = min

type Min a = Inf (MinMax a)

mkMin :: forall a. a -> Min a
mkMin = Inf <<< MinMax

runMin :: forall a. Min a -> a
runMin (Inf (MinMax a)) = a

type Max a = Sup (MinMax a)

mkMax :: forall a. a -> Max a
mkMax = Sup <<< MinMax

runMax :: forall a. Max a -> a
runMax (Sup (MinMax a)) = a
