SMODS.Joker {
    key = "color_rush",
    pos = { x = 0, y = 0 },
    atlas = "HamodJokers",
    rarity = 3,
    blueprint_compat = true,
    cost = 9,
    config = { extra = { xmult = 2 }, },
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if next(context.poker_hands['Straight']) then
                local suits = {
                    ['Hearts'] = false,
                    ['Diamonds'] = false,
                    ['Spades'] = false,
                    ['Clubs'] = false
                }

                for i,entry in ipairs(context.scoring_hand) do
                    suits[entry.base.suit] = true
                end

                local allSuitsAvailable = true
                for _, value in pairs(suits) do
                    if value == false then
                        allSuitsAvailable = false
                        break
                    end
                end

                if allSuitsAvailable then
                    return {
                        xmult = card.ability.extra.xmult
                    }
                end
            end
        end
    end
}