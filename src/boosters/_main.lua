SMODS.Atlas({
    key = "HamodBoosters", 
    path = "Boosters.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

local booster_list = {
    'chaos',
    'joker',
    'voucher'
}

for i, entry in ipairs(booster_list) do
    local init, error = SMODS.load_file("src/boosters/" .. entry .. ".lua")
    if error then
        HAMOD.error("Error loading Boosters '" .. entry .. "'. Message: "  .. error)
    else
        if init then init() end
        HAMOD.debug("Boosters '" .. entry .. "' loaded")
    end
end

return function()
    return booster_list
end