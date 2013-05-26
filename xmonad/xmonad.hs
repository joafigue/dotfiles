--
-- An example, simple ~/.xmonad/xmonad.hs file.
-- It overrides a few basic settings, reusing all the other defaults.
--

import XMonad
import XMonad.Layout.NoBorders


main = xmonad $ defaultConfig
    { borderWidth        = 2
    , terminal           = "urxvt"
    , layoutHook = smartBorders $ layoutHook defaultConfig
    , modMask            = mod4Mask
    , normalBorderColor  = "#cccccc"
    , focusedBorderColor = "#cd8b00" }
