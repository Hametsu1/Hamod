local deck_list = {
    'deck1'
}

for i, entry in ipairs(deck_list) do
    local init, error = SMODS.load_file("src/decks/" .. entry .. ".lua")
    if error then
        HAMOD.error("Error loading Deck '" .. entry .. "'. Message: "  .. error)
    else
        if init then init() end
        HAMOD.debug("Deck '" .. entry .. "' loaded")
    end
end

return function()
    return deck_list
end