SMODS.Consumable {
    key = "planet_delta",
    set = "Planet",
    cost = 5,
    atlas = 'HamodConsumables',
    pos = { x = 0, y = 0 },
    config = { amount = 2},
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.amount, G.GAME.last_hand_played
            }
        }
    end,
    can_use = function(self, card)
		return true
	end,
    use = function(self, card, area, copier)
        local hand = SMODS.PokerHands[G.GAME.last_hand_played]
        SMODS.smart_level_up_hand(card, hand.key, false, card.ability.amount)
    end,
    in_pool = function(self, args)
        return G.GAME.last_hand_played
    end
}