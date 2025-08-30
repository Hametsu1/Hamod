local spectral_list = {
    'reroll',
    'catalyst',
    'exile'
}

for i, entry in ipairs(spectral_list) do
    local init, error = SMODS.load_file("src/spectrals/" .. entry .. ".lua")
    if error then
        HAMOD.error("Error loading Spectral '" .. entry .. "'. Message: "  .. error)
    else
        if init then init() end
        HAMOD.debug("Spectral '" .. entry .. "' loaded")
    end
end

return function()
    return spectral_list
end