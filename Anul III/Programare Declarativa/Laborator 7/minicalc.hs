data Prog  = On Instr                
data Instr  = Off | Expr :> Instr  
data Expr  =  Mem | V Int | Expr :+ Expr 



infixl 6 :+   



type Env = Int
type DomInstr = Env -> [Int]
type DomProg = [Int]
type DomExpr = Env -> Int

prog :: Prog -> DomProg
prog (On s) = stmt s 0 

stmt :: Instr -> DomInstr
stmt  (e :> s) m = let v = expr e m in  (v : (stmt s v))
stmt Off _ = []


expr ::  Expr -> DomExpr
expr (e1 :+  e2) m = (expr  e1 m) + (expr  e2 m)
expr (V n) _  =  n
expr  Mem m  = m

val = On ((V 3) :> (( Mem :+ (V 5)) :> Off))
