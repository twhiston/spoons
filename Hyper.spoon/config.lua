--
-- Created by IntelliJ IDEA.
-- User: twhiston
-- Date: 15.06.17
-- Time: 23:39
-- To change this template use File | Settings | File Templates.
--
-- All of the keys, from here:
-- https://github.com/Hammerspoon/hammerspoon/blob/f3446073f3e58bba0539ff8b2017a65b446954f7/extensions/keycodes/internal.m
-- and the function keys greater than F12 removed.

Config =  {
    binding = {},
    aliases = {},
    keys = {
        { "a", {}, nil, nil },
        { "b", {}, nil, nil },
        { "c", {}, nil, nil },
        { "d", {}, nil, nil },
        { "e", {}, nil, nil },
        { "f", {}, nil, nil },
        { "g", {}, nil, nil },
        { "h", {}, nil, nil },
        { "i", {}, nil, nil },
        { "j", {}, nil, nil },
        { "k", {}, nil, nil },
        { "l", {}, nil, nil },
        { "m", {}, nil, nil },
        { "n", {}, nil, nil },
        { "o", {}, nil, nil },
        { "p", {}, nil, nil },
        { "q", {}, nil, nil },
        { "r", {}, nil, nil },
        { "s", {}, nil, nil },
        { "t", {}, nil, nil },
        { "u", {}, nil, nil },
        { "v", {}, nil, nil },
        { "w", {}, nil, nil },
        { "x", {}, nil, nil },
        { "y", {}, nil, nil },
        { "z", {}, nil, nil },
        { "0", {}, nil, nil },
        { "1", {}, nil, nil },
        { "2", {}, nil, nil },
        { "3", {}, nil, nil },
        { "4", {}, nil, nil },
        { "5", {}, nil, nil },
        { "6", {}, nil, nil },
        { "7", {}, nil, nil },
        { "8", {}, nil, nil },
        { "9", {}, nil, nil },
        { "`", {}, nil, nil },
        { "=", {}, nil, nil },
        { "-", {}, nil, nil },
        { "]", {}, nil, nil },
        { "[", {}, nil, nil },
        { "\'", {}, nil, nil },
        { ";", {}, nil, nil },
        { "\\", {}, nil, nil },
        { ",", {}, nil, nil },
        { "/", {}, nil, nil },
        { ".", {}, nil, nil },
        { "§", {}, nil, nil },
        { "f1", {}, nil, nil },
        { "f2", {}, nil, nil },
        { "f3", {}, nil, nil },
        { "f4", {}, nil, nil },
        { "f5", {}, nil, nil },
        { "f6", {}, nil, nil },
        { "f7", {}, nil, nil },
        { "f8", {}, nil, nil },
        { "f9", {}, nil, nil },
        { "f10", {}, nil, nil },
        { "f11", {}, nil, nil },
        { "f12", {}, nil, nil },
        { "pad.", {}, nil, nil },
        { "pad*", {}, nil, nil },
        { "pad+", {}, nil, nil },
        { "pad/", {}, nil, nil },
        { "pad-", {}, nil, nil },
        { "pad=", {}, nil, nil },
        { "pad0", {}, nil, nil },
        { "pad1", {}, nil, nil },
        { "pad2", {}, nil, nil },
        { "pad3", {}, nil, nil },
        { "pad4", {}, nil, nil },
        { "pad5", {}, nil, nil },
        { "pad6", {}, nil, nil },
        { "pad7", {}, nil, nil },
        { "pad8", {}, nil, nil },
        { "pad9", {}, nil, nil },
        { "padclear", {}, nil, nil },
        { "padenter", {}, nil, nil },
        { "return", {}, nil, nil },
        { "tab", {}, nil, nil },
        { "space", {}, nil, nil },
        { "delete", {}, nil, nil },
        { "help", {}, nil, nil },
        { "home", {}, nil, nil },
        { "pageup", {}, nil, nil },
        { "forwarddelete", {}, nil, nil },
        { "end", {}, nil, nil },
        { "pagedown", {}, nil, nil },
        { "left", {}, nil, nil },
        { "right", {}, nil, nil },
        { "down", {}, nil, nil },
        { "up", {}, nil, nil },
    }
}
--
-- constructor for Square
--
function Config.new()
    local o = {}
    setmetatable(o, { __index = Config }) -- base table added to tell Lua what values are needed to look-up.
    return o
end


