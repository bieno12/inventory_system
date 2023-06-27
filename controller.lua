local view = require "view"
local model = require "model"

local topWindow = view.topWindow
local buttonsBar = view.buttonsBar
local statusBar = view.statusBar
local contentWindow = view.contentWindow
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

--buttons bar stuff
function buttonsBar.storeButton.onclick(mouseButton, posX, posY)
    statusBar.leftText = "storing.."
    statusBar.draw()
    model.storeBuffer()
    statusBar.leftText = "finished storing"
    statusBar.draw()
end

function buttonsBar.updateButton.onclick(mouseButton, posX, posY)
    statusBar.leftText = "scanning chests.."
    statusBar.draw()
    model.scan_chests()
    statusBar.leftText = "finished scanning"
    statusBar.draw()
end

function buttonsBar.onclick(mouseButton, posX, posY)
    --store button
    local x, y = buttonsBar.storeButton.getPosition()
    local w, h = buttonsBar.storeButton.getSize()
    if (x <= posX and posX < w + x) and (y <= posY and posY < h + y) then
        buttonsBar.storeButton.onclick(mouseButton, posX - x + 1, posY - y + 1)
    end

    --update button
    local x, y = buttonsBar.updateButton.getPosition()
    local w, h = buttonsBar.updateButton.getSize()
    if (x <= posX and posX < w + x) and (y <= posY and posY < h + y) then
        buttonsBar.updateButton.onclick(mouseButton, posX - x + 1, posY - y + 1)
    end
end
--end buttons bar

--contentWindow

function contentWindow.prevButton.onclick(mouseButton, posX, posY)
    if contentWindow.currentPage <= 1 then return end
    contentWindow.currentPage = contentWindow.currentPage - 1
end

function contentWindow.nextButton.onclick(mouseButton, posX, posY)
    contentWindow.currentPage = contentWindow.currentPage + 1
end

function contentWindow.onclick(mouseButton, posX, posY)
    --check if prevButton is clicked
    local x, y = contentWindow.prevButton.getPosition()
    local w, h = contentWindow.prevButton.getSize()
    if (x <= posX and posX < w + x) and (y <= posY and posY < h + y) then
        contentWindow.prevButton.onclick(mouseButton, posX - x + 1, posY - y + 1)
    end
    --check if nextButton is clicked
    x, y = contentWindow.nextButton.getPosition()
    w, h = contentWindow.nextButton.getSize()
    if (x <= posX and posX < w + x) and (y <= posY and posY < h + y) then
        contentWindow.nextButton.onclick(mouseButton, posX - x + 1, posY - y + 1)
    end
    
end


function view.root.onclick(mouseButton, posX, posY)
    --check the topWindow
    local x, y = topWindow.getPosition()
    local w, h = topWindow.getSize()
    if (x <= posX and posX < w + x) and (y <= posY and posY < h + y) then
        topWindow.onclick(mouseButton, posX - x + 1, posY - y + 1)
    end
    --statusbar
    --buttonsBar
    x, y = buttonsBar.getPosition()
    w, h = buttonsBar.getSize()
    if (x <= posX and posX < w + x) and (y <= posY and posY < h + y) then
        buttonsBar.onclick(mouseButton, posX - x + 1, posY - y + 1)
    end

    --contentWindow
    x, y = contentWindow.getPosition()
    w, h = contentWindow.getSize()
    if (x <= posX and posX < w + x) and (y <= posY and posY < h + y) then
        contentWindow.onclick(mouseButton, posX - x + 1, posY - y + 1)
    end
end



-- main loop
while true do
	view.root.draw()
	local _,mouseButton, posX, posY = os.pullEvent("mouse_click")
    view.root.onclick(mouseButton, posX, posY)
end