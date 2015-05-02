# Module Documentation

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

##### Instances
``` purescript
instance eqDown :: (Eq a) => Eq (Down a)
instance showDown :: (Show a) => Show (Down a)
instance ordDown :: (Ord a) => Ord (Down a)
```

A newtype wrapper which provides a reversed `Ord` instance. This allows
you to do things like:

    > sortBy (comparing Down) [1,2,3]
    [3,2,1]

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

#### `MinMax`

``` purescript
newtype MinMax a
  = MinMax a
```

##### Instances
``` purescript
instance eqMinMax :: (Eq a) => Eq (MinMax a)
instance showMinMax :: (Show a) => Show (MinMax a)
instance ordMinMax :: (Ord a) => Ord (MinMax a)
instance latticeMinMax :: (Ord a) => Lattice (MinMax a)
```

This newtype allows you to make a `Lattice` from any type which has an
`Ord` instance, using `sup` = `max`, and `inf` = `min`.

#### `Min`

``` purescript
type Min a = Inf (MinMax a)
```

#### `mkMin`

``` purescript
mkMin :: forall a. a -> Min a
```

#### `runMin`

``` purescript
runMin :: forall a. Min a -> a
```

#### `Max`

``` purescript
type Max a = Sup (MinMax a)
```

#### `mkMax`

``` purescript
mkMax :: forall a. a -> Max a
```

#### `runMax`

``` purescript
runMax :: forall a. Max a -> a
```



