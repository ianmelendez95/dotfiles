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
                          ("<XF86MonBrightnessUp>", spawn "brightnessctl set +200"),
                          ("<XF86MonBrightnessDown>", spawn "brightnessctl set 200-"),
                          ("<XF86AudioRaiseVolume>", spawn "amixer -q sset Master 5%+"),
                          ("<XF86AudioLowerVolume>", spawn "amixer -q sset Master 5%-"),
                          ("<XF86AudioMute>", spawn "amixer -q sset Master toggle")
                        ]
