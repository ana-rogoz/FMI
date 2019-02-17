module Lab7 where

import Data.Char (toUpper)
import Data.List.Split (splitOn)

prelStr :: String -> String
prelStr strin = map toUpper strin

ioString :: IO ()
ioString = do
           strin <- getLine
           putStrLn $ "Intrare\n" ++ strin
           let  strout = prelStr strin
           putStrLn $ "Iesire\n" ++ strout

prelNo :: Double -> Double
prelNo noin = sqrt noin

ioNumber :: IO ()
ioNumber = do
           noin <- readLn :: IO Double
           putStrLn $ "Intrare\n" ++ (show noin)
           let  noout = prelNo noin
           putStrLn $ "Iesire"
           print noout

inoutFile :: IO ()
inoutFile = do
              sin <- readFile "Input.txt"
              putStrLn $ "Intrare\n" ++ sin
              let sout = prelStr sin
              putStrLn $ "Iesire\n" ++ sout
              writeFile "Output.txt" sout

