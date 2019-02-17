-- Ex. 3
data Prog  = On Instr                
data Instr  = Off | Expr :> Instr | Expr :>: Instr | Expr :>>: Instr | Expr :>> Instr  
data Expr  =  Mem1 | Mem2 | V Int | Expr :+ Expr | Expr :* Expr 

infixl 6 :+   
infixl 7 :*

type Env = (Int, Int) 
type DomInstr = Env -> [Int] -- env si env sunt cele doua celule de memorie
type DomProg = [Int]
type DomExpr = Env -> Int -- idem 

prog :: Prog -> DomProg
prog (On s) = stmt s (0, 0)

stmt :: Instr -> DomInstr
stmt (e :> s) (m1, m2) = let v = expr e (m1, m2) in  (v : (stmt s (v, v)))
stmt (e :>> s) (m1, m2) = let v = expr e (m1, m2) in (v : (stmt s (m1, m2)))
stmt (e :>: s) (m1, m2) = let v = expr e (m1, m2) in (v : (stmt s (v, m2)))
stmt (e :>>: s) (m1, m2) = let v = expr e (m1, m2) in (v : (stmt s (m1, v)))
stmt Off _ = []


expr ::  Expr -> DomExpr
expr (e1 :+ e2) (m1, m2) = (expr e1 (m1, m2)) + (expr e2 (m1, m2))
expr (e1 :* e2) (m1, m2) = (expr e1 (m1, m2)) * (expr e2 (m1, m2))
expr (V n) _ =  n
expr Mem1 (m1, m2) = m1
expr Mem2 (m1, m2) = m2

val1 = On ((V 3) :> (( Mem1 :+ (V 5)) :> Off))
val2 = On ((V 3) :>> (( Mem2 :+ (V 5)) :> Off))
val3 = On ((V 2) :>: (( Mem2 :+ (V 15)) :> Off))
val4 = On ((V 2) :>: (( Mem1 :+ (V 15)) :> Off))
val5 = On ((V 2) :>>: (( Mem2 :+ (V 15)) :> Off))

