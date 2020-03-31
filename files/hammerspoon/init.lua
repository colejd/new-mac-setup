-----------------------------------------------------------------------
-- Jon's Hammerspoon Config File 0.6.0
-----------------------------------------------------------------------

local mic = hs.loadSpoon("MicMuteSwitch")

-------------------------------------
-- Configuration
-------------------------------------

-- Make the default alerts (hs.alert) look nicer.
hs.alert.defaultStyle.strokeColor = { white = 1, alpha = 0 }
hs.alert.defaultStyle.fillColor = { white = 0.05, alpha = 0.75 }
hs.alert.defaultStyle.radius = 10
hs.alert.defaultStyle.atScreenEdge = 1 -- top

-- Disable the slow default window animations.
hs.window.animationDuration = 0

-- Modifier sets that I use
local my_mods = {"cmd", "ctrl", "alt"}

-------------------------------------
-- Functions
-------------------------------------

--
-- Open application with name
--
function open(name)
    return function()
        hs.application.launchOrFocus(name)
        if name == 'Finder' then
            hs.appfinder.appFromName(name):activate()
        end
    end
end

--
-- Bind hotkeys to only work when specific applications are focused
--
bindings = {}

local updateHotkeysForApplications = function()
    local window = hs.window.focusedWindow()
    if window == nil then
        return
    end
    
    local focusedAppName = window:application():name()

    local previouslyEnabled = {}

    for appName, bindingList in pairs(bindings) do
        local enable = string.match(focusedAppName, appName)
        for _, binding in pairs(bindingList) do
            if enable then 
                binding:enable()
                -- Remember that we enabled the keybinding for future passes in this invocation
                previouslyEnabled[binding] = true
            else 
                -- If we didn't just enable the keybinding, disable it. This check lets us bind
                -- the same hotkey to multiple programs.
                if previouslyEnabled[binding] == nil then
                    binding:disable()
                end
            end
        end
    end
end

hs.window.filter.default:subscribe(hs.window.filter.windowFocused, function(window, appName)
    print('Focused ' .. appName)
    updateHotkeysForApplications()
end)

local bindToApplication = function(name, hotkey)
    if bindings[name] == nil then
        bindings[name] = {}
    end
    table.insert(bindings[name], hotkey)
    updateHotkeysForApplications()
end

-------------------------------------
-- Layouts
-------------------------------------

-- hs.screen.allScreens()[1]:name()

-- macbook_monitor = "Color LCD"
-- main_monitor = "PHL 272P7VU"

-- local coding_layout= {
--     { "Xcode",           nil, main_monitor,    hs.layout.maximized, nil, nil },
--     { "Firefox",         nil, main_monitor,    hs.layout.maximized, nil, nil },
--     { "Fork",            nil, main_monitor,    hs.layout.maximized, nil, nil },
--     { "Slack",           nil, macbook_monitor, hs.layout.maximized, nil, nil },
--     { "Microsoft Teams", nil, macbook_monitor, hs.layout.maximized, nil, nil },
-- }
  
-- hs.hotkey.bind(my_mods, '1', function()
--     -- Monitor 1
--     hs.application.launchOrFocus('Xcode')
--     hs.application.launchOrFocus('Firefox')
--     hs.application.launchOrFocus('Fork')
--     -- Monitor 2
--     hs.application.launchOrFocus('Slack')
--     hs.application.launchOrFocus('Microsoft Teams')
  
--     hs.layout.apply(coding_layout)
-- end)

-------------------------------------
-- Shortcuts
-------------------------------------

--
-- Mute microphone
--

-- Convenience values for position arguments you can supply to MicMuteSwitch:edgeAnchors
local left, center, right = 1, 2, 3
local top, center, bottom = 1, 2, 3

-- mic:bindHotkeys({ toggle = {my_mods, "m"}, mute = {my_mods, "g"}, unmute = {my_mods, "h"} })
mic:bindMuteHotkey(my_mods, "M")
	:backgroundFill({ red = 1.0, green = 0, blue = 0, alpha = 0.75 })
	-- :showUnmutedImage(true)
	:edgeAnchors({ x = right, y = bottom })

--
-- Carriage return
--

carriageReturn = hs.hotkey.bind({ "shift" }, "return", function()
    window = hs.window.focusedWindow()
    hs.eventtap.keyStroke("cmd", "right")
    hs.eventtap.keyStroke({}, "return")
end)
bindToApplication("Xcode", carriageReturn)
bindToApplication("Code", carriageReturn)

--
-- Quick open applications
--

hs.hotkey.bind(my_mods, "F", open("Finder"))
hs.hotkey.bind(my_mods, "I", open("Firefox"))
hs.hotkey.bind(my_mods, "X", open("Xcode"))
hs.hotkey.bind(my_mods, "T", open("Microsoft Teams"))
hs.hotkey.bind(my_mods, "C", open("Visual Studio Code"))
hs.hotkey.bind(my_mods, "S", open("Slack"))


--
-- Hammerspoon shortcuts
--

hs.hotkey.bind(my_mods, "R", hs.reload)
hs.hotkey.bind(my_mods, "D", hs.toggleConsole)


--
-- Reflect changes
--

hs.alert.show("Config Loaded")
