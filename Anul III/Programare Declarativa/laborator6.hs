module Lab6 where
import Data.List (nub)
import Data.Maybe (fromJust)

-- Exercitiul 0

data Fruct 
  = Mar String Bool
   |Portocala String Int

ePortocalaDeSicilia :: Fruct -> Bool
ePortocalaDeSicilia (Mar _ _) = False
ePortocalaDeSicilia (Portocala tip _) = tip `elem` ["Tarocoo", "Moro", "Sanguinello"]
-- sau ePortocalaDeSicilia (x @Portocala tip felii) = 

test_ePortocalaDeSicilia1 = ePortocalaDeSicilia(Portocala "Moro" 12) == True
test_ePortocalaDeSicilia2 = ePortocalaDeSicilia(Mar "Ionatan" True) == False


type Nume = String
data Prop
  = Var Nume
  | F
  | T
  | Not Prop
  | Prop :|: Prop
  | Prop :&: Prop
  | Prop :->: Prop
  | Prop :<->: Prop
  deriving (Eq, Read)
infixr 2 :|:
infixr 3 :&:

-- Ex. 1 
-- 1. 
p1 :: Prop
p1 = (Var "P" :|: Var "Q") :&: (Var "P" :|: Var "Q")

-- 2.
p2 :: Prop
p2 = (Var "P" :|: Var "Q") :&: (Not (Var "P") :&: Not (Var "Q"))

-- 3.
p3 :: Prop
p3 = (Var "P" :&: (Var "Q" :|: Var "R")) :&: (Not (Var "P") :|: Not (Var "Q")) :&: (Not (Var "P") :|: Not (Var "R")) 

instance Show Prop where
  show (Var x) = x
  show F = "False"
  show T = "True"
  show (Not p) = "~" ++ show p 
  show (p1 :|: p2) = "(" ++ show p1 ++ ") \\/ (" ++ show p2 ++ ")"
  show (p1 :&: p2) = "(" ++ show p1 ++ ") /\\ (" ++ show p2 ++ ")"  
  show (p1 :->: p2) = "(" ++ show p1 ++ ") -> (" ++ show p2 ++ ")"  
  show (p1 :<->: p2) = "(" ++ show p1 ++ ") <-> (" ++ show p2 ++ ")"  

type Env = [(Nume, Bool)] -- am declarat mai sus type Nume = String

impureLookup :: Eq a => a -> [(a,b)] -> b
impureLookup a = fromJust . lookup a

eval :: Prop -> Env -> Bool
eval (Var x) list = impureLookup x list 
eval (p1 :|: p2) list = (eval p1 list) || (eval p2 list) 
eval (p1 :&: p2) list = (eval p1 list) && (eval p2 list)
eval (p1 :->: p2) list = (not (eval p1 list)) || (eval p2 list)
eval (p1 :<->: p2) list = ((eval p1 list) && (eval p2 list)) || ((not (eval p1 list)) && (not (eval p2 list))) 
eval (Not p) list = not (eval p list)

test_eval = eval (Var "P" :|: Var "Q") [("P", True), ("Q", False)] == True

variabile :: Prop -> [Nume]
variabile (Var x) = [x]
variabile (p1 :|: p2) = nub (rez1 ++ rez2)
                        where 
                          rez1 = variabile p1
                          rez2 = variabile p2
variabile (p1 :&: p2) = nub (rez1 ++ rez2)
                        where 
                          rez1 = variabile p1
                          rez2 = variabile p2  
variabile (p1 :->: p2) = nub (rez1 ++ rez2)
                        where 
                          rez1 = variabile p1
                          rez2 = variabile p2
variabile (p1 :<->: p2) = nub (rez1 ++ rez2)
                        where 
                          rez1 = variabile p1
                          rez2 = variabile p2    
variabile (Not p) = nub rez
                        where 
                          rez = variabile p

test_variabile = variabile (Not (Var "P") :&: Var "Q" :&: Var "P") == ["P", "Q"]

-- Ex. 5
envs :: [Nume] -> [[(Nume, Bool)]]
envs (x:[]) = [[(x, True)], [(x,False)]]
envs (x:xs) = [a:it | it <-rez] ++ [b:it | it <-rez]
              where 
                a = (x, True)
                b = (x, False)
                rez = envs xs

test_envs = 
    envs ["P", "Q"]
    ==
    [ 
      [ ("P",True)
      , ("Q",True)
      ]
     ,
      [ ("P",True)
      , ("Q",False)
      ]
     , 
      [ ("P",False)
      , ("Q",True)
      ]
    , 
      [ ("P",False)
      , ("Q",False)
      ]
    ] 

-- Ex. 6

satisfiabila :: Prop -> Bool
satisfiabila p = foldr f False posibilitati_p 
                 where 
                  var_p = variabile p 
                  posibilitati_p = envs var_p
                  f pos_curenta unit = (eval p pos_curenta) || unit 
 
test_satisfiabila1 = satisfiabila (Not (Var "P") :&: Var "Q") == True
test_satisfiabila2 = satisfiabila (Not (Var "P") :&: Var "P") == False

-- Ex. 7
valida :: Prop -> Bool
valida p = foldr f True posibilitati_p 
                 where 
                  var_p = variabile p 
                  posibilitati_p = envs var_p
                  f pos_curenta unit = (eval p pos_curenta) && unit 

test_valida1 = valida (Not (Var "P") :&: Var "Q") == False
test_valida2 = valida (Not (Var "P") :|: Var "P") == True

tabelaAdevar :: Prop -> IO ()
tabelaAdevar p = do 
  putStr (primaLinie ++ "\n") 
  putStr (liniute ++ "\n")
  mapM_ putStrLn evaluari

    where 
      var = variabile p
      valori_adevar = envs var 
      primaLinie = afisarePrimaLinie var
      n_variabile = length var
      n_formula = length (primaLinie) - n_variabile
      liniute = afisareLiniute n_variabile n_formula
      evaluari = evalueaza var valori_adevar      
 
      afisarePrimaLinie :: [Nume] -> String
      afisarePrimaLinie [] = "| " ++ (show p)
      afisarePrimaLinie (x:xs) = x ++ " " ++ afisarePrimaLinie xs

      afisareLiniute :: Int -> Int -> String
      afisareLiniute 0 0 = ""
      afisareLiniute 0 y = "-" ++ afisareLiniute 0 (y-1)
      afisareLiniute 1 y = "- | " ++ afisareLiniute 0 y
      afisareLiniute x y = "- " ++ afisareLiniute (x-1) y  

      evalueaza :: [Nume] -> [[(Nume, Bool)]] -> [String]
      evalueaza v [] = []
      evalueaza v (x:xs) = (valori_variabile ++ "| " ++ eval_curenta):evalueaza v xs
                           where 
                             valori_variabile = afla_valori v x
                             eval_curenta = case eval p x of False -> "F "
                                                             True -> "T "
                             afla_valori [] _ = "" 
                             afla_valori (y:ys) lista = valoare_variabila ++ afla_valori ys lista
                                                          where valoare_variabila = case (impureLookup y lista) of
                                                                                        False -> "F "
                                                                                        True -> "T " 
contains :: [Nume] -> [Nume] -> Bool -- stie sa verifice daca doua liste sunt egale
contains [] y = True
contains (x:xs) y = elem x y && contains xs y

echivalenta :: Prop -> Prop -> Bool
echivalenta p1 p2 =  test_echiv valori_adevar
                     where 
                      variabile_p1 = variabile p1
                      variabile_p2 = variabile p2
                      valori_adevar = envs (variabile_p1 ++ variabile_p2)				
                      test_echiv :: [[(Nume, Bool)]] -> Bool
                      test_echiv [] = True
                      test_echiv (x:xs) 
                                       | ev1 == ev2 = test_echiv xs
                                       | otherwise = False
                                        where 
                                          ev1 = eval p1 x
                                          ev2 = eval p2 x
test_echivalenta1 =
  True
  ==
  (Var "P" :&: Var "Q") `echivalenta` (Not (Not (Var "P") :|: Not (Var "Q")))
test_echivalenta2 =
  False
  ==
  (Var "P") `echivalenta` (Var "Q")
test_echivalenta3 =
  True
  ==
  (Var "R" :|: Not (Var "R")) `echivalenta` (Var "Q" :|: Not (Var "Q"))



