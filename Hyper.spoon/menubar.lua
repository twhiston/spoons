--
-- Created by IntelliJ IDEA.
-- User: twhiston
-- Date: 15.06.17
-- Time: 23:40
-- To change this template use File | Settings | File Templates.
--

local menubar = {}

menubar.bar = hs.menubar.new()
menubar.state = false

menubar.strings = {}
menubar.strings.on = "H"
menubar.strings.off = "-"

function menubar:clicked()
    self:setHyperMenuDisplay(not self.state)
end

-- TODO This needs to actually deal with switching on and off the state
function menubar:setHyperMenuDisplay(state)
    self.state = state
    if state then
        self.bar:setTitle(self.strings.on)
    else
        self.bar:setTitle(self.strings.off)
    end
end

menubar.bar:setClickCallback(hs.fnutils.partial(menubar.clicked, menubar))
menubar:setHyperMenuDisplay(menubar.state)

return menubar