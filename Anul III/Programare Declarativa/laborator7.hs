import Data.Char (ord, chr)
import Data.List.Split

-- Exercitiul 1

citesteEx1 :: Int -> Int -> [String] -> IO() 
citesteEx1 0 varstaMax lista = putStrLn $ "Cel mai in varsta este " ++ concat lista ++ " " ++ show varstaMax

citesteEx1 n varstaMax lista = do 
                            nume <- getLine
                            varsta <- readLn :: IO Int  
                            if varsta > varstaMax 
                            then citesteEx1 (n-1) varsta [nume]
	                    else if varsta == varstaMax
                            then citesteEx1 (n-1) varstaMax (nume:lista)
                            else citesteEx1 (n-1) varstaMax lista
                         

ioString1 = do
	   n <- readLn :: IO Int  
           citesteEx1 n 0 []
                 	
-- Exercitiul 2                       
ioString2 = do
	   sin <- readFile "ex2.in"
           let contents = lines (sin)
           let l1 = map (splitOn ",") contents
           let l2 = [(n, read v::Int) | l <- l1, let n = l !! 0, let v = l !! 1]
-- sau [n,v] <- l1
           let maxv = maximum[v|(n,v) <-l2]
           let nume = [n | (n,v) <- l2, v == maxv]
           putStrLn (show maxv ++ " " ++ concat nume)  
          
