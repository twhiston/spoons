--
-- Created by IntelliJ IDEA.
-- User: twhiston
-- Date: 16.06.17
-- Time: 00:09
-- To change this template use File | Settings | File Templates.
--

local hyperkey = {}

-- Default function for hyper layer
-- sends a key event with all modifiers
-- bool -> string -> void -> side effect
function hyperkey:shortcut(isdown)
    return function(key)
        return function()
            local event = hs.eventtap.event.newKeyEvent({ 'cmd', 'alt', 'shift', 'ctrl' },
                key,
                isdown)
            event:post()
        end
    end
end


function hyperkey:down()
    self:shortcut(true)
end
function hyperkey:up()
    self:shortcut(false)
end

return hyperkey
