SMODS.Voucher {
    key = 'repack',
    pos = { x = 0, y = 0 },
    config = { extra = { rerolls = 1, redraws = 1 } },
    unlocked = true,
    discovered = true,
    atlas = 'HamodVouchers',
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "tt_booster_reroll", set = "Other"}
        info_queue[#info_queue+1] = {key = "tt_booster_redraw", set = "Other"}
        return { vars = {card.ability.extra.rerolls, card.ability.extra.redraws} }
    end,
    redeem = function(self, card)
        add_booster_rerolls({rerolls = card.ability.extra.rerolls, redraws = card.ability.extra.redraws})
    end,
    in_pool = function(self, args)
        return true
    end
}

SMODS.Voucher {
    key = 'repack_plus',
    pos = { x = 0, y = 0 },
    config = { extra = { rerolls = 2, redraws = 2 } },
    unlocked = true,
    discovered = true,
    atlas = 'HamodVouchers',
    requires = { 'v_hamod_repack' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "tt_booster_reroll", set = "Other"}
        info_queue[#info_queue+1] = {key = "tt_booster_redraw", set = "Other"}
        return { vars = {card.ability.extra.rerolls, card.ability.extra.redraws} }
    end,
    redeem = function(self, card)
        add_booster_rerolls({rerolls = card.ability.extra.rerolls, redraws = card.ability.extra.redraws})
    end,
    in_pool = function(self, args)
        return true
    end
}