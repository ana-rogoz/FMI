import Data.Word

newtype State state a = State {runState :: state -> (a, state)}

instance Monad (State state) where
  return a = State (\s -> (a,s))
  ma >>= k = State (\s -> let (a, aState) = runState ma s
                              (State g) = k a 
                          in g aState)

instance Functor (State state) where
  fmap f mx = do { x<-mx; return (f x)}

instance Applicative (State state) where
  pure = return 
  mf <*> ma = do { f<-mf; a<-ma; return (f a)}

get :: State state state
get = State (\s->(s,s))
 
modify :: (state -> state) -> State state () 
modify f = State (\s -> ((), f s))

cMultiplier, cIncrement :: Word32
cMultiplier = 23
cIncrement = 10

rnd, rnd2 :: State Word32 Word32
rnd = do
        modify (\seed-> cMultiplier * seed + cIncrement)
        get

rnd2 = do 
        v1<-rnd
        v2<-rnd
        return (v1+v2)
