
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

type Environment = [(Name, Value)]
 
interp :: Term -> Environment -> M Value

interp (Con i) _ = return (Num i)

interp (t1 :+: t2) env = do
   v1 <- interp t1 env
   v2 <- interp t2 env
   add v1 v2

type M = Identity

