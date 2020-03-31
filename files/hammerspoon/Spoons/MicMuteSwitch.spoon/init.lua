--- === MicMuteSwitch ===
---
--- System-level microphone mute switch. Supports persistent, configurable screen overlay to indicate mute state.
--- Some of this code is pulled from https://github.com/Hammerspoon/Spoons/blob/master/Source/MicMute.spoon/init.lua. The same license applies here.
---
--- Download: (This link doesn't exist yet) [https://github.com/Hammerspoon/Spoons/raw/master/Spoons/MicMuteSwitch.spoon.zip](https://github.com/Hammerspoon/Spoons/raw/master/Spoons/MicMute.spoon.zip)

local obj={}
obj.__index = obj

-- Metadata
obj.name = "MicMuteSwitch"
obj.version = "1.0"
obj.author = "colejd <jon@jons.website>"
obj.homepage = "https://jons.website"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Internal function used to find our location, so we know where to load files from
local function script_path()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*/)")
end
obj.spoonPath = script_path()

local canvas = require("hs.canvas")
local screen = require("hs.screen")

-----------------------------
-- Configurable Properties
-----------------------------

--- MicMuteSwitch.latchTimeout
--- Variable
--- If you hold the mute key longer than this number of seconds, the mute will revert when you let go. Basically, this results in push-to-talk/push-to-mute behavior.
---
--- Default value: 0.25
local latchTimeout = 0.25

function obj:latchTimeout(timeout)
	if timeout then
		latchTimeout = timeout
		self:refresh()
		return self
	else
		return latchTimeout
	end
end

--- MicMuteSwitch.imageSize
--- Variable
--- Size of the image
---
--- Default value: `{ w = 100, h = 100 }`
local imageSize = { w = 64, h = 64 }

function obj:imageSize(size)
	if size then
		imageSize = size
		self:refresh()
		return self
	else
		return imageSize
	end
end

--- MicMuteSwitch.padding
--- Variable
--- Padding around the image
---
--- Default value: `0`
local padding = 0

function obj:padding(newPadding)
	if newPadding then
		padding = newPadding
		self:refresh()
		return self
	else
		return padding
	end
end

--- MicMuteSwitch.screenEdgeOffset
--- Variable
--- Offset from screen edges if adjacent
---
--- Default value: `40`
local screenEdgeOffset = 40

function obj:screenEdgeOffset(newOffset)
	if newOffset then
		screenEdgeOffset = newOffset
		self:refresh()
		return self
	else
		return screenEdgeOffset
	end
end

--- MicMuteSwitch.backgroundFill
--- Variable
--- Fill color for background (see docs for color info: https://www.hammerspoon.org/docs/hs.canvas.html)
---
--- Default value: `{ white = 0.05, alpha = 0.75 }`
local backgroundFill = { white = 0.05, alpha = 0.75 }
-- { red = 1.0, green = 0, blue = 0, alpha = 0.75 }

function obj:backgroundFill(color)
	if color then
		backgroundFill = color
		self:refresh()
		return self
	else
		return backgroundFill
	end
end

--- MicMuteSwitch.edgeAnchors
--- Variable
--- Holds two values determining where the element will anchor itself.
---
--- For x: 1 = left, 2 = center, 3 = right
--- For y: 1 = top, 2 = center, 3 = bottom
---
--- Default value: `{ x = 1, y = 1 }`
local edgeAnchors = { x = 3, y = 3 }

function obj:edgeAnchors(newAnchors)
	if newAnchors then
		edgeAnchors = newAnchors
		self:refresh()
		return self
	else
		return edgeAnchors
	end
end

local showUnmutedImage = false

function obj:showUnmutedImage(show)
	if show then
		showUnmutedImage = show
		self:refresh()
		return self
	else
		return showUnmutedImage
	end
end

--- MicMuteSwitch.unmutedBackgroundFill
--- Variable
--- Fill color for background when unmuted (see docs for color info: https://www.hammerspoon.org/docs/hs.canvas.html)
--- Only effective when `showUnmutedImage() == true`
---
--- Default value: `{ white = 0.05, alpha = 0.75 }`
local unmutedBackgroundFill = { white = 0.05, alpha = 0.75 }

function obj:unmutedBackgroundFill(color)
	if color then
		unmutedBackgroundFill = color
		self:refresh()
		return self
	else
		return unmutedBackgroundFill
	end
end

-----------------------------
-- Private Functions
-----------------------------

local isMuted = function()
	return hs.audiodevice.defaultInputDevice():muted()
end

-- Refresh the UI to reflect microphone mute state
function obj:refresh()
	-- Rebuild drawables
	if obj.drawables then 
		obj.drawables:delete()
	end
	obj.drawables = self:createImageAlert(edgeAnchors.x, edgeAnchors.y)

	-- Show or hide drawables based on state
	if isMuted() or obj.showUnmutedImage() then
		obj.drawables:show()
	else
		obj.drawables:hide()
	end
end

-- Creates a persistent alert backed by an image.
-- xPositionIndex: 1 for left, 2 for center, 3 for bottom
-- yPositionIndex: 1 for top, 2 for center, 3 for bottom
function obj:createImageAlert(xPositionIndex, yPositionIndex)
	local screenFrame = screen.mainScreen():fullFrame()

	local screenEdgeOffset = self.screenEdgeOffset()
	local imageSizeX = self.imageSize().w
	local imageSizeY = self.imageSize().h
	local margin = self.padding()

	local overallWidth = imageSizeX + (margin * 2)
	local overallHeight = imageSizeY + (margin * 2)

	local xPositions = {
		screenFrame.x + screenEdgeOffset, -- left
		screenFrame.x + (screenFrame.w / 2) - (overallWidth / 2), -- center
		screenFrame.x + screenFrame.w - overallWidth - screenEdgeOffset, -- right
	}

	local yPositions = {
		screenFrame.y + screenEdgeOffset, -- top
		screenFrame.y + (screenFrame.h / 2) - (overallHeight / 2), -- center
		screenFrame.y + screenFrame.h - overallHeight - screenEdgeOffset, -- bottom
	}

	local drawingFrame = {
		x = xPositions[xPositionIndex],
		y = yPositions[yPositionIndex],
		w = overallWidth,
		h = overallHeight,
	}

	local imageFrame = {
		x = margin,
		y = margin,
		w = imageSizeX,
		h = imageSizeY,
	}
	
	local imagePath = ""
	local fill = nil
	if isMuted() then 
		imagePath = "micOff.png"
		fill = self.backgroundFill()
	else
		imagePath = "micOn.png"
		fill = self.unmutedBackgroundFill()
	end

	image = hs.image.imageFromPath(self.spoonPath.."/"..imagePath):template(false)

    
	local draw = canvas.new({
		x = xPositions[xPositionIndex],
		y = yPositions[yPositionIndex],
		w = overallWidth,
		h = overallHeight,
	})

    draw[1] = {
		type = "rectangle",
		action = "fill",
		roundedRectRadii = { xRadius = 10, yRadius = 10 },
        fillColor = fill,
	}
	
    draw[2] = {
        type = "image", 
        padding = margin,
        image = image,
		imageScaling = "scaleToFit",
		frame = {
			x = margin,
			y = margin,
			w = imageSizeX,
			h = imageSizeY,
		},
	}
	draw:behavior(hs.canvas.windowBehaviors.canJoinAllSpaces | hs.canvas.windowBehaviors.stationary)
	draw:level(canvas.windowLevels.cursor)

    return draw
end

-----------------------------
-- Public Functions
-----------------------------

-- Mutes the system microphon and toggles mute in Zoom via the menu bar.
-- You could extend this to mute other specific applications as well.
function obj:toggleMicMute()
	local mic = hs.audiodevice.defaultInputDevice()
	local zoom = hs.application('Zoom')
	if mic:muted() then
		self:unmute()
	else
		self:mute()
	end
end

function obj:mute()
	local mic = hs.audiodevice.defaultInputDevice()
	local zoom = hs.application('Zoom')

	mic:setMuted(true)
	if zoom then
		local ok = zoom:selectMenuItem('Mute Audio')
		if not ok then
			hs.timer.doAfter(0.5, function()
				zoom:selectMenuItem('Mute Audio')
			end)
		end
	end
	self:refresh()
end

function obj:unmute()
	local mic = hs.audiodevice.defaultInputDevice()
	local zoom = hs.application('Zoom')

	mic:setMuted(false)
	if zoom then
		local ok = zoom:selectMenuItem('Unmute Audio')
		if not ok then
			hs.timer.doAfter(0.5, function()
				zoom:selectMenuItem('Unmute Audio')
			end)
		end
	end
	self:refresh()
end

-- Ripped from https://github.com/Hammerspoon/Spoons/blob/master/Source/MicMute.spoon/init.lua
function obj:bindHotkeys(mapping)
	if self.muteHotkey then
		self.muteHotkey:delete()
	end

	if mapping["toggle"] then
		local mods = mapping["toggle"][1]
		local key = mapping["toggle"][2]

		if self.latchTimeout() then
			self.muteHotkey = hs.hotkey.bind(mods, key, function()
				self:toggleMicMute()
				self.time_since_mute = hs.timer.secondsSinceEpoch()
			end, function()
				if hs.timer.secondsSinceEpoch() > self.time_since_mute + self.latchTimeout() then
					self:toggleMicMute()
				end
			end)
		else
			self.muteHotkey = hs.hotkey.bind(mods, key, function()
				self:toggleMicMute()
			end)
		end
	end

	if mapping["mute"] then
		local mods = mapping["mute"][1]
		local key = mapping["mute"][2]

		hs.hotkey.bind(mods, key, function()
			self:mute()
		end)
	end

	if mapping["unmute"] then
		local mods = mapping["unmute"][1]
		local key = mapping["unmute"][2]

		hs.hotkey.bind(mods, key, function()
			self:unmute()
		end)
	end

	return self
end

-- Convenience function for assigning the mute hotkey.
function obj:bindMuteHotkey(mods, key, latchTimeout)
	if latchTimeout ~= nil then 
		self.latchTimeout(latchTimeout) 
	end
	return self:bindHotkeys({ toggle = {mods, key} })
end

function obj:init()
	obj.time_since_mute = 0
	obj.drawables = nil
	
	self:refresh()

    hs.audiodevice.watcher.setCallback(function(arg)
		if string.find(arg, "dIn ") then
			self:refresh()
		end
	end)
	hs.audiodevice.watcher.start()
end

return obj