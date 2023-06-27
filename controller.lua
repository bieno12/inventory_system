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



function view.root.onclick(mouseButton, posX, posY)
    --check the topWindow
    local x, y = topWindow.getPosition()
    local w, h = topWindow.getSize()
    if (x <= posX and posX < w + x) and (y <= posY and posY < h + y) then
        topWindow.onclick(mouseButton, posX - x + 1, posY - y + 1)
    end
end



-- main loop
while true do
	view.root.draw()
	local _,mouseButton, posX, posY = os.pullEvent("mouse_click")
    view.root.onclick(mouseButton, posX, posY)
end