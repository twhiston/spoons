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


function App.launch(id)
    hs.application.launchOrFocus(id)
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




