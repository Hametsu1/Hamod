SMODS.Atlas{
    key = 'HamodVouchers',
    path = 'Vouchers.png',
    px = 60,
    py = 94
}

SMODS.Voucher {
    key = 'chaos',
    pos = { x = 0, y = 0 },
    config = { extra = {  } },
    unlocked = true,
    discovered = true,
    atlas = 'HamodVouchers',
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    redeem = function(self, card)
    end,
    in_pool = function(self, args)
        return false
    end
}

SMODS.Voucher {
    key = 'mayhem',
    pos = { x = 0, y = 0 },
    config = { extra = { rerolls = 1 } },
    unlocked = true,
    discovered = true,
    atlas = 'HamodVouchers',
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "tt_booster_reroll", set = "Other"}
        return { vars = {card.ability.extra.rerolls } }
    end,
    redeem = function(self, card)
        add_booster_rerolls(card.ability.extra.rerolls)
    end,
    in_pool = function(self, args)
        return true
    end
}

-- Credits to betmma: https://github.com/betmma
local G_UIDEF_use_and_sell_buttons_ref=G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
    if (card.area == G.pack_cards and G.pack_cards) and card.ability.consumeable then --Add a use button
        if G.STATE == G.STATES.SMODS_BOOSTER_OPENED and SMODS.OPENED_BOOSTER and HAMOD.has_voucher('v_hamod_chaos') then
            return {
                n=G.UIT.ROOT, config = {padding = -0.1,  colour = G.C.CLEAR}, nodes={
                    {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, minh = 0.7*card.T.h, maxw = 0.7*card.T.w - 0.15, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'use_card', func = 'can_use_consumeable'}, nodes={
                    {n=G.UIT.T, config={text = localize('b_use'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
                    }},
                    {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, maxw = 0.9*card.T.w - 0.15, minh = 0.1*card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'Do you know that this parameter does nothing?', func = 'can_reserve_card'}, nodes={
                    {n=G.UIT.T, config={text = localize('b_select'),colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
                    }},
                    {n=G.UIT.R, config = {align = "bm", w=7.7*card.T.w}},
                    {n=G.UIT.R, config = {align = "bm", w=7.7*card.T.w}},
                    {n=G.UIT.R, config = {align = "bm", w=7.7*card.T.w}},
                    {n=G.UIT.R, config = {align = "bm", w=7.7*card.T.w}},
                    -- I can't explain it
                }}
        end
    end
    return G_UIDEF_use_and_sell_buttons_ref(card)
end

G.FUNCS.can_reserve_card = function(e)

    if #G.consumeables.cards < G.consumeables.config.card_limit then 
        e.config.colour = G.C.GREEN
        e.config.button = 'reserve_card' 
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end

end

G.FUNCS.reserve_card = function(e) -- only works for consumeables
    local c1 = e.config.ref_table
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
            c1.area:remove_card(c1)
            c1:add_to_deck()
            if c1.children.price then c1.children.price:remove() end
            c1.children.price = nil
            if c1.children.buy_button then c1.children.buy_button:remove() end
            c1.children.buy_button = nil
            remove_nils(c1.children)
            G.consumeables:emplace(c1)
            G.GAME.pack_choices = G.GAME.pack_choices - 1
            if G.GAME.pack_choices <= 0 then
            G.FUNCS.end_consumeable(nil, delay_fac)
            end
            return true
        end
    }))
end
--