{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_hsc2hs (
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
version = Version [0,68,6] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/o/.cabal/store/ghc-8.8.3/hsc2hs-0.68.6-1cae88760a677f9c2743db8211f4f70d12127c0337569d283fc809a2d8d200bf/bin"
libdir     = "/home/o/.cabal/store/ghc-8.8.3/hsc2hs-0.68.6-1cae88760a677f9c2743db8211f4f70d12127c0337569d283fc809a2d8d200bf/lib"
dynlibdir  = "/home/o/.cabal/store/ghc-8.8.3/hsc2hs-0.68.6-1cae88760a677f9c2743db8211f4f70d12127c0337569d283fc809a2d8d200bf/lib"
datadir    = "/home/o/.cabal/store/ghc-8.8.3/hsc2hs-0.68.6-1cae88760a677f9c2743db8211f4f70d12127c0337569d283fc809a2d8d200bf/share"
libexecdir = "/home/o/.cabal/store/ghc-8.8.3/hsc2hs-0.68.6-1cae88760a677f9c2743db8211f4f70d12127c0337569d283fc809a2d8d200bf/libexec"
sysconfdir = "/home/o/.cabal/store/ghc-8.8.3/hsc2hs-0.68.6-1cae88760a677f9c2743db8211f4f70d12127c0337569d283fc809a2d8d200bf/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "hsc2hs_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "hsc2hs_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "hsc2hs_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "hsc2hs_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "hsc2hs_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "hsc2hs_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
