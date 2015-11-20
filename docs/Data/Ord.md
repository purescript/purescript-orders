## Module Data.Ord

A module defining some useful types and instances surrounding the `Ord`
type class.

#### `invert`

``` purescript
invert :: Ordering -> Ordering
```

#### `comparing`

``` purescript
comparing :: forall a b. (Ord b) => (a -> b) -> a -> a -> Ordering
```

#### `Down`

``` purescript
newtype Down a
  = Down a
```

A newtype wrapper which provides a reversed `Ord` instance. This allows
you to do things like:

    > sortBy (comparing Down) [1,2,3]
    [3,2,1]


##### Instances
``` purescript
instance eqDown :: (Eq a) => Eq (Down a)
instance showDown :: (Show a) => Show (Down a)
instance ordDown :: (Ord a) => Ord (Down a)
```

#### `clamp`

``` purescript
clamp :: forall a. (Ord a) => a -> a -> a -> a
```

Clamp a value between a minimum and a maximum. For example:

    let f = clamp 0 10
    f (-5) == 0
    f 5    == 5
    f 15   == 10


#### `between`

``` purescript
between :: forall a. (Ord a) => a -> a -> a -> Boolean
```

Test whether a value is between a minimum and a maximum. For example:

    let f = between 0 10
    f (-5) == false
    f 5    == true
    f 15   == false


#### `min`

``` purescript
min :: forall a. (Ord a) => a -> a -> a
```

Take the minimum of two values. If they compare to `EQ`, the first
argument is chosen.

#### `max`

``` purescript
max :: forall a. (Ord a) => a -> a -> a
```

Take the maximum of two values. If they compare to `EQ`, the first
argument is chosen.

#### `Min`

``` purescript
newtype Min a
  = Min a
```

Provides a `Semigroup` based on the `min` function. If the type
has a `Bounded` instance, then a `Monoid` instance can be provided
too. For example:

    runMin (Min 5 <> Min 6) = 5
    mempty :: Min Ordering = Min GT


##### Instances
``` purescript
instance eqMin :: (Eq a) => Eq (Min a)
instance showMin :: (Show a) => Show (Min a)
instance ordMin :: (Ord a) => Ord (Min a)
instance semigroupMin :: (Ord a) => Semigroup (Min a)
instance monoidMin :: (Ord a, Bounded a) => Monoid (Min a)
```

#### `runMin`

``` purescript
runMin :: forall a. Min a -> a
```

#### `Max`

``` purescript
newtype Max a
  = Max a
```

Provides a `Semigroup` based on the `max` function. If the type
has a `Bounded` instance, then a `Monoid` instance can be provided
too. For example:

    runMax (Max 5 <> Max 6) = 6
    mempty :: Max Ordering = Max LT


##### Instances
``` purescript
instance eqMax :: (Eq a) => Eq (Max a)
instance showMax :: (Show a) => Show (Max a)
instance ordMax :: (Ord a) => Ord (Max a)
instance semigroupMax :: (Ord a) => Semigroup (Max a)
instance monoidMax :: (Ord a, Bounded a) => Monoid (Max a)
```

#### `runMax`

``` purescript
runMax :: forall a. Max a -> a
```


