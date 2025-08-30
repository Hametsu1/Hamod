SMODS.Atlas{
    key = 'HamodVouchers',
    path = 'Vouchers.png',
    px = 60,
    py = 94
}

local voucher_list = {
    'chaos',
    'exile',
    'repack',
}

for i, entry in ipairs(voucher_list) do
    local init, error = SMODS.load_file("src/vouchers/" .. entry .. ".lua")
    if error then
        HAMOD.error("Error loading Voucher '" .. entry .. "'. Message: "  .. error)
    else
        if init then init() end
        HAMOD.debug("Voucher '" .. entry .. "' loaded")
    end
end

return function()
    return voucher_list
end