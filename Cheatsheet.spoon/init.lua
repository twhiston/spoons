--- === Cheatsheet ===
---
--- A new Spoon
---
--- Template rendering has a requirement on https://github.com/bungle/lua-resty-template
---
--- Download: [https://github.com/Hammerspoon/Spoons/raw/master/Spoons/Cheatsheet.spoon.zip](https://github.com/Hammerspoon/Spoons/raw/master/Spoons/Cheatsheet.spoon.zip)

--- Helper function to get the current script path
local function script_path()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*/)")
end

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "Cheatsheet"
obj.version = "0.1"
obj.author = "Tom Whiston <tom.whiston@gmail.com>"
obj.homepage = "https://github.com/twhiston/Spoons"
obj.license = "MIT - https://opensource.org/licenses/MIT"

--- Cheatsheet.logger
--- Variable
--- Logger object used within the Spoon. Can be accessed to set the default log level for the messages coming from the Spoon.
obj.logger = hs.logger.new('Cheatsheet')

--- Initialize a default keycode combo, can be overriden by via bindHotKeys cheat value
obj.keyCode = {}
obj.keyCode.Modifiers = { "shift", "command" }
obj.keyCode.Key = ","

obj.commandEnum = {
    cmd = '⌘',
    shift = '⇧',
    alt = '⌥',
    ctrl = '⌃',
}

--- Cheatsheet:bindHotkeys(mapping)
--- Method
--- Binds hotkeys for Cheatsheet
---
--- Parameters:
--- * mapping - A table containing hotkey objifier/key details for the following items:
--- * cheat - Combination to start the cheat screen
--- * * - All other entries will be treated as exit calls, so you can bind multiple escape keys if desired
--- *
function obj:bindHotkeys(mapping)

    -- If the user did not specify the cheat modifiers then use the default
    if (mapping["cheat"] ~= nil) then
        print("set cheat mapping")
        self.keyCode.Modifiers = mapping["cheat"][1]
        self.keyCode.Key = mapping["cheat"][2]
        mapping["cheat"] = nil
    end

    self.cheatsheetM = hs.hotkey.modal.new(self.keyCode.Modifiers, self.keyCode.Key)

    --Bind the enter function to the modal
    self.cheatsheetM.entered = hs.fnutils.partial(function() self:showCheatsheet() end, self)

    for k, v in pairs(mapping) do
        self.cheatsheetM:bind(v[1], v[2], nil, hs.fnutils.partial(self.exit, self), nil, nil)
    end
end

--- Cheatsheet:exit()
function obj:exit()

    -- If a cheatsheet exists cache it
    if self.cheatsheetView ~= nil then
        self.cheatsheetView:hide()
        if self.cstimer == nil then
            --caches the view for 10 minutes, for faster access if needed again as html does not need to be redrawn
            self.cstimer = hs.timer.doAfter(10 * 60, function()
                if self.cheatsheetView ~= nil then
                    self.cheatsheetView:delete()
                    self.cheatsheetView = nil
                end
            end)
        else
            self.cstimer:start()
        end
    end
    -- Exit the modal
    self.cheatsheetM:exit()
end

--- Cheatsheet:showCheatsheet()
function obj:showCheatsheet()

    if not self.cheatsheetView then
        local mainScreen = hs.screen.mainScreen()
        local mainRes = mainScreen:fullFrame()
        local localMainRes = mainScreen:absoluteToLocal(mainRes)
        local cheatsheet_rect = mainScreen:localToAbsolute({
            x = (localMainRes.w - 1080) / 2,
            y = (localMainRes.h - 600) / 2,
            w = 1080,
            h = 600,
        })
        self.cheatsheetView = hs.webview.new(cheatsheet_rect):windowTitle("CheatSheet"):windowStyle("utility"):allowGestures(true):allowNewWindows(false):level(hs.drawing.windowLevels.modalPanel)
    end
    if self.cstimer ~= nil and self.cstimer:running() then
        self.cstimer:stop()
    end
    self.cheatsheetView:show()
    local html = self:generateHtml()
   -- print(hs.inspect(html))
    self.cheatsheetView:html(html)
end

--- Cheatsheet:getAllMenuItems()
--- This is pretty ugly, could do with a refactor
function obj:getAllMenuItems(t)
    local menu = ""
    for pos, val in pairs(t) do
        if type(val) == "table" then
            -- TODO: Remove menubar items with no shortcuts in them
            if val.AXRole == "AXMenuBarItem" and type(val.AXChildren) == "table" then
                menu = menu .. "<ul class='col col" .. pos .. "'>"
                menu = menu .. "<li class='title'><strong>" .. val.AXTitle .. "</strong></li>"
                menu = menu .. self:getAllMenuItems(val.AXChildren[1])
                menu = menu .. "</ul>"
            elseif val.AXRole == "AXMenuItem" and not val.AXChildren then
                if not (val.AXMenuItemCmdChar == '' and val.AXMenuItemCmdGlyph == '') then
                    local CmdModifiers = ''
                    for _, value in pairs(val.AXMenuItemCmdModifiers) do
                        CmdModifiers = CmdModifiers .. self.commandEnum[value]
                    end
                    local CmdChar = val.AXMenuItemCmdChar
                    local CmdGlyph = hs.application.menuGlyphs[val.AXMenuItemCmdGlyph] or ''
                    local CmdKeys = CmdChar .. CmdGlyph
                    menu = menu .. "<li><div class='cmdModifiers'>" .. CmdModifiers .. " " .. CmdKeys .. "</div><div class='cmdtext'>" .. " " .. val.AXTitle .. "</div></li>"
                end
            elseif val.AXRole == "AXMenuItem" and type(val.AXChildren) == "table" then
                menu = menu .. self:getAllMenuItems(val.AXChildren[1])
            end
        end
    end
    return menu
end

--- Cheatsheet:generateHtml()
function obj:generateHtml()
    local focusedApp = hs.application.frontmostApplication()
    local appTitle = focusedApp:title()
    local allMenuItems = focusedApp:getMenuItems()
    -- TODO - refactor this to use templating system instead
    local myMenuItems = self:getAllMenuItems(allMenuItems)

    local template = dofile(script_path() .. "resty/template.lua")
    local tc = template.compile(script_path() .. "view.html")
    local output = tc { appTitle = appTitle, menuItems = myMenuItems }
    return output

end

return obj