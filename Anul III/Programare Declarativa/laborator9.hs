type Name = String
 
data Term = Var Name
          | Con Integer
          | Term :+: Term
          | Lam Name Term
          | App Term Term
  deriving (Show)

term0 = (App (Lam "x" (Var "x" :+: Var "x")) (Con 10 :+: Con 11))

data Value = Num Integer
           | Fun (Value -> M Value)
           | Wrong
 
instance Show Value where
  show (Num x) = show x
  show (Fun _) = "<function>"
  show Wrong   = "<wrong>"

newtype Identity a = Identity { runIdentity :: a }

instance Monad Identity where
  return x = Identity x 
  ma >>= k = k (runIdentity ma) 

instance Functor Identity where
  fmap f mx =  do {x<-mx; return (f x)}

instance Applicative Identity where
  pure = return
  mf <*> ma = do {f<-mf; a <- ma; return (f a)}

instance Show (Identity a) where 
  show x = show (runIdentity x)

type Environment = [(Name, Value)]
 
interp :: Term -> Environment -> M Value

interp (Con i) _ = return (Num i)

interp (t1 :+: t2) env = do
   v1 <- interp t1 env
   v2 <- interp t2 env
   add v1 v2

add :: Value -> Value -> M Value
add (Num i) (Num j) = return (Num (i+j))
add _ _ = return Wrong

type M = Identity
showM :: Show a => M a -> String
showM = show . runIdentity 



