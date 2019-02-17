-- Definirea unui interpretator folosind monada ce combina Writer cu Maybe; 
-- in cazul aparitiei unei erori se va intoarce rezultatul Nothing fara a afisa outputul cumulat pana in acel moment.


type Name = String

data Term = Var Name | Con Integer | Term :+: Term | Lam Name Term | App Term Term | Out Term deriving (Show)

newtype MaybeWriter a = MW {getValue :: Maybe(a, String)}

instance Monad MaybeWriter where 
  return x = MW (Just(x, ""))
  ma >>= f = case a of 
               Nothing -> MW Nothing 
               Just (x, w) -> case getValue (f x) of 
                                Nothing -> MW Nothing
                                Just (y, v) -> MW (Just(y, w++v))
               where a = getValue ma 


instance Applicative MaybeWriter where
  pure = return 
  mf <*> ma = do {f <- mf; a <-ma; return (f a)}

instance Functor MaybeWriter where
  fmap f ma = pure f <*> ma 

showM :: Show a => MaybeWriter a -> String
showM ma = 
           case a of 
             Nothing -> "Nothing"
             Just (x, w) -> "Output: " ++ w ++ "\nValue: " ++ show x
           where a = getValue ma 

data Value = Num Integer | Fun (Value -> MaybeWriter Value)
type Environment = [(Name, Value)]

instance Show Value where
  show (Num x) = show x
  show (Fun _) = "<function>"

interp :: Term -> Environment -> MaybeWriter Value 
interp (Var x) env = get x env
interp (Con i) _ = return $ Num i
interp (t1 :+: t2) env = do 
                           v1 <- interp t1 env
                           v2 <- interp t2 env
                           add v1 v2
interp (Lam x e) env = return $ Fun (\v-> interp e ((x,v):env))
interp (App t1 t2) env = do 
  f <- interp t1 env
  v <- interp t2 env
  apply f v
interp (Out t) env = do
  v<-interp t env 
  tell (show v ++ "; ")
  return v


tell :: String -> MaybeWriter ()
tell s = MW (Just ((), s))

apply :: Value -> Value -> MaybeWriter Value
apply (Fun k) v = k v
apply _ _ = MW Nothing  

get :: Name -> Environment -> MaybeWriter Value
get x env = case [v | (y,v)<-env, x==y] of
              (v:_) -> return v
              _ -> MW Nothing 

add :: Value -> Value -> MaybeWriter Value
add (Num i) (Num j) = return (Num $ i+j) 
add _ _ = MW Nothing 

test :: Term -> String
test t = showM (interp t [])

pgm :: Term 
pgm = App (Lam "x" ((Var "x") :+: (Var "x"))) ((Out (Con 10)) :+: (Out (Con 11)))

pgmW4::Term
pgmW4 = App (Var "y") (Lam "y" (Out (Con 3)))







