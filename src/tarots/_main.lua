local tarot_list = {
    'redraw',
    'reflection',
}

for i, entry in ipairs(tarot_list) do
    local init, error = SMODS.load_file("src/tarots/" .. entry .. ".lua")
    if error then
        HAMOD.error("Error loading Tarot '" .. entry .. "'. Message: "  .. error)
    else
        if init then init() end
        HAMOD.debug("Tarot '" .. entry .. "' loaded")
    end
end

return function()
    return tarot_list
end