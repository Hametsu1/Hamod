SMODS.Atlas{
    key = 'HamodSeals',
    path = 'Seals.png',
    px = 71,
    py = 95
}

local seal_list = {
    'catalyst'
}

for i, entry in ipairs(seal_list) do
    local init, error = SMODS.load_file("src/seals/" .. entry .. ".lua")
    if error then
        HAMOD.error("Error loading Seal '" .. entry .. "'. Message: "  .. error)
    else
        if init then init() end
        HAMOD.debug("Seal '" .. entry .. "' loaded")
    end
end

return function()
    return seal_list
end