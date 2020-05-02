-- Import ----------------------------------------------------------------------

import           Graphics.X11.ExtraTypes.XF86
import           XMonad

import           Data.Monoid

import           System.Exit
import qualified System.IO

import qualified Data.Map                       as M
-- import qualified XMonad.Layout.HintedTile       as HT
-- import           XMonad.Layout.LayoutHints
import qualified XMonad.StackSet                as W


import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.InsertPosition
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.UrgencyHook

import           XMonad.Actions.CycleWS
import           XMonad.Actions.WindowGo
import           XMonad.Util.NamedScratchpad

import           XMonad.Layout.MultiColumns
import           XMonad.Layout.ResizableTile
import           XMonad.Layout.ThreeColumns
import           XMonad.Layout.ToggleLayouts
import           XMonad.Layout.WindowNavigation

import           XMonad.Layout.Grid
import           XMonad.Layout.IM
import           XMonad.Layout.NoBorders
import           XMonad.Layout.PerWorkspace     (onWorkspace)
import           XMonad.Layout.Reflect
import           XMonad.Layout.Renamed

import           XMonad.Config.Desktop

import           Control.Monad                  (forM_, join, liftM2)
import           Data.Function                  (on)
import           Data.List                      (sortBy)
import           XMonad.Util.NamedWindows       (getName)
import           XMonad.Util.Run                (runInTerm, safeSpawn)

-- hack to let firefox fullscreen
setFullscreenSupport :: X ()
setFullscreenSupport = withDisplay $ \dpy -> do
    r <- asks theRoot
    a <- getAtom "_NET_SUPPORTED"
    c <- getAtom "ATOM"
    supp <- mapM getAtom ["_NET_WM_STATE_HIDDEN"
                         ,"_NET_WM_STATE_FULLSCREEN" -- XXX Copy-pasted to add this line
                         ,"_NET_NUMBER_OF_DESKTOPS"
                         ,"_NET_CLIENT_LIST"
                         ,"_NET_CLIENT_LIST_STACKING"
                         ,"_NET_CURRENT_DESKTOP"
                         ,"_NET_DESKTOP_NAMES"
                         ,"_NET_ACTIVE_WINDOW"
                         ,"_NET_WM_DESKTOP"
                         ,"_NET_WM_STRUT"
                         ]
    io $ changeProperty32 dpy r a c propModeReplace (fmap fromIntegral supp)

-- Main ------------------------------------------------------------------------

main = do
  xmonad $ withUrgencyHook NoUrgencyHook $ ewmh desktopConfig {
    -- simple stuff
    terminal           = "alacritty",
    focusFollowsMouse  = True,
    borderWidth        = 8,
    modMask            = mod4Mask,
    workspaces         = myWorkspaces,
    normalBorderColor  = "#111111",
    focusedBorderColor = "#9c71C7",

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

myWorkspaces = ["www","ed","sh","bg","im","fs","media","gfx","h","*","**"]

-- Status bars and logging -----------------------------------------------------

wsOutput wsStr = do
  -- h <- System.IO.openFile "/tmp/.xmonad-workspace-log" System.IO.WriteMode
  -- System.IO.hPutStrLn h wsStr
  -- System.IO.hClose h
  io $ appendFile "/tmp/.xmonad-workspace-log" (wsStr ++ "\n")

polibarPP = dynamicLogWithPP $ def {
  ppCurrent = wrap ("%{F#9C71C7}[%{F-}%{F#BEB3CD}") "%{F-}%{F#9C71C7}]%{F-}"
  , ppHidden  = wrap ("%{F" ++ "#BEB3CD" ++ "} ") " %{F-}"
  , ppHiddenNoWindows  = wrap ("%{F" ++ "#6B5A68" ++ "} ") " %{F-}"
  , ppUrgent = wrap ("%{F#8c414f}<%{F-}%{F#BEB3CD}") "%{F-}%{F#8c414f}>%{F-}"
  , ppSep              = "  "
  , ppLayout = wrap ("%{F#9c71C7}") "%{F-}"
  , ppTitle            = (\str -> "")
  , ppSort             = fmap (.namedScratchpadFilterOutWorkspace) $ ppSort defaultPP
  , ppOutput = wsOutput
  }


-- Layouts ---------------------------------------------------------------------
myLayout = windowNavigation $
           avoidStruts $
           smartBorders $
           full $
           mcol
           ||| tcol
           ||| gtile
           ||| grid

  where
  full = toggleLayouts (renamed [Replace "f" ] $ noBorders Full)

  mcol = renamed [Replace "mc"] $ multiCol [1] 1 0.01 (-0.5)
  tcol = renamed [Replace "tc"] $ ThreeCol 1 (3/100) (1/2)

  gtile = renamed [Replace "gt"] $ ResizableTall 1 (2/100) goldenratio []
  goldenratio  = 2/(1+(toRational(sqrt(5)::Double)))

  grid = renamed [Replace "g" ] $ Grid

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
  myFs          = ["nnn_startup"]

  -- resources
  myIgnores = ["desktop", "desktop_window"]

  -- names
  myNames   = ["Google Chrome Options", "Chromium Options", "Firefox Preferences"]


-- Event handling --------------------------------------------------------------

-- myEventHook = hintsEventHook <+> docksEventHook <+> handleEventHook defaultConfig <+> fullscreenEventHook
myEventHook = docksEventHook <+> handleEventHook defaultConfig <+> fullscreenEventHook

-- Startup hook ----------------------------------------------------------------

myStartupHook = do
  setFullscreenSupport
  spawn "sh ~/.config/polybar/launch.sh"
  spawn "sh ~/.config/conky/launch.sh"

-- Scratchpads -----------------------------------------------------------------
-- xprop | grep WM_CLASS

scratchpads = [
  -- RationalRect left top width height
  NS "tmux" "alacritty --class tmux -e tmux new-session -A -s main"
    (resource =? "tmux")
    nonFloating,
  NS "terminal-1" "alacritty --class terminal-1"
    (resource =? "terminal-1")
    (customFloating $ W.RationalRect 0.25 0.52 0.5 0.4),
  NS "terminal-2" "alacritty --class terminal-2"
    (resource =? "terminal-2")
    (customFloating $ W.RationalRect 0.25 0.10 0.5 0.4),

  NS "notes" "alacritty --class notes -e nvim ~/notes"
    (resource =? "notes")
    (customFloating $ W.RationalRect 0.25 0.05 0.5 0.7),

  NS "keepassx" "keepassxc"
    (className =? "KeePassXC")
    (customFloating $ W.RationalRect 0.50 0.05 0.4 0.87),

  NS "gotop" "alacritty --class gotop -e gotop"
    (resource =? "gotop")
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

  NS "nnn" "cd /storage && alacritty --class nnn -e nnn"
    (resource =? "nnn")
    nonFloating
  ]
  where
  role = stringProperty "WM_WINDOW_ROLE"
  wm_name = stringProperty "WM_NAME"

-- Bindings --------------------------------------------------------------------

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

  [ ((modm,                 xK_Return), spawn $ XMonad.terminal conf) -- launch a terminal
  , ((modm,                 xK_x     ), spawn "rofi -modi drun -show")
  , ((modm,                 xK_u     ), spawn "ulauncher")
  , ((modm,                 xK_h     ), focusUrgent)
  , ((modm,                 xK_p     ), spawn "rofi -modi window -show")
  , ((modm,                 xK_c     ), spawn "rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}'")
  , ((modm,                 xK_l     ), spawn "betterlockscreen --lock blur") -- betterlockscreen -u Wallpapers/
  -- , ((modm,   xK_l     ), spawn "dm-tool lock")
  , ((modm,                 xK_b     ), raiseMaybe (spawn "firefox -p default --class firefox-default") (className =? "firefox-default"))
  , ((modm,                 xK_y     ), raiseMaybe (spawn "firefox -p tor --class firefox-tor") (className =? "firefox-tor"))
  , ((modm,                 xK_v     ), raiseMaybe (runInTerm "--class nvim" "nvim") (resource =? "nvim"))
  , ((modm,                 xK_j     ), raiseMaybe (runInTerm "--class tmux" "tmux") (resource =? "tmux"))
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

  , ((modm, xK_k     ), spawn "sh /etc/scripts/pick-color.sh")

  -- bookmarks
  , ((mod1Mask,   xK_m  ), spawn "xdg-open https://mail.google.com/")

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

  -- , ((modm,                 xK_l ), sendMessage $ Go R)
  -- , ((modm,                 xK_h ), sendMessage $ Go L)
  -- , ((modm,                 xK_k ), sendMessage $ Go U)
  -- , ((modm,                 xK_j ), sendMessage $ Go D)
  -- , ((modm .|. controlMask, xK_l ), sendMessage $ Swap R)
  -- , ((modm .|. controlMask, xK_h ), sendMessage $ Swap L)
  -- , ((modm .|. controlMask, xK_k ), sendMessage $ Swap U)
  -- , ((modm .|. controlMask, xK_j ), sendMessage $ Swap D)

  -- custom
  , ((modm, xK_f), sendMessage ToggleLayout)

  , ((modm, xK_F1 ), namedScratchpadAction scratchpads  "terminal-1")
  , ((modm, xK_F2 ), namedScratchpadAction scratchpads  "terminal-2")
  , ((modm, xK_F3), namedScratchpadAction scratchpads "nnn")
  , ((modm, xK_F4 ), namedScratchpadAction scratchpads  "notes")
  , ((modm, xK_F5 ), namedScratchpadAction scratchpads  "keepassx")
  , ((modm, xK_F6 ), namedScratchpadAction scratchpads  "gotop")
  , ((modm, xK_F12 ), namedScratchpadAction scratchpads "upwork")
  , ((modm, xK_i ), namedScratchpadAction scratchpads  "images_browser")

  , ((modm, xK_s), namedScratchpadAction scratchpads  "spacefm")
  , ((modm, xK_g), namedScratchpadAction scratchpads  "gpmdp")
  , ((modm, xK_j), namedScratchpadAction scratchpads  "tmux")

  , ((0,    xK_Print),  spawn "maim -s /storage/screenshots/$(date +%Y-%m-%d-%H-%M-%S)-region.png")
  , ((modm, xK_Delete), spawn "maim -s /storage/screenshots/$(date +%Y-%m-%d-%H-%M-%S)-region.png")

  , ((modm, xK_Print),                  spawn "maim /storage/screenshots/$(date +%Y-%m-%d-%H-%M-%S)-full.png")
  , ((modm .|. controlMask, xK_Delete), spawn "maim /storage/screenshots/$(date +%Y-%m-%d-%H-%M-%S)-full.png")

  , ((modm, xK_Home), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
  , ((modm, xK_Page_Up), spawn "pactl set-sink-volume @DEFAULT_SINK@ +2%")
  , ((modm, xK_Page_Down), spawn "pactl set-sink-volume @DEFAULT_SINK@ -2%")
  , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ +2%")
  , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ -2%")
  , ((0, xF86XK_MonBrightnessUp), spawn "brightnessctl set +10%")
  , ((0, xF86XK_MonBrightnessDown), spawn "brightnessctl set -10%")

  , ((modm, xK_m),  spawn  "pactl set-sink-volume @DEFAULT_SINK@ 20%")
  , ((modm .|. shiftMask, xK_comma),  spawn  "sh ~/.config/polybar/gpmdp-rewind.sh")
  , ((modm .|. shiftMask, xK_period), spawn  "sh ~/.config/polybar/gpmdp-next.sh")
  , ((modm, xK_slash),  spawn  "pactl set-sink-volume @DEFAULT_SINK@ 40%")

  , ((modm .|. controlMask, xK_BackSpace ), spawn "xmonad --recompile && xmonad --restart") -- Restart xmonad
  ]
  ++

  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  --
  [((m .|. modm, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0, xK_minus])
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

  , ((0, 8), (\_ -> prevWS)) -- Switch to previous workspace
  , ((0, 9), (\_ -> nextWS)) -- Switch to next workspace
  ]
