--
-- An example, simple ~/.xmonad/xmonad.hs file.
-- It overrides a few basic settings, reusing all the other defaults.
--

import XMonad
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.ResizableTile
import XMonad.Util.EZConfig


base_layout = noBorders (Full ||| simpleTabbed )
tall_layout = ResizableTall 1 (3/100) (1/2) []
my_layout = base_layout ||| tall_layout

main = xmonad $ defaultConfig
    { borderWidth        = 5
    , terminal           = "urxvt"
    , layoutHook         = my_layout
    , modMask            = mod4Mask
    , normalBorderColor  = "#222222"
    , focusedBorderColor = "#5555ff"
    }
    `additionalKeysP`
    [ ("M-S-h", sendMessage MirrorShrink),
      ("M-S-l", sendMessage MirrorExpand)
    ]
