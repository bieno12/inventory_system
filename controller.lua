local view = require "view"
local model = require "model"

local topWindow = view.topWindow
function topWindow.onclick(mouseButton, posX, posY)
    local width,_ = topWindow.getSize()

    if posX < width - 2 then
        local oldterm = term.redirect(topWindow)
        topWindow.text = ""
        topWindow.draw()
        topWindow.setCursorPos(1, 1)
        topWindow.text = read()
        term.redirect(oldterm)
    else
        topWindow.text = ""
    end
    topWindow.draw()


end

local function draw()
	topWindow.draw()
end
-- main loop
while true do
	draw()
	local mouseButton, posX, posY = os.pullEvent("mouse_click")
end