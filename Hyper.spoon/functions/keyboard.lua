--
-- Created by IntelliJ IDEA.
-- User: twhiston
-- Date: 16.06.17
-- Time: 10:44
-- To change this template use File | Settings | File Templates.
--

local kbd = {}

local find = function(tbl, val)
    for k, v in pairs(tbl) do
        if v == val then return k end
    end
    return nil
end


function kbd:nextLayout()
    local layouts = hs.keycodes.layouts()
    local current = hs.keycodes.currentLayout()
    local index = find(layouts,current)
    local nextLayout = next(layouts,index)
    if not nextLayout then
        nextLayout = 1
    end
    hs.keycodes.setLayout(layouts[nextLayout])
end


return kbd

