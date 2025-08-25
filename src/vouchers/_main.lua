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
        if not G.GAME.chaos then G.GAME.chaos = {rerolls_max = 0, rerolls_left = 0} end

        add_booster_rerolls(card.ability.extra.rerolls)
    end,
    in_pool = function(self, args)
        return true
    end
}

function add_booster_rerolls(amount)
    if amount == 0 then return end
    
    G.GAME.chaos.rerolls_max = G.GAME.chaos.rerolls_max + amount
    if G.GAME.chaos.rerolls_max < 0 then G.GAME.chaos.rerolls_max = 0 end

    if G.GAME.chaos.rerolls_left > G.GAME.chaos.rerolls_max then G.GAME.chaos.rerolls_left = G.GAME.chaos.rerolls_max
    elseif amount > 0 then G.GAME.chaos.rerolls_left = G.GAME.chaos.rerolls_left + amount end
end


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

hamod_create_UIBox = function(self)
    if not G.GAME.chaos or not G.GAME.chaos.rerolls_max or G.GAME.chaos.rerolls_max == 0 then return false end

    local _size = math.max(1, SMODS.OPENED_BOOSTER.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))
    G.pack_cards = CardArea(
        G.ROOM.T.x + 9 + G.hand.T.x, G.hand.T.y,
        math.max(1,math.min(_size,5))*G.CARD_W*1.1,
        1.05*G.CARD_H,
        {card_limit = _size, type = 'consumeable', highlight_limit = 1, negative_info = true})

    local t = {n=G.UIT.ROOT, config = {align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15}, nodes={
        {n=G.UIT.R, config={align = "cl", colour = G.C.CLEAR,r=0.15, padding = 0.1, minh = 2, shadow = true}, nodes={
            {n=G.UIT.R, config={align = "cm"}, nodes={
            {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                {n=G.UIT.C, config={align = "cm", r=0.2, colour = G.C.CLEAR, shadow = true}, nodes={
                    {n=G.UIT.O, config={object = G.pack_cards}},}}}}}},
        {n=G.UIT.R, config={align = "cm"}, nodes={}},
        {n=G.UIT.R, config={align = "tm"}, nodes={
            {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={}},
            {n=G.UIT.C,config={align = "tm", padding = 0.05}, nodes={
                UIBox_dyn_container({
                    {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 4}, nodes={
                        {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                            {n=G.UIT.O, config={object = DynaText({string = localize(self.group_key or ('k_booster_group_'..self.key)), colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.7, maxw = 4, pop_in = 0.5})}}}},
                        {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                            {n=G.UIT.O, config={object = DynaText({string = {localize('k_choose')..' '}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}},
                            {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'pack_choices'}}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}}}},}}
                }),}},
            {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 4.8}, nodes={ -- breitere Spalte
    {n=G.UIT.R,config={minh =0.2}, nodes={}}, -- Spacer oben
    {n=G.UIT.R,config={align = "cm", padding = 0.1}, nodes={
        -- Skip-Button (links)
        {n=G.UIT.C,config={align = "cm", padding = 0.1}, nodes={
            {n=G.UIT.R,config={align = "tm",padding = 0.2, minh = 1.2, minw = 1.8, r=0.15,colour = G.C.GREY, one_press = true, button = 'skip_booster', hover = true,shadow = true, func = 'can_skip_booster'}, nodes = {
                {n=G.UIT.T, config={text = localize('b_skip'), scale = 0.5, colour = G.C.WHITE, shadow = true, func = 'set_button_pip'}}
            }}
        }},
        -- Neuer Button (rechts)
                
            
        {n=G.UIT.C,config={align = "cm", padding = 0}, 
            nodes=
            {
                {n=G.UIT.C,config={align = "cm", padding = 0},
                    nodes = {
                        -- Reroll pack button
                        {
                            n=G.UIT.R,
                            config={
                                ref_table = self,
                                align = "tm",
                                padding = 0.15,
                                minh = 0.30,
                                minw = 1.55,
                                r=0.15,
                                colour = G.C.RED,
                                one_press = false,
                                button = 'reroll_pack',
                                hover = true,
                                shadow = true,
                                func = 'can_reroll_pack'
                            }, 
                            nodes = {
                                {
                                    n=G.UIT.R,
                                    config={align = "cm", maxw = 1.3},
                                    nodes={
                                        {
                                            n=G.UIT.T,
                                            config={text = localize('k_reroll'), scale = 0.4, colour = G.C.WHITE, shadow = true, func = 'set_button_pip'}
                                        },
                                    }
                                },
                            --[[ {n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={
                                {n=G.UIT.T, config={ref_table = HAMOD.chaos, ref_value = 'rerolls', scale = 0.3, colour = G.C.WHITE, shadow = true, func = 'set_button_pip'}}
                            }} ]]
                            }
                        },
                        -- Redraw hand button
                        {
                            n=G.UIT.R,
                            config={
                                ref_table = self,
                                align = "tm",
                                padding = 0.15,
                                minh = 0.30,
                                minw = 1.55,
                                r=0.15,
                                colour = G.C.RED,
                                one_press = false,
                                button = 'redraw_hand',
                                hover = true,
                                shadow = true,
                                func = 'can_redraw_hand'
                            }, 
                            nodes = {
                                {
                                    n=G.UIT.R,
                                    config={align = "cm", maxw = 1.3},
                                    nodes={
                                        {
                                            n=G.UIT.T,
                                            config={text = 'Redraw', scale = 0.4, colour = G.C.WHITE, shadow = true, func = 'set_button_pip'}
                                        },
                                    }
                                },
                            }
                        },
                    }
                },
                -- Display rerolls remaining
                {n=G.UIT.C,config={align = "cm", padding = 0.2},
                    nodes = {
                        {n=G.UIT.R, config={align = "cm", maxw = 1.3},
                            nodes=
                            {
                                {n=G.UIT.T, config={ref_table = G.GAME.chaos, ref_value = 'rerolls_left', scale = 0.4, colour = G.C.WHITE, shadow = true, func = 'set_button_pip'}}
                            }
                        }
                    }
                }
            }             
        },
    }}
}}}}}}}}
    return t
end

G.FUNCS.can_reroll_pack = function(e)

    if G.pack_cards and (G.pack_cards.cards[1]) and G.GAME.chaos.rerolls_left > 0 then 
        e.config.colour = G.C.GREEN
        e.config.button = 'reroll_pack' 
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end

end

G.FUNCS.reroll_pack = function(e) -- only works for consumeables
    stop_use()
    local c1 = e.config.ref_table
    G.GAME.chaos.rerolls_left = G.GAME.chaos.rerolls_left - 1
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
            local card_count = #G.pack_cards.cards
            for i = #G.pack_cards.cards,1, -1 do
                local c = G.pack_cards:remove_card(G.pack_cards.cards[i])
                c:remove()
                c = nil
            end

            play_sound('other1')
            
            for i = 1, card_count do
                local _card_to_spawn = c1:create_card(self, i)
                local card

                if type((_card_to_spawn or {}).is) == 'function' and _card_to_spawn:is(Card) then
                    card = _card_to_spawn
                else
                    card = SMODS.create_card(_card_to_spawn)
                end

                G.pack_cards:emplace(card)
                card:juice_up()
            end
            return true
        end
    }))  
end

G.FUNCS.can_redraw_hand = function(e)

    if #G.hand.cards > 0 and G.pack_cards and (G.pack_cards.cards[1]) and G.GAME.chaos.rerolls_left > 0 then 
        e.config.colour = G.C.PALE_GREEN
        e.config.button = 'redraw_hand' 
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end

end

G.FUNCS.redraw_hand = function(e) -- only works for consumeables
    stop_use()
    local c1 = e.config.ref_table
    local card_count = #G.hand.cards
    G.GAME.chaos.rerolls_left = G.GAME.chaos.rerolls_left - 1
    
    G.FUNCS.draw_from_hand_to_deck()
    
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.35,
        func = function()
            G.FUNCS.draw_from_deck_to_hand(card_count)
            return true
        end
    }))
end