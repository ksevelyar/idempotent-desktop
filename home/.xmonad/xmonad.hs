-- Import ----------------------------------------------------------------------

import XMonad

import Data.Monoid

import System.Exit
import System.IO

import qualified XMonad.StackSet as W -- keyboard bindings
import qualified Data.Map        as M -- mouse bindings

import Control.Monad (liftM2)

-- hooks --
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook

import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.EwmhDesktops

-- util --
import XMonad.Util.NamedScratchpad

-- layout --
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.WindowNavigation
import XMonad.Layout.ResizableTile

import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Reflect
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace (onWorkspace)

import XMonad.Config.Desktop
-- import XMonad.Config.Kde

import Data.List (sortBy)
import Data.Function (on)
import Control.Monad (forM_, join)
import XMonad.Util.Run (safeSpawn)
import XMonad.Util.NamedWindows (getName)

-- Main ------------------------------------------------------------------------

main = do
  forM_ [".xmonad-workspace-log", ".xmonad-title-log"] $ \file -> do
  safeSpawn "mkfifo" ["/tmp/" ++ file]

  xmonad $ withUrgencyHook NoUrgencyHook $ ewmh desktopConfig {
    -- simple stuff
    terminal           = "terminator",
    focusFollowsMouse  = True,
    borderWidth        = 1,
    modMask            = mod4Mask,
    workspaces         = myWorkspaces,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,

    -- key bindings
    keys               = myKeys,
    mouseBindings      = myMouseBindings,

    -- hooks, layouts
    layoutHook         = myLayout,
    manageHook         = myManageHook
      <+> manageDocks,
    handleEventHook    = myEventHook,
    logHook            = polibarPP,
    startupHook        = myStartupHook
  }

myNormalBorderColor  = "#111111"
myFocusedBorderColor = "#353b3e"

myWorkspaces= ["www","ed","sh","bg","im","fs","media","gfx","h"]

-- Status bars and logging -----------------------------------------------------

wsOutput wsStr = do
  io $ appendFile "/tmp/.xmonad-workspace-log" (wsStr ++ "\n")

polibarPP = dynamicLogWithPP $ def {
  ppCurrent = wrap ("%{F#9C71C7}[%{F-}%{F#BEB3CD}") "%{F-}%{F#9C71C7}]%{F-}"
  , ppHidden  = wrap ("%{F" ++ "#BEB3CD" ++ "} ") " %{F-}"
  , ppHiddenNoWindows  = wrap ("%{F" ++ "#6B5A68" ++ "} ") " %{F-}"
  , ppUrgent = wrap ("%{F#8c414f}[%{F-}%{F#BEB3CD}") "%{F-}%{F#8c414f}]%{F-}"
  , ppSep              = "  "
  , ppLayout = wrap ("%{F#6B5A68}[%{F-}%{F#9c71C7}") "%{F-}%{F#6B5A68}]%{F-}"
  , ppTitle            = (\str -> "")
  , ppSort             = fmap (.namedScratchpadFilterOutWorkspace) $ ppSort defaultPP
  , ppOutput = wsOutput
  }


-- Layouts ---------------------------------------------------------------------
myLayout = windowNavigation $
           avoidStruts $
           smartBorders $
           full $
           gtile ||| grid

  where
  rt    = ResizableTall 1 (2/100) (1/3) []

  grt   = ResizableTall 1 (2/100) goldenratio []
  goldenratio  = 2/(1+(toRational(sqrt(5)::Double)))


  tile    = renamed [Replace "t" ] $ rt
  mtile   = renamed [Replace "mt"] $ Mirror rt

  gtile   = renamed [Replace "gt"] $ grt


  --grid    = renamed [Replace "g" ] $ spacing 2 $ smartBorders Grid
  grid    = renamed [Replace "g" ] $ Grid

  full    = toggleLayouts (renamed [Replace "f" ] $ noBorders Full)


-- Window Management -----------------------------------------------------------

myManageHook = (composeAll . concat $
  [
    [resource  =? r --> doIgnore           | r <- myIgnores    ]
  , [className =? c --> viewShift "im"     | c <- myIm         ]
  , [className =? c --> viewShift "gfx"    | c <- myGfxs       ]
  , [role      =? r --> doShift   "serv"   | r <- myServ       ]
  , [role      =? r --> doShift   "gen"    | r <- myGen        ]
  , [role      =? r --> doShift   "fs"     | r <- myFs         ]


  , [name      =? n --> doCenterFloat      | n <- myNames      ]
  , [className =? c --> doCenterFloat      | c <- myFloats     ]
  , [className =? c --> doFullFloat        | c <- myFullFloats ]

  , [isDialog       --> doFocusCenterFloat                     ]
  , [isFullscreen   --> doFullFloat                            ]

  , [insertPosition Below Newer                                ]
  , [namedScratchpadManageHook scratchpads                     ]
  ])

  where
  viewShift = doF . liftM2 (.) W.greedyView W.shift

  role = stringProperty "WM_WINDOW_ROLE"
  name = stringProperty "WM_NAME"

  doFocusCenterFloat = doF W.shiftMaster <+> doF W.swapDown <+> doCenterFloat

  doFocusFullFloat   = doFullFloat

  -- classnames
  myFloats      = ["MPlayer", "Vlc", "Lxappearance", "XFontSel"]
  myFullFloats  = ["feh", "mpv", "Zathura", "Mcomix", "smplayer"]
  myIm          = ["Pidgin", "Mumble", "Skype"]
  myGfxs        = ["Inkscape", "Gimp"]

  -- roles
  myServ        = ["rails_dobroserver", "rails_fitlog"]
  myGen         = ["roxterm_startup"]
  myFs          = ["ranger_startup"]

  -- resources
  myIgnores = ["desktop", "desktop_window"]

  -- names
  myNames   = ["Google Chrome Options", "Chromium Options", "Firefox Preferences"]


-- Event handling --------------------------------------------------------------

myEventHook = docksEventHook <+> handleEventHook desktopConfig


-- myDzenXmonad= "LANG=fr dzen2 -y 1060 -x 0 -w 2110 -ta l " ++ myDzenStyle

-- myDzenMonitoring="bash ~/.xmonad/dzen/dzen_xmonad.sh"
myFgColor = "#BEB3CD"
myBgColor = "#0f0f0f"

myFont = "-xos4-terminus-medium-*-*-*-16-*-*-*-*-*-iso10646-*"


-- Startup hook ----------------------------------------------------------------

myStartupHook = do
  spawn "bash ~/.config/polybar/launch.sh"

-- Scratchpads -----------------------------------------------------------------
-- xprop | grep WM_CLASS

scratchpads = [
                     -- RationalRect left top width height
  -- NS "terminal-1" "roxterm --role terminal-1 --session=dev"
  --   (role =? "terminal-1")
  --   (customFloating $ W.RationalRect 0.20 0.49 0.6 0.44),
  -- NS "terminal-2" "roxterm --role terminal-2 --session=sys"
  --   (role =? "terminal-2")
  --   (customFloating $ W.RationalRect 0.20 0.05 0.6 0.44),
  NS "terminal-1" "terminator -bm --role terminal-1 --layout=dev"
    (role =? "terminal-1")
    (customFloating $ W.RationalRect 0.20 0.51 0.6 0.44),
  NS "terminal-2" "terminator -bm --role terminal-2 --layout=sys"
    (role =? "terminal-2")
    (customFloating $ W.RationalRect 0.20 0.05 0.6 0.44),


  -- NS "peak-1" "terminator --role peak-1 -e 'nvim -c startinsert ~/notes/peak-1'"
  --   (role =? "peak-1")
  --   (customFloating $ W.RationalRect 0.10 0.05 0.4 0.44),
  -- NS "peak-2" "terminator --role peak-2 -e 'nvim -c startinsert ~/notes/peak-2'"
  --   (role =? "peak-2")
  --   (customFloating $ W.RationalRect 0.50 0.05 0.4 0.44),

  NS "keepassx" "keepassxc"
    (className =? "KeePassXC")
    (customFloating $ W.RationalRect 0.50 0.05 0.4 0.87),

  NS "gotop" "terminator --role gotop -e gotop"
    (role =? "gotop")
    (customFloating $ W.RationalRect 0.15 0.2 0.7 0.7),
  NS "gpmdp" "google-play-music-desktop-player"
    (className =? "Google Play Music Desktop Player")
    (customFloating $ W.RationalRect 0.15 0.2 0.7 0.7),

  NS "upwork" "upwork"
    (wm_name =? "Time Tracker")
    (customFloating $ W.RationalRect 0.5 0.05 0.4 0.44),

  NS "spacefm" "spacefm"
    (className =? "Spacefm")
    (customFloating $ W.RationalRect 0.1 0.1 0.8 0.8),

  NS "images_browser" "nomacs"
    (className =? "Image Lounge")
    (customFloating $ W.RationalRect 0.01 0.01 0.98 0.98),

  NS "ranger" "cd /storage && terminator --role ranger -e ranger"
    (role =? "ranger")
    nonFloating
  ]
  where
  role = stringProperty "WM_WINDOW_ROLE"
  wm_name = stringProperty "WM_NAME"

-- Bindings --------------------------------------------------------------------

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

  [ ((modm,                 xK_Return), spawn $ XMonad.terminal conf) -- launch a terminal
  , ((modm,                 xK_x     ), spawn "rofi -modi drun -show")
  , ((modm,                 xK_p     ), spawn "rofi -modi window -show")
  , ((modm,                 xK_c     ), spawn "rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}'")
  , ((modm,   xK_l     ), spawn "betterlockscreen --lock blur") -- betterlockscreen -u Wallpapers/
  , ((modm,   xK_l     ), spawn "dm-tool lock") -- betterlockscreen -u Wallpapers/
  , ((modm,   xK_w     ), spawn "rofi -show window -modi window, window -sidebar-mode -lines 6 -width 800")
  , ((modm,                 xK_b     ), spawn "firefox -p default")
  , ((modm,                 xK_y     ), spawn "firefox -p tor")
  , ((modm,                 xK_v     ), spawn "terminator -e 'nvim'")
  , ((modm,                 xK_q     ), kill) -- close focused window
  , ((modm,                 xK_space ), sendMessage NextLayout)  -- Rotate through the available layout algorithms
  , ((modm .|. shiftMask,   xK_space ), sendMessage ToggleStruts )
  , ((modm,                 xK_n     ), refresh) -- Resize viewed windows to the correct size

  , ((modm,                 xK_t     ), withFocused $ windows . W.sink) -- Push window back into tiling

  , ((modm .|. shiftMask,   xK_comma ), sendMessage (IncMasterN 1)) -- Increment the number of windows in the master area
  , ((modm .|. shiftMask,   xK_period), sendMessage (IncMasterN (-1))) -- Deincrement the number of windows in the master area

  -- power
  , ((modm .|. controlMask, xK_r     ), spawn "systemctl reboot")
  , ((modm .|. controlMask, xK_h     ), spawn "systemctl poweroff")

  -- bookmarks
  , ((mod1Mask,   xK_m  ), spawn "xdg-open https://mail.google.com/")
  , ((mod1Mask,   xK_f  ), spawn "xdg-open http://fitlog.ru/ksevelyar")

  -- resizing
  , ((modm .|. shiftMask,   xK_Left  ), sendMessage Shrink)
  , ((modm .|. shiftMask,   xK_Right ), sendMessage Expand)
  , ((modm .|. shiftMask,   xK_Down  ), sendMessage MirrorShrink)
  , ((modm .|. shiftMask,   xK_Up    ), sendMessage MirrorExpand)

  -- navigation
  , ((modm,                 xK_Right ), sendMessage $ Go R)
  , ((modm,                 xK_Left  ), sendMessage $ Go L)
  , ((modm,                 xK_Up    ), sendMessage $ Go U)
  , ((modm,                 xK_Down  ), sendMessage $ Go D)
  , ((modm .|. controlMask, xK_Right ), sendMessage $ Swap R)
  , ((modm .|. controlMask, xK_Left  ), sendMessage $ Swap L)
  , ((modm .|. controlMask, xK_Up    ), sendMessage $ Swap U)
  , ((modm .|. controlMask, xK_Down  ), sendMessage $ Swap D)

  -- custom
  , ((modm, xK_f), sendMessage ToggleLayout)

  , ((modm, xK_F1 ), namedScratchpadAction scratchpads  "terminal-1")
  , ((modm, xK_F2 ), namedScratchpadAction scratchpads  "terminal-2")
  , ((modm, xK_F4 ), namedScratchpadAction scratchpads  "peak-2")
  , ((modm, xK_F12 ), namedScratchpadAction scratchpads "upwork")
  , ((modm, xK_F6 ), namedScratchpadAction scratchpads  "gotop")
  , ((modm, xK_F5 ), namedScratchpadAction scratchpads  "keepassx")
  , ((modm, xK_i ), namedScratchpadAction scratchpads  "images_browser")

  , ((modm, xK_F3), namedScratchpadAction scratchpads "ranger")
  , ((modm, xK_s), namedScratchpadAction scratchpads  "spacefm")
  , ((modm, xK_g), namedScratchpadAction scratchpads  "gpmdp")

  , ((0,    xK_Print), spawn "maim -s /storage/screenshots/$(date +%Y-%m-%d-%H-%M-%S)-region.png")
  , ((modm, xK_Print), spawn "maim /storage/screenshots/$(date +%Y-%m-%d-%H-%M-%S)-full.png")

  , ((modm, xK_o), spawn "sleep 1; xset dpms force off; pkill -f google-play")

  , ((modm, xK_Home), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
  , ((modm, xK_Page_Up), spawn "pactl set-sink-volume @DEFAULT_SINK@ +2%")
  , ((modm, xK_Page_Down), spawn "pactl set-sink-volume @DEFAULT_SINK@ -2%")


  , ((modm, xK_m),  spawn  "pactl set-sink-volume @DEFAULT_SINK@ 12%")
  , ((modm, xK_comma),  spawn  "pactl set-sink-volume @DEFAULT_SINK@ 20%")
  , ((modm, xK_period), spawn  "pactl set-sink-volume @DEFAULT_SINK@ 31%")
  , ((modm, xK_slash),  spawn  "pactl set-sink-volume @DEFAULT_SINK@ 50%")

  , ((modm .|. controlMask, xK_BackSpace ), spawn "xmonad --recompile && xmonad --restart") -- Restart xmonad
  ]
  ++

  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  --
  [((m .|. modm, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  ++

  --
  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  --
  [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-- Mouse bindings: default actions bound to mouse events -----------------------
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

  -- mod-button1, Set the window to floating mode and move by dragging
  [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                     >> windows W.shiftMaster))

  -- mod-button2, Raise the window to the top of the stack
  , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

  -- mod-button3, Set the window to floating mode and resize by dragging
  , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                     >> windows W.shiftMaster))

  -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ]
