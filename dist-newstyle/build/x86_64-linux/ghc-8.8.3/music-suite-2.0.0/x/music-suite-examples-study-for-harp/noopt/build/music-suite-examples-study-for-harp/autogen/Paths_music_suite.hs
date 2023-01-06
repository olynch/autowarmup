{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_music_suite (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [2,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/o/.cabal/bin"
libdir     = "/home/o/.cabal/lib/x86_64-linux-ghc-8.8.3/music-suite-2.0.0-inplace-music-suite-examples-study-for-harp"
dynlibdir  = "/home/o/.cabal/lib/x86_64-linux-ghc-8.8.3"
datadir    = "/home/o/.cabal/share/x86_64-linux-ghc-8.8.3/music-suite-2.0.0"
libexecdir = "/home/o/.cabal/libexec/x86_64-linux-ghc-8.8.3/music-suite-2.0.0"
sysconfdir = "/home/o/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "music_suite_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "music_suite_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "music_suite_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "music_suite_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "music_suite_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "music_suite_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
