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
--obj.key_hello = nil

--- Hyper.some_config_param
--- Variable
--- Some configuration parameter
--obj.some_config_param = true


-- Strings for display
-- Notification box messages, can be nil
-- TODO - add optional method to set config such as this via a table
obj.strings = {}
obj.strings.start = "Hyper Hyper!!"
obj.strings.finish = "Exit"

-- Helper functions that can be attached to keys instead of default hyperkey assignments
obj.func = dofile(script_path() .. "func.lua")

-- Full list of keys for default hyperkey assignments
obj.config = dofile(script_path() .. "config.lua")

-- A hyperkey menubar
-- TODO - Make loading this optional
obj.menubar = dofile(script_path() .. "menubar.lua")



-- Hyper wrapper wraps the function so we can pass it properly
-- TODO remove this in favour of hs.func tools
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
--- * binding - A table containing the hotkey identifier for the initial hyper key binding. Will also be used to exit hyper layer
--- * keys - A table of keys, modifiers and functions to pass. These override the default hyperkey mappings. You can bind any key
function obj:bindHotkeys(config)

    self.config = config

    --- Hyper mode key variable
    self.modal = hs.hotkey.modal.new(config.binding[2], config.binding[1])
    function self.modal:entered()
        obj.menubar:setHyperMenuDisplay(true)
        if obj.strings.start then
            hs.alert.show(obj.strings.start)
        end
    end

    function self.modal:exited()
        obj.menubar:setHyperMenuDisplay(false)
        if obj.strings.finish then
            hs.alert.show(obj.strings.finish)
        end
    end
    -- TODO - dedupe
    table.insert(self.config.keys, { self.config.binding[1], self.config.binding[2], hs.fnutils.partial(self.modal.exit, self.modal), nil })


    for _, key in pairs(config.keys) do

        if not key[3] and not key[4] then
            -- if both are nil then we assume that we just want this as a hyperkey shortcut
            -- and assign it in the sytem somewhere
            self.modal:bind(key[2], key[1], nil, hs.fnutils.partial(self.func.hyperkey.down, self.func.hyperkey, key[1]), hs.fnutils.partial(self.func.hyperkey.up, self.func.hyperkey, key[1]), nil)
        else
            -- on press and on release
            self.modal:bind(key[2], key[1], nil, key[3], key[4], nil)
        end
    end
end

return obj
