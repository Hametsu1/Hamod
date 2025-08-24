SMODS.Joker {
    key = "foil_fanatic",
    pos = { x = 5, y = 0 },
    atlas = "HamodJokers",
    rarity = 1,
    blueprint_compat = true,
    cost = 6,
    config = { extra = { xmult = 1, increase = 0.5 }, },
    discovered = true,
    set_ability = function(self, card, initial)
        card:set_edition("e_foil", true)
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.increase, card.ability.extra.xmult + (card.ability.extra.increase * hamod_jokers_with_edition()) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.xmult + (card.ability.extra.increase * hamod_jokers_with_edition())
            }
        end
    end
}

function hamod_jokers_with_edition()
    local count = 0
    for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
        if joker.edition then count = count + 1 end
    end

    return count
end