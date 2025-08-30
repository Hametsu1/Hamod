SMODS.Consumable {
    key = 'catalyst',
    set = 'Spectral',
    atlas = 'HamodConsumables',
    pos = { x = 1, y = 0 },
    config = {extra = {seal = 'hamod_catalyst'}, max_highlighted = 1},
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_SEALS[card.ability.extra.seal]
        return { 
            vars = { 
                localize { type = 'name_text', key = card.ability.extra.seal..'_seal', set = 'Other'},
                card.ability.max_highlighted,
                colours = {G.P_SEALS[card.ability.extra.seal].badge_colour}
            }
        }
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
}