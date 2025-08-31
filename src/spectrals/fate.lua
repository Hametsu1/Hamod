SMODS.Consumable {
    key = 'fate',
    set = 'Spectral',
    atlas = 'HamodConsumables',
    pos = { x = 0, y = 2 },
    config = {extra = {rerolls = 1}},
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "tt_booster_reroll", set = "Other"}
        return { vars = { card.ability.extra.rerolls} }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                add_booster_rerolls({rerolls = card.ability.extra.rerolls})
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end,
}