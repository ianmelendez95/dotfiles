import XMonad

import XMonad.Util.EZConfig

main :: IO ()
main = xmonad $ def 
     { modMask = mod4Mask
     , terminal = "alacritty"
     } `additionalKeysP` 
        [ ("M-c", spawn "google-chrome-stable")
	]
