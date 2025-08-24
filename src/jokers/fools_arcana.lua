SMODS.Joker {
    key = "fools_arcana",
    pos = { x = 2, y = 0 },
    atlas = "HamodJokers",
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    config = { extra = { odds = 2 }, },
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,'hamod_fools_arcana' .. G.GAME.round_resets.ante)
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            if next(context.poker_hands["Straight"]) then
                if SMODS.pseudorandom_probability(card, 'hamod_fools_arcana' .. G.GAME.round_resets.ante, 1, card.ability.extra.odds, 'j_hamod_fools_arcana') then
                    local created_consumable = false

                    if HAMOD.area_free_slots('Consumable') > 0 then
                        SMODS.add_card({set = 'Tarot'})
                        created_consumable = true
                    end
                    
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = created_consumable and localize('k_plus_tarot') or nil, colour = G.C.PURPLE})
                end
            end
        end
    end
}