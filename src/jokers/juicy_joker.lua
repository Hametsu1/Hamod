SMODS.Joker {
    key = "juicy_joker",
    pos = { x = 1, y = 0 },
    atlas = "HamodJokers",
    rarity = 2,
    blueprint_compat = true,
    cost = 7,
    config = { extra = {chips = 20, mult = 4, xmult = 2, hand = 'hamod_nice_nice'} },
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.xmult }, main_end = {create_UIBox_hand_tip('hamod_nice_nice')}}
    end,
    calculate = function(self, card, context)

        if context.individual and context.cardarea == G.play then
            if context.other_card.base.id == 6 or context.other_card.base.id == 9 then
                return{
                    mult = card.ability.extra.mult,
                    chips = card.ability.extra.chips
                }
            end
        end

        if context.joker_main and next(context.poker_hands[card.ability.extra.hand]) then
            return {
                xmult = card.ability.extra.xmult,
                level_up = 1
            }
        end
    end
}