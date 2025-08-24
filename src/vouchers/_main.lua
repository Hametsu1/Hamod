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
        --[[ for k,v in pairs(G.P_CENTER_POOLS['Booster']) do
            v.create_UIBox_old = v.create_UIBox
            v.create_UIBox = function(self)
                if HAMOD.has_voucher('v_hamod_chaos') and HAMOD.chaos.rerolls > 0 then
                    return HAMOD.create_UIBox(self)
                else
                    return v.create_UIBox_old(self)
                end
            end
        end ]]
    end,
    in_pool = function(self, args)
        return false
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

HAMOD.chaos = {rerolls = 1}

HAMOD.create_UIBox = function(self)
    HAMOD.debug('Pack triggered')
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
            {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={
                {n=G.UIT.R,config={minh =0.2}, nodes={}},
                {n=G.UIT.R,config={align = "tm",padding = 0.2, minh = 1.2, minw = 1.8, r=0.15,colour = G.C.GREY, one_press = true, button = 'skip_booster', hover = true,shadow = true, func = 'can_skip_booster'}, nodes = {
                    {n=G.UIT.T, config={text = localize('b_skip'), scale = 0.5, colour = G.C.WHITE, shadow = true, focus_args = {button = 'y', orientation = 'bm'}, func = 'set_button_pip'}}}},
                {n=G.UIT.R,config={align = "tm",padding = 0.2, minh = 1.2, minw = 1.8, r=0.15,colour = G.C.RED, one_press = true, button = 'skip_booster', hover = true,shadow = true, func = 'can_skip_booster'}, nodes = {
                    {n=G.UIT.T, config={text = localize('b_skip'), scale = 0.5, colour = G.C.RED, shadow = true, focus_args = {button = 'y', orientation = 'bm'}, func = 'set_button_pip'}}}}}}}}}}}}
    return t
end