{-# LANGUAGE OverloadedStrings, FlexibleContexts, TypeFamilies #-}

module Main where

import Music.Prelude
import Music.Pitch
import Control.Lens (set, (%~), (&))
import qualified Data.Stream.Infinite as Stream
import Data.Stream.Infinite (Stream (..))
import qualified Data.List.NonEmpty as NE

import Control.Monad.Random

-- |
-- Bela Bartok: Wandering (excerpt)
-- From Mikrokosmos, vol. III
--
-- Inspired by the Abjad transcription
--

randomPitch :: MonadRandom m => m Pitch
randomPitch = uniform [a_,bb_,b_,c,cs,d,eb,e,f,fs,g_,gs_]

randomHardPitch :: MonadRandom m => m Pitch
randomHardPitch = uniform [db, fs]

randomMode :: MonadRandom m => m (Mode Interval Pitch)
randomMode = uniform [pureMinorScale, majorScale]

randomModeFromQuality :: MonadRandom m => MajorMinor -> m (Mode Interval Pitch)
randomModeFromQuality MajorMode = return majorScale
randomModeFromQuality MinorMode = uniform [pureMinorScale, harmonicMinorScale, melodicMinorScaleUp]

scaleUp :: Scale Interval Pitch -> Stream Pitch
scaleUp s = p :> pos
  where (_,p,pos) = tabulate s

repeated :: Semigroup s => Int -> s -> s
repeated n = foldl1 (<>) . replicate n

modeUpDown :: Mode Interval Pitch -> Mode Interval Pitch
modeUpDown m = m <> (Mode $ NE.reverse $ negateV <$> generator m)

unpackScale :: Pitch -> MajorMinor -> Mode Interval Pitch -> (KeySignature, [Pitch])
unpackScale p quality m = (ks, scaleToList s <> [p])
  where
    ks = key p quality
    s = scale p $ modeUpDown $ repeated 3 m

fleschThreeOctavePattern :: [Duration]
fleschThreeOctavePattern = replicate 42 1 ++ [6]

applyDurations :: [Duration] -> [Music] -> [Music]
applyDurations = zipWith (flip (|*))

fleschScale :: (KeySignature, [Pitch]) -> Music
fleschScale (ks,s) = set parts' (solo violin) $ keySignature ks $ (pseq $ timedS)
  where timedS = (|/ 12) $ applyDurations fleschThreeOctavePattern $ fromPitch <$> s

triadicDrillPiece :: Scale Interval Pitch -> Int -> [Pitch]
triadicDrillPiece s p = (ss Stream.!!) <$> intervals
  where
    intervals = (+p) <$> [0,2,4,2]
    ss = scaleUp s

triadicDrillPractice :: Scale Interval Pitch -> [Pitch]
triadicDrillPractice s = do
  i <- [0..14]
  concat $ replicate 4 $ triadicDrillPiece s i

triadicDrill :: Scale Interval Pitch -> [Pitch]
triadicDrill s = do
  i <- [0..14] ++ reverse [0..13]
  triadicDrillPiece s i

withDurations :: [Duration] -> [Pitch] -> Music
withDurations ds ps = pseq $ applyDurations ds $ fromPitch <$> ps

evenNotes :: [Pitch] -> Music
evenNotes = withDurations (repeat 1)

main = do
  quality <- uniform [MajorMode, MinorMode]
  m <- randomModeFromQuality quality
  p <- randomHardPitch
  let music1 = fleschScale $ unpackScale p quality m
  let music2 = (|/ 8) $ evenNotes $ triadicDrill $ scale p m
  defaultMain (music1 |> music2)
  -- defaultMain $ compress 4 $ ((a |> b |> c) |/ 3) |> d |> c |> a
