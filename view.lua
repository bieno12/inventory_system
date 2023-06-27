local view = {}
local root = term.native()
view.root = root
local w, h = view.root.getSize()
root.width = w
root.height = h

local topWindow = window.create(term.native(), 1, 1, root.width, 1)
view.topWindow = topWindow
topWindow.setBackgroundColor(colors.blue)
topWindow.text = ""
function topWindow.draw()
	local posX, posY = topWindow.getPosition()
    local width, height = topWindow.getSize()
    topWindow.clear()
    topWindow.setCursorPos(1,1)
    topWindow.write(topWindow.text)
    topWindow.setCursorPos(width - 2, 1)
    topWindow.write("XX")
end


function view.root.draw()
    topWindow.draw()
end
return view