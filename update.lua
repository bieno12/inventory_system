local URL_PREFIX = 'https://raw.githubusercontent.com/bieno12/inventory_system/master/'
local DIR_PREFIX = '/inventory_system/'

local function entry(name)
    return function()
        response = http.get(URL_PREFIX .. name, nil, true)
        print(("%s : %d"):format(name, response.getResponseCode()))
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
