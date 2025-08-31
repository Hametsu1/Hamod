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
        -- Safeguard against packs where no hand is drawn and
        -- using many consumeables isn't possible because of it
        G.GAME.boosters_allow_keep_consumeables = true
    end,
    in_pool = function(self, args)
        return false
    end
}

HAMOD_BUTTONS.register_group({
    key = 'select_in_booster',
    overwrites = 'use_button',
    standalone = true,
    is_visible = function(card)
        return card.ability.consumeable and card.area == G.pack_cards and (G.GAME.boosters_allow_keep_consumeables or contains_flag(card, 'allow_keep'))
    end,
    generate_UIBox = function(card)
        local x_off = (card.ability.consumeable and -0.1 or 0)
        return UIBox{
            definition = custom_booster_ui(card),
            config = {
                align = "bmi",
                offset = {x=0,y=0.35},
                parent = card
            }
        }
    end
})

function custom_booster_ui(card)
    return {
        n=G.UIT.ROOT, config = {padding = -0.1,  colour = G.C.CLEAR}, nodes={
            {n=G.UIT.R, config = {padding = 0,  colour = G.C.CLEAR},
                nodes=
                {
                    {n=G.UIT.C, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = (0.5*card.T.w) - 0.25, minh = 1, maxh = 1, maxw = (0.5*card.T.w) - 0.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'use_card', func = 'can_use_consumeable'}, nodes={
                        {n=G.UIT.T, config={text = localize('b_use'), colour = G.C.UI.TEXT_LIGHT, scale = 0.3, padding = 0, shadow = true}}
                    }},
                    {n=G.UIT.C, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = (0.5*card.T.w) - 0.25, maxw = (0.5*card.T.w) - 0.25, minh = 1, maxh = 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'Do you know that this parameter does nothing?', func = 'can_reserve_card'}, nodes={
                        {n=G.UIT.T, config={text = localize('k_keep'), colour = G.C.UI.TEXT_LIGHT, scale = 0.3, padding = 0, shadow = true}}
                    }},
                }
            }
        }
    }
end

-- Credits to betmma: https://github.com/betmma
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