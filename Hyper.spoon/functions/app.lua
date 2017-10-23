--
-- Created by IntelliJ IDEA.
-- User: twhiston
-- Date: 17.06.17
-- Time: 01:15
-- To change this template use File | Settings | File Templates.
--

--TODO - expand to allow history
App = {
    currentApp = '',
    previousApp = ''
}

-- record the current and previously active apps so we can use a key to switch between them
function App:watcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        self.previousApp = self.currentApp
        self.currentApp = appName
    end
end

function App:toggle()
    local state = hs.application.launchOrFocus(self.previousApp)
    if not state then
        hs.notify.new({ title = "App Switch", informativeText = "Could not jump to previous app" }):send()
    end
end

function App:pathClip()
    -- TODO this needs to be configurable
    if self.currentApp == 'Finder' then
        hs.eventtap.keyStroke({"option", "command"}, "c")
        hs.alert.show(hs.pasteboard.readString())
    else
        hs.eventtap.keyStroke({"cmd"}, "c")
    end
end


function App.launch(id)
    hs.application.launchOrFocus(id)
end

function App:finderRefresh()
    if self.currentApp == 'Finder' then
        hs.osascript.applescript([[
tell application "Finder"
	set theWindows to every window
	repeat with i from 1 to number of items in theWindows
		set this_item to item i of theWindows
		set theView to current view of this_item
		if theView is list view then
			set current view of this_item to icon view
		else
			set current view of this_item to list view
		end if
		set current view of this_item to theView
	end repeat
end tell
        ]])
        hs.alert.show("Refreshed")
    end
end

--
-- constructor for App
--
function App.new()
    local o = {}
    setmetatable(o, { __index = App }) -- base table added to tell Lua what values are needed to look-up.
    o.appWatcher = hs.application.watcher.new(hs.fnutils.partial(o.watcher, o))
    o.appWatcher:start()
    return o
end




