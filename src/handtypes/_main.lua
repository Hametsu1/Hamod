local hand_list = {
    'nice'
}

for i, entry in ipairs(hand_list) do
    local init, error = SMODS.load_file("src/handtypes/" .. entry .. ".lua")
    if error then
        HAMOD.error("Error loading PokerHand '" .. entry .. "'. Message: "  .. error)
    else
        if init then init() end
        HAMOD.debug("PokerHand '" .. entry .. "' loaded")
    end
end

return function()
    return hand_list
end