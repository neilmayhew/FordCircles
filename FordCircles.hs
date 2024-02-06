{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}

import Data.Colour.RGBSpace (uncurryRGB)
import Data.Colour.RGBSpace.HSV (hsv)
import Data.Ratio ((%), denominator, numerator)
import Diagrams.Backend.SVG.CmdLine (B, mainWith)
import Diagrams.Prelude hiding (font)
import Graphics.SVGFonts.PathInRect (drop_rect, fit_height)
import Graphics.SVGFonts.ReadFont (PreparedFont, loadFont)
import Graphics.SVGFonts.Text (TextOpts, svgText, textFont)

main :: IO ()
main = do
  font <- loadFont "fonts/Roboto-Medium.svg"
  mainWith $
    bgFrame 0.1 darkslategrey $
    withEnvelope (rect 1 0.5 # alignBL :: Diagram B) $
      fordCircles font 40

fordCircles :: PreparedFont (N B) -> Integer -> Diagram B
fordCircles font n = mconcat
  [ fordCircle font (colour k) h k
  | k <- [1 .. n]
  , h <- [0 - (k-1) .. k + (k-1)]
  , gcd h k == 1
  ]
 where
  colour i = uncurryRGB sRGB $ hsv (180 + realToFrac (i - 1) * 45) 0.35 0.9

fordCircle :: PreparedFont (N B) -> Colour (N B) -> Integer -> Integer -> Diagram B
fordCircle font color h k =
  let r = 1 % (2 * k * k)
      x = h % k
      y = r
   in translate (realToFrac <$> x ^& y) $
      scale (realToFrac r) $
      mconcat
      [ fraction font x # fc white
      , circle 1 # lw none # fc color
      ]

fraction :: PreparedFont (N B) -> Rational -> Diagram B
fraction font r =
  mconcat . map center $
    [ toText "—"
    , vsep 0.2 $ map (toText . show) [numerator r, denominator r]
    ]
 where
  toText = lw none . stroke . drop_rect . fit_height 1 . svgText defOpts { textFont = font }
  defOpts = def :: TextOpts (N B)
