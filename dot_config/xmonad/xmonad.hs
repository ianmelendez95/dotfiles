import XMonad
import XMonad.Util.EZConfig

main :: IO ()
main =
  xmonad $
    def
      { modMask = mod4Mask,
        terminal = "alacritty",
        focusedBorderColor = "#8F4E8B",
        normalBorderColor = "#453A62"
      }
      `additionalKeysP` [ ("M-c", spawn "google-chrome-stable"),
                          ("<XF86MonBrightnessUp>", spawn "brightnessctl set +10%"),
                          ("<XF86MonBrightnessDown>", spawn "brightnessctl set 10%-")
                        ]
