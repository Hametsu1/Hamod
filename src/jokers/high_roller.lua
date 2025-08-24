SMODS.Joker {
    key = "high_roller",
    pos = { x = 1, y = 0 },
    atlas = "HamodJokers",
    rarity = 1,
    blueprint_compat = true,
    cost = 9,
    config = { extra = {odds_destroy = 10, repetitions = 1} },
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds_destroy,'hamod_high_roller' .. G.GAME.round_resets.ante)
        return { vars = { numerator,denominator } }
    end,
    calculate = function(self, card, context)

        if context.before and context.main_eval then
            --[[ if SMODS.pseudorandom_probability(card, 'hamod_high_roller' .. G.GAME.round_resets.ante, 1, card.ability.extra.odds_replay) then
                card.ability.extra.doReplay = true
            end ]]
            if SMODS.pseudorandom_probability(card, 'hamod_high_roller' .. G.GAME.round_resets.ante, 1, card.ability.extra.odds_destroy) then
                card.ability.extra.doDestroy = true
            end
        end

        if context.repetition and context.cardarea == G.play and next(context.poker_hands['Straight']) then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end

        if context.after and context.main_eval and card.ability.extra.doDestroy and next(context.poker_hands['Straight']) then
            SMODS.destroy_cards(context.scoring_hand)
            return {
                message = localize('k_high_roller_destroy', card, G.C.RED)
            }
        end

        if context.end_of_round and context.cardarea == G.jokers then
            card.ability.extra.doDestroy = false
            --card.ability.extra.doReplay = false
        end
    end
}