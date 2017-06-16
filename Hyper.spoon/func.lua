--
-- Created by IntelliJ IDEA.
-- User: twhiston
-- Date: 15.06.17
-- Time: 23:13
-- To change this template use File | Settings | File Templates.
--
--- Helper function to get the current script path
local function script_path()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*/)")
end

---------
-- HYPER FUNCTIONS
--
-- These functions may be attached to keys when you enter the hyper layer
-- so that you can assign it in the system itself
-- To add a new function include its file here
---------
local hyperFunc = {}
hyperFunc.window = dofile(script_path().."functions/window.lua")
hyperFunc.hyperkey = dofile(script_path().."functions/hyperkey.lua")
hyperFunc.keyboard = dofile(script_path().."functions/keyboard.lua")


-- Exit routine for hyper mode. Use this anywhere you need to exit
-- This is used by the hyper button when in hyper mode to call exit
--local hyper_exit = function()
--    hyper:exit()
--end

return hyperFunc

