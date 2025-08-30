SMODS.Voucher {
    key = 'exile',
    pos = { x = 0, y = 0 },
    config = { extra = { banishes = 3 } },
    unlocked = true,
    discovered = true,
    atlas = 'HamodVouchers',
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "tt_hamod_banish", set = "Other"}
        return { vars = { card.ability.extra.banishes } }
    end,
    redeem = function(self, card)
        if not G.GAME.banishes then G.GAME.banishes = 0 end
        G.GAME.banishes = G.GAME.banishes + card.ability.extra.banishes
    end,
    in_pool = function(self, args)
        return true
    end
}

SMODS.Voucher {
    key = 'exile_plus',
    pos = { x = 0, y = 0 },
    config = { extra = { banishes = 5 } },
    unlocked = true,
    discovered = true,
    atlas = 'HamodVouchers',
    requires = {'v_hamod_exile'},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "tt_hamod_banish", set = "Other"}
        return { vars = { card.ability.extra.banishes } }
    end,
    redeem = function(self, card)
        G.GAME.banishes = (G.GAME.banishes or 0) + card.ability.extra.banishes
    end,
    in_pool = function(self, args)
        return true
    end
}

HAMOD_BUTTONS.register_group({
    key = 'banish',
    get_config = function(card)
        return {
            offset = {x = card.ability.consumeable and 0.45 or 0.41, y = 1},
            align = 'tl'
        }
    end
})

HAMOD_BUTTONS.register_button({
    group = 'banish',
    can_use = function(card)
        return G.GAME.banishes and G.GAME.banishes > 0 and not G.GAME.banned_keys[card.config.center.key]
    end,
    use = function(card)
        G.GAME.banishes = G.GAME.banishes - 1
        G.GAME.banned_keys[card.config.center.key] = true
        SMODS.destroy_cards(card)
    end,
    is_visible = function(card)
        if not G.GAME.banishes or G.GAME.banishes <= 0 then return false end

        local sets = {Joker = true}
        local set = card.config.center.set
        local consumeable = card.ability.consumeable
        
        return sets[set] or consumeable
    end,
    get_styling = function(card)
        return {
            button_color = G.C.RED,
            text = 'Banish ('..G.GAME.banishes..')',
            height = 0,
            width = 1.8,
            text_scale = 0.4
        }
    end
})