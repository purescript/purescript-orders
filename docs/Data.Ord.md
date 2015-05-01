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

A newtype wrapper which provides a reversed `Ord` instance. This allows
you to do things like:

    > sortBy (comparing Down) [1,2,3]
    [3,2,1]

#### `eqDown`

``` purescript
instance eqDown :: (Eq a) => Eq (Down a)
```


#### `showDown`

``` purescript
instance showDown :: (Show a) => Show (Down a)
```


#### `ordDown`

``` purescript
instance ordDown :: (Ord a) => Ord (Down a)
```