SMODS.Consumable {
    key = 'exile',
    set = 'Spectral',
    atlas = 'HamodConsumables',
    pos = { x = 1, y = 0 },
    config = {extra = {banishes = 1}},
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "tt_hamod_banish", set = "Other"}
        return { vars = { card.ability.extra.banishes } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                G.GAME.banishes = (G.GAME.banishes or 0) + 1
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}