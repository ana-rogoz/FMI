import Control.Monad (liftM, ap)
import Data.Char (toUpper)

type Input = String
type Output = String

newtype StateIO a
  = State { runState :: (Input, Output) -> (a, (Input, Output)) }

instance Monad StateIO where
  return a = State (\ s -> (a, s))
  ma >>= k = State g
    where g state =   let (a, aState) = runState ma state
                      in  runState (k a) aState

instance Applicative StateIO where
  pure      = return
  mf <*> ma = do { f <- mf; a <- ma; return (f a) }

instance Functor StateIO where
  fmap f ma = do { a <- ma; return (f a) }

class Monad io => IOClass io where
  getchar :: io Char
  putchar :: Char -> io ()
  runIO :: io () -> Input -> Output

--newtype StateIO a
--  = State { runState :: (Input, Output) -> (a, (Input, Output)) }

instance IOClass StateIO where
  putchar c = State (\(inp, out) -> ((), (inp, out ++ [c])))
  getchar = State (\(c:inp, out) -> (c, (inp, out)))
  runIO cmd inp = snd $ snd $ runState cmd (inp, "")

putstr :: IOClass io => String -> io ()
putstr [] = return ()
putstr (c:xs)
  = do
    putchar c
    putstr xs

putstrln :: IOClass io => String -> io ()
putstrln s = do
  putstr s
  putchar '\n'

getline :: IOClass io => io String
getline = do
  c <- getchar
  case c of
    '\n' -> return []
    _ -> do
      s <- getline
      return (c:s)

-- interact :: String -> String -> IO ()

convert :: IOClass io => io () -> IO ()
convert = interact . runIO

echo :: IOClass io => io ()
echo = do
  s <- getline
  if null s
    then return ()
    else do
      putstrln (map toUpper s)
      echo

echoIO :: IO ()
echoIO = do
  s <- getLine
  if null s
    then return ()
    else do
      putStrLn (map toUpper s)
      echoIO

newtype LazyIO a = LazyIO { runLazyIO :: Input -> (a, Input, Output) }

instance Monad LazyIO where
  return x = LazyIO (\input -> (x, input, ""))
  ma >>= k = LazyIO f
    where
    f input = let (x, inputx, outputx) = runLazyIO ma input
                  (y, inputy, outputy) = runLazyIO (k x) inputx
              in  (y, inputy, outputx ++ outputy)

instance Functor LazyIO where
  fmap = liftM

instance Applicative LazyIO where
  pure = return
  (<*>) = ap

-- newtype LazyIO a = LazyIO { runLazyIO :: Input -> (a, Input, Output) }
-- class Monad io => IOClass io where
--   getchar :: io Char
--   putchar :: Char -> io ()
--   runIO :: io () -> Input -> Output

instance IOClass LazyIO where
  getchar = LazyIO (\(c:input) -> (c, input, ""))
  putchar c = LazyIO (\input -> ((), input, [c]))
  runIO cmd input = third (runLazyIO cmd input)
    where third (_, _, x) = x
