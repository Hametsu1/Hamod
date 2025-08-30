SMODS.Atlas{
    key = 'HamodConsumables',
    path = 'Consumables.png',
    px = 65,
    py = 94
}

local planet_list = {
    'planet0711b',
    'planet_delta'
}

for i, entry in ipairs(planet_list) do
    local init, error = SMODS.load_file("src/planets/" .. entry .. ".lua")
    if error then
        HAMOD.error("Error loading Planet '" .. entry .. "'. Message: "  .. error)
    else
        if init then init() end
        HAMOD.debug("Planet '" .. entry .. "' loaded")
    end
end

return function()
    return planet_list
end