SMODS.Atlas{
    key = 'HamodJokers',
    path = 'Jokers.png',
    px = 71,
    py = 95
}

local joker_list = {
    'straight_shooter',
    'color_rush',
    'fools_arcana',
    'high_roller',
    --'empty_pockets',
    'foil_fanatic',
    'the_usual',
    'doppelganger',
    'coupon_clown',
    'siphon',
    'juicy_joker'
}

for i, entry in ipairs(joker_list) do
    local init, error = SMODS.load_file("src/jokers/" .. entry .. ".lua")
    if error then
        HAMOD.error("Error loading Joker '" .. entry .. "'. Message: "  .. error)
    else
        if init then init() end
        HAMOD.debug("Joker '" .. entry .. "' loaded")
    end
end

return function()
    return joker_list
end