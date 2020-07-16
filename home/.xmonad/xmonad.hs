import           Control.Monad                  (forM_, join, liftM2)
import           Data.Function                  (on)
import           Data.List                      (sortBy)
import qualified Data.Map                       as M
import           Data.Monoid
import           Graphics.X11.ExtraTypes.XF86
import           System.Exit
import qualified System.IO
import           XMonad
import           XMonad.Actions.CycleWS
import           XMonad.Actions.WindowGo
import           XMonad.Config.Desktop
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.InsertPosition
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.SetWMName
import           XMonad.Hooks.UrgencyHook
import           XMonad.Layout.Grid
import           XMonad.Layout.IM
import           XMonad.Layout.MultiColumns
import           XMonad.Layout.NoBorders
import           XMonad.Layout.PerWorkspace     (onWorkspace)
import           XMonad.Layout.Reflect
import           XMonad.Layout.Renamed
import           XMonad.Layout.ResizableTile
import           XMonad.Layout.ThreeColumns
import           XMonad.Layout.ToggleLayouts
import           XMonad.Layout.WindowNavigation
import           XMonad.Prompt
import           XMonad.Prompt.ConfirmPrompt
import           XMonad.Prompt.Shell
import qualified XMonad.StackSet                as W
import           XMonad.Util.EZConfig
import           XMonad.Util.NamedScratchpad
import           XMonad.Util.NamedWindows       (getName)
import           XMonad.Util.Run                (runInTerm, safeSpawn)

-- Hack to let firefox fullscreen
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

-- Main
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
    manageHook         = myManageHook,
    handleEventHook    = myEventHook,
    logHook            = polybarPP,
    startupHook        = myStartupHook
  }

myWorkspaces = ["www","ed","sh","bg","im","fs","media","gfx","h","*"]

-- Status bars and logging
wsOutput wsStr = do
  io $ appendFile "/tmp/.xmonad-workspace-log" (wsStr ++ "\n")

polybarPP = dynamicLogWithPP $ def {
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

-- Layouts
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

-- Window Management
-- xprop
-- TODO: refactor to composeOne
myManageHook = manageDocks <+> (composeAll . concat $
  [
    [resource  =? r --> doIgnore           | r <- myIgnores    ]
  , [className =? c --> viewShift "im"     | c <- myIm         ]
  , [className =? c --> viewShift "gfx"    | c <- myGfxs       ]
  , [className =? c --> doShift   "www"    | c <- myWeb        ]
  , [className =? c --> doShift   "*"      | c <- myMisc       ]
  , [role      =? r --> doShift   "fs"     | r <- myFs         ]
  , [resource  =? r --> viewShift "ed"     | r <- myEd         ]
  -- , [role      =? r --> doShift   "serv"   | r <- myServ       ]


  , [className      =? n --> doSmallFloat   | n <- ["Gcr-prompter"]]
  -- , [className =? c --> doFullFloat     | c <- myFullFloats ]
  -- , [className =? c --> doMyCenterFloat      | c <- myFloats   ]

  , [isDialog       --> doFocusCenterFloat                     ]
  , [isFullscreen   --> doFullFloat                            ]
  , [namedScratchpadManageHook scratchpads                     ]
  , [insertPosition Below Newer                             ]
  ])

  where
  viewShift = doF . liftM2 (.) W.greedyView W.shift

  role = stringProperty "WM_WINDOW_ROLE"
  name = stringProperty "WM_NAME"

  doFocusCenterFloat = doF W.shiftMaster <+> doF W.swapDown <+> doMyCenterFloat
  doMyCenterFloat = doRectFloat(W.RationalRect 0.25 0.25 0.5 0.5) --x y w h
  doSmallFloat = doRectFloat(W.RationalRect 0.4 0.4 0.2 0.3) --x y w h

  doFocusFullFloat   = doFullFloat

  -- classnames
  -- myFloats      = ["Lxappearance" ]
  myFullFloats  = ["mpv", "Zathura", "Image Lounge"]
  myIm          = ["TelegramDesktop", "Mumble", "Skype"]
  myEd          = ["nvim"]
  myGfxs        = ["Inkscape", "Gimp-2.10", "cura"]
  myWeb         = ["firefox-work"]
  myMisc        = ["firefox-chill"]

  -- roles
  -- myServ        = ["elixir", "node"]
  myFs          = ["nnn_startup"]

  -- resources
  myIgnores = ["desktop", "desktop_window"]
  -- Move transient windows to their parent:

  -- names
  -- myNames   = ["Google Chrome Options", "Chromium Options", "Firefox Preferences"]

-- Event handling --------------------------------------------------------------

-- myEventHook = hintsEventHook <+> docksEventHook <+> handleEventHook defaultConfig <+> fullscreenEventHook
myEventHook = docksEventHook <+> handleEventHook defaultConfig <+> fullscreenEventHook

-- Startup hook ----------------------------------------------------------------

myStartupHook = do
  spawn "rm /tmp/.xmonad-workspace-log; mkfifo /tmp/.xmonad-workspace-log"
  spawn "sh ~/.fehbg"
  spawn "sh ~/.config/polybar/launch.sh"
  spawn "xsetroot -cursor_name left_ptr"
  spawn "lxqt-policykit-agent"
  spawn "pkill twmnd; twmnd"
  spawn "xxkb"
  spawn "xcape -e 'Super_R=Super_R|X'"
  setFullscreenSupport
  setWMName "LG3D" -- Arduino IDE support

-- Scratchpads -----------------------------------------------------------------
-- xprop | grep WM_CLASS

scratchpads = [
  -- RationalRect left top width height
  NS "tmux" "alacritty --class tmux -e tmux new-session -A -s 🦙"
    (resource =? "tmux")
    nonFloating,

  NS "terminal-1" "alacritty --class terminal-1 --config-file ~/.config/alacritty/alacritty-scratchpad.yml"
    (resource =? "terminal-1")
    (customFloating $ W.RationalRect 0.01 0.5 0.48 0.47),
  NS "terminal-2" "alacritty --class terminal-2 --config-file ~/.config/alacritty/alacritty-scratchpad.yml"
    (resource =? "terminal-2")
    (customFloating $ W.RationalRect 0.51 0.5 0.48 0.47),
  NS "terminal-3" "alacritty --class terminal-3 --config-file ~/.config/alacritty/alacritty-scratchpad.yml"
    (resource =? "terminal-3")
    (customFloating $ W.RationalRect 0.01 0.03 0.48 0.47),
  NS "terminal-4" "alacritty --class terminal-4 --config-file ~/.config/alacritty/alacritty-scratchpad.yml"
    (resource =? "terminal-4")
    (customFloating $ W.RationalRect 0.51 0.03 0.48 0.47),

  NS "images_browser" "nomacs"
    (className =? "Image Lounge")
    nonFloating,
  NS "notes" "alacritty --class notes -e nvim ~/notes"
    (resource =? "notes")
    nonFloating,
  NS "nnn" "cd /storage && alacritty --class nnn -e nnn"
    (resource =? "nnn")
    nonFloating,

  NS "keepassxc" "keepassxc"
    (className =? "KeePassXC")
    (customFloating $ W.RationalRect 0.50 0.05 0.4 0.87),
  NS "qtpass" "qtpass"
    (className =? "QtPass")
    (customFloating $ W.RationalRect 0.50 0.05 0.4 0.87),

  NS "gotop" "alacritty --class gotop -e gotop"
    (resource =? "gotop")
    (customFloating $ W.RationalRect 0.15 0.2 0.7 0.7),

  NS "pavucontrol" "pavucontrol"
    (className =? "Pavucontrol")
    (customFloating $ W.RationalRect 0.1 0.1 0.8 0.8),
  NS "gpmdp" "google-play-music-desktop-player"
    (className =? "Google Play Music Desktop Player")
    (customFloating $ W.RationalRect 0.15 0.2 0.7 0.7),
  NS "spotify" "spotify"
    (resource =? "spotify")
    nonFloating,

  NS "upwork" "upwork"
    (wm_name =? "Time Tracker")
    (customFloating $ W.RationalRect 0.5 0.05 0.4 0.44),

  NS "blueman-manager" "blueman-manager"
    (resource =? ".blueman-manager-wrapped")
    (customFloating $ W.RationalRect 0.1 0.1 0.8 0.8),

  NS "spacefm" "spacefm"
    (className =? "Spacefm")
    (customFloating $ W.RationalRect 0.1 0.1 0.8 0.8),

  NS "astroid" "astroid"
    (className =? ".astroid-wrapped")
    nonFloating
    -- (customFloating $ W.RationalRect 0.1 0.1 0.8 0.8)
  ]
  where
  role = stringProperty "WM_WINDOW_ROLE"
  wm_name = stringProperty "WM_NAME"

-- Bindings
-- https://hackage.haskell.org/package/xmonad-contrib-0.16/docs/XMonad-Util-EZConfig.html
-- M - Win, M1 - Alt, C - Control, S - Shift.
myKeys = \conf -> mkKeymap conf $
    -- launchers
    [ ("M-m", spawn "jgmenu --center")
    , ("M-<Return>", spawn $ XMonad.terminal conf)
    , ("M-x", spawn "rofi -modi drun -matching fuzzy -sorting-method fzf drun -show")
    , ("M-z", spawn "rofi -modi emoji -no-show-match -no-sort -matching normal -show")
    , ("M-=", spawn "rofi -modi calc -show")
    , ("M-c", spawn "rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}'")
    , ("M-l", spawn "tomb close; dm-tool lock")

    -- apps
    , ("M-b", raiseMaybe (spawn "firefox -p work --class firefox-work") (className =? "firefox-work"))
    , ("M-y", raiseMaybe (spawn "firefox -p chill --class firefox-chill") (className =? "firefox-chill"))
    , ("M-v", raiseMaybe (spawn "alacritty --class nvim -e fish -c nvim") (resource =? "nvim"))
    , ("M-t", raiseMaybe (spawn "telegram-desktop") (className =? "TelegramDesktop")) --

    -- sys
    , ("M-q", kill) -- close focused window
    , ("M-`", spawn "id-random-wallpaper")
    , ("M-h", spawn "xdg-open http://docs.lcl")
    , ("M-o", spawn "sleep 0.5; xset dpms force off; pkill -f spotify")
    , ("M-C-r", spawn "systemctl reboot")
    , ("M-C-h", spawn "systemctl poweroff")
    , ("M-k", spawn "id-pick-color")

    -- bookmarks
    , ("M1-b m", spawn "xdg-open https://mail.google.com/")
    , ("M1-b r", spawn "xdg-open https://reddit.com/")
    , ("M1-b g", spawn "xdg-open https://github.com/")
    , ("M1-b l", spawn "xdg-open https://libgen.is/")

    -- layout
    , ("M-<Space>", sendMessage NextLayout)  -- Rotate through the available layout algorithms
    , ("M-S-<Space>", sendMessage ToggleStruts )
    , ("M-,", sendMessage (IncMasterN 1)) -- Increment the number of windows in the master area
    , ("M-.", sendMessage (IncMasterN (-1))) -- Deincrement the number of windows in the master area
    , ("M-S-<Left>", sendMessage Shrink)
    , ("M-S-<Right>", sendMessage Expand)
    , ("M-S-<Down>", sendMessage MirrorShrink)
    , ("M-S-<Up>", sendMessage MirrorExpand)
    , ("M-<Right>",   sendMessage $ Go R)
    , ("M-<Left>",    sendMessage $ Go L)
    , ("M-<Up>",      sendMessage $ Go U)
    , ("M-<Down>",    sendMessage $ Go D)
    , ("M-C-<Right>", sendMessage $ Swap R)
    , ("M-C-<Left>",  sendMessage $ Swap L)
    , ("M-C-<Up>",    sendMessage $ Swap U)
    , ("M-C-<Down>",  sendMessage $ Swap D)
    , ("M-f", sendMessage ToggleLayout)
    , ("M-u", withFocused $ windows . W.sink) -- unfloat, push window back into tiling

    -- scratchpads
    , ("M-a", namedScratchpadAction scratchpads "astroid")
    , ("M-p", namedScratchpadAction scratchpads "qtpass")
    , ("M-C-p", namedScratchpadAction scratchpads "keepassxc")
    , ("<F1>", namedScratchpadAction scratchpads "terminal-1")
    , ("<F2>", namedScratchpadAction scratchpads "terminal-2")
    , ("<F3>", namedScratchpadAction scratchpads "terminal-3")
    , ("<F4>", namedScratchpadAction scratchpads "terminal-4")
    , ("<F6>", namedScratchpadAction scratchpads  "gotop")
    , ("<F7>", namedScratchpadAction scratchpads  "blueman-manager")
    , ("<F8>", namedScratchpadAction scratchpads  "pavucontrol")
    , ("<F9>", namedScratchpadAction scratchpads "spotify")
    , ("<F10>", namedScratchpadAction scratchpads "upwork")
    , ("M-i", namedScratchpadAction scratchpads  "images_browser")

    , ("M-s",namedScratchpadAction scratchpads  "spacefm")
    -- , ("M-g",namedScratchpadAction scratchpads "gpmdp")
    , ("M-j",namedScratchpadAction scratchpads "tmux")
    , ("M-n", namedScratchpadAction scratchpads "nnn")

    , ("<Print>",  spawn "maim -s ~/Screenshots/$(date +%Y-%m-%d-%H-%M-%S)-region.png")
    , ("M-<Print>", spawn "maim ~/Screenshots/$(date +%Y-%m-%d-%H-%M-%S)-full.png")
    , ("M-S-<Print>", spawn "maim --delay=5 --quiet ~/Screenshots/$(date +%Y-%m-%d-%H-%M-%S)-full.png")

    -- for keyaboards without print scrn
    , ("M-C-<Delete>", spawn "maim ~/Screenshots/$(date +%Y-%m-%d-%H-%M-%S)-full.png")
    , ("M-<Delete>", spawn "maim -s ~/Screenshots/$(date +%Y-%m-%d-%H-%M-%S)-full.png")

    , ("M-<Home>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ("M-<Page_Up>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +2%")
    , ("M-<Page_Down>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -2%")
    , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +2%")
    , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -2%")
    , ("<XF86MonBrightnessUp>", spawn "brightnessctl set +10%")
    , ("<XF86MonBrightnessDown>", spawn "brightnessctl set -10%")

    , ("M-,",  spawn  "pactl set-sink-volume @DEFAULT_SINK@ 20%")
    , ("M-.",  spawn  "pactl set-sink-volume @DEFAULT_SINK@ 50%")

    , ("M-C-<Backspace>", spawn "xmonad --restart && systemctl --user restart picom") -- Restart xmonad
    ]
    ++

    [ (m ++ i, windows $ f j)
          | (i, j) <- zip (map show ([1..9]++[0])) (XMonad.workspaces conf)
          , (m, f) <- [("M-", W.view), ("M-S-", W.shift)]
    ]
    ++

    [(m ++ "M-" ++ [key], screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip "wer" [0..]
        , (f, m) <- [(W.view, ""), (W.shift, "S-")]]

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

  , ((modm, 8), (\_ -> prevWS)) -- Switch to previous workspace
  , ((modm, 9), (\_ -> nextWS)) -- Switch to next workspace
  ]
