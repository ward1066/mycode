doubleme x = x + x
divbyten = (/10)
multbyten = (10*)
myzip :: (a -> b -> c) -> [a] -> [b] -> [c]
myzip _ [] _ = []
myzip _ _ [] = []
myzip f (x:xs) (y:ys) = f x y : myzip f xs ys
