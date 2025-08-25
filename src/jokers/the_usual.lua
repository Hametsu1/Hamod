SMODS.Joker {
    key = "the_usual",
    pos = { x = 6, y = 0 },
    atlas = "HamodJokers",
    rarity = 3,
    blueprint_compat = true,
    cost = 10,
    config = { extra = { chips = 5 }, },
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local obj = hamod_most_played_hand()
        return { vars = { card.ability.extra.chips, math.max(card.ability.extra.chips * obj.amount,card. ability.extra.chips), obj.handname } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local obj = hamod_most_played_hand()
            return {
                chips = math.max(card.ability.extra.chips * obj.amount, card. ability.extra.chips)
            }
        end
    end
}

function hamod_most_played_hand()

    local hand = ''
    local amountPlayed = 0

    for handname, values in pairs(G.GAME.hands) do
        if values.played >= amountPlayed and SMODS.is_poker_hand_visible(handname) then
            hand = handname;
            amountPlayed = values.played
        end
    end

    return {handname = hand, amount = amountPlayed}
end
