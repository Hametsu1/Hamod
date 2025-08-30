SMODS.Consumable {
    key = "planet0711B",
    set = "Planet",
    atlas = 'HamodConsumables',
    cost = 5,
    pos = { x = 0, y = 0 },
    config = { amount = 3},
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.amount
            }
        }
    end,
    can_use = function(self, card)
		return true
	end,
    use = function(self, card, area, copier)
        local hand = pseudorandom_element(HAMOD.get_visible_hand_types(), pseudoseed('hamod' .. G.GAME.round_resets.ante))
        SMODS.smart_level_up_hand(card, hand.key, false, card.ability.amount)
    end
}