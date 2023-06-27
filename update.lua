local URL_PREFIX = 'https://raw.githubusercontent.com/bieno12/inventory_system/master/'
local DIR_PREFIX = '/mcc/'

local function entry(name)
    return function()
        local response = http.get(URL_PREFIX .. name, nil, true)
        local file = fs.open(DIR_PREFIX .. name, 'wb')
        file.write(response.readAll())
        file.close()
    end
end

fs.delete(DIR_PREFIX)
fs.makeDir(DIR_PREFIX)
fs.makeDir(DIR_PREFIX .. 'lib/')

parallel.waitForAll(
    entry('update.lua'),
    entry('controller.lua'),
    entry('view.lua'),
    entry('model.lua')
)
