local model = require "model"
local view = {}
local root = term.native()
view.root = root
local w, h = view.root.getSize()
root.width = w
root.height = h


-- topWindow
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

-- contentWindow
local contentWindow = window.create(root, 1, 3, root.width, root.height - 2)
view.contentWindow = contentWindow
contentWindow.setBackgroundColor(colors.orange)
contentWindow.currentPage = 1
w, h = contentWindow.getSize()
contentWindow.width = w
contentWindow.height = h
--prevButton
contentWindow.prevButton = window.create(contentWindow, 1, math.floor(contentWindow.height / 2), 1, 1)
contentWindow.prevButton.setBackgroundColor(colors.blue)
--nextButton
contentWindow.nextButton = window.create(contentWindow, contentWindow.width, math.floor(contentWindow.height / 2), 1, 1)
contentWindow.nextButton.setBackgroundColor(colors.blue)
--placeholders

local function create_placeholder(posX, posY, width, height, color)
    local placeholder = window.create(contentWindow, posX, posY,
        width, height)
    placeholder.setBackgroundColor(color)
    placeholder.item = nil
    placeholder.width = width
    placeholder.height = height
    function placeholder.draw()
        placeholder.clear()
        local lines = strings.wrap("hello there f", placeholder.width)
        --draw name
        for i = 1, #lines do
            placeholder.setCursorPos(1, i)
            placeholder.write(lines[i])
        end
        --draw count
        placeholder.setCursorPos(placeholder.width - 3, placeholder.height)
        placeholder.write(model.getItemCount(placeholder.item))
    end
    return placeholder
end

contentWindow.phs = {}
-- 5 x 3 placeholders
local phwidth = 15
local phheight = 2
for i = 0, 14 do
    local x = (math.floor(i / 5) * phwidth + 1) + 1
    local y = (i % 5) * phheight + 1 + 1
    local newph = create_placeholder(x, y, phwidth, phheight, colors.red)
    table.insert(contentWindow.phs, newph)
end

function contentWindow.draw()
    contentWindow.clear()
    --draw Buttons
    contentWindow.prevButton.write("<")
    contentWindow.nextButton.write(">")

    --draw placeholders
    for _, ph in pairs(contentWindow.phs) do
        ph.draw()
    end

end

function view.root.draw()
    root.clear()
    topWindow.draw()
    contentWindow.draw()
end
return view