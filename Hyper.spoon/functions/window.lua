--
-- Created by IntelliJ IDEA.
-- User: twhiston
-- Date: 15.06.17
-- Time: 23:32
-- To change this template use File | Settings | File Templates.
--

local window = {}

--- window:north()
--- Method
--- Select window north
function window:north()
    if hs.window.focusedWindow() then
        hs.window.focusedWindow():focusWindowNorth()
    end
end
function window:south()
    if hs.window.focusedWindow() then
        hs.window.focusedWindow():focusWindowSouth()
    end
end
function window:east()
    if hs.window.focusedWindow() then
        hs.window.focusedWindow():focusWindowEast()
    end
end
function window:west()
    if hs.window.focusedWindow() then
        hs.window.focusedWindow():focusWindowWest()
    end
end

window.helper = {}

function window.helper:wpleft(f, max)
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    return f
end

function window.helper:wpright(f, max)
    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    return f
end

function window.helper:wptop(f, max)
    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h / 2
    return f
end


function window.helper:wpbottom(f, max)
    f.x = max.x
    f.y = max.y + (max.h / 2)
    f.w = max.w
    f.h = max.h / 2
    return f
end

function window.helper:wpfull(f, max)
    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h
    return f
end


window.helper.winpos = {
    left = window.helper.wpleft,
    right = window.helper.wpright,
    up = window.helper.wptop,
    down = window.helper.wpbottom,
    full = window.helper.wpfull
}

function window:placeWindow(region)
    return function()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()
        f = self.helper.winpos[region](f, max)
        win:setFrame(f)
    end
end

function window:minimizeWindow()
    local win = hs.window.focusedWindow()
    win:minimize()
end

return window