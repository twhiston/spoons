--- === Hyper ===
---
--- A new Sample Spoon
---
--- Download: [https://github.com/Hammerspoon/Spoons/raw/master/Spoons/Hyper.spoon.zip](https://github.com/Hammerspoon/Spoons/raw/master/Spoons/Hyper.spoon.zip)

--- Helper function to get the current script path
local function script_path()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*/)")
end

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "Hyper"
obj.version = "0.1"
obj.author = "Tom Whiston <tom.whiston@gmail.com>"
obj.homepage = "https://github.com/tomwhiston/Spoons"
obj.license = "MIT - https://opensource.org/licenses/MIT"

--- Hyper.logger
--- Variable
--- Logger object used within the Spoon. Can be accessed to set the default log level for the messages coming from the Spoon.
obj.logger = hs.logger.new('Hyper')

--- Some internal variable
obj.key_hello = nil

--- Hyper.some_config_param
--- Variable
--- Some configuration parameter
obj.some_config_param = true


-- Use a raw keycode, or a keycode from
-- https://github.com/Hammerspoon/hammerspoon/blob/f3446073f3e58bba0539ff8b2017a65b446954f7/extensions/keycodes/internal.m
local hyperkey_Code = 0x43

-- Strings for display
-- Notification box messages, can be nil
obj.strings = {}
obj.strings.start = "Hyper Hyper!!"
obj.strings.finish = "Exit"

--- Hyper mode key variable
obj.modal = hs.hotkey.modal.new({}, hyperkey_Code)

-- Helper functions that can be attached to keys instead of default hyperkey assignments
obj.func = dofile(script_path() .. "func.lua")

-- Full list of keys for default hyperkey assignments
obj.keys = dofile(script_path() .. "keys.lua")
table.insert(obj.keys,  { "pad*", {}, hs.fnutils.partial(obj.modal.exit, obj.modal), nil })

-- A hyperkey menubar
-- TODO - Make loading this optional
obj.menubar = dofile(script_path() .. "menubar.lua")


function obj.modal:entered()
    obj.menubar:setHyperMenuDisplay(true)
    if obj.strings.start then
        hs.alert.show(obj.strings.start)
    end
end

function obj.modal:exited()
    obj.menubar:setHyperMenuDisplay(false)
    if obj.strings.finish then
        hs.alert.show(obj.strings.finish)
    end
end


-- Hyper wrapper wraps the function so we can pass it properly
-- TODO refactor this
local hyperWrapper = function(func, key)
    return function()
        func(key)
    end
end
--- Hyper:bindHotkeys(mapping)
--- Method
--- Binds hotkeys for Hyper
---
--- Parameters:
--- * mapping - A table containing hotkey objifier/key details for the following items:
--- * hello - Say Hello
function obj:bindHotkeys(mapping)

    for _, key in pairs(mapping) do

        if not key[3] and not key[4] then
            -- if both are nil then we assume that we just want this as a hyperkey shortcut
            -- and assign it in the sytem somewhere
            self.modal:bind(key[2], key[1], nil, hs.fnutils.partial(self.func.hyperkey.down, self.func.hyperkey, key[1]), hs.fnutils.partial(self.func.hyperkey.up, self.func.hyperkey, key[1]), nil)
        elseif not key[4] then
            -- on press only
            self.modal:bind(key[2], key[1], nil, hyperWrapper(key[3], key[1]), nil, nil)
        elseif not key[3] then
            -- on release only
            self.modal:bind(key[2], key[1], nil, nil, hyperWrapper(key[4], key[1]), nil)
        else
            -- on press and on release
            self.modal:bind(key[2], key[1], nil, hyperWrapper(key[3](key[1])), hyperWrapper(key[4](key[1])), nil)
        end
    end
end

return obj
