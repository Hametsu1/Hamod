SMODS.PokerHand {
    key = "nice_nice",
    mult = 3,
    chips = 20,
    l_mult = 2,
    l_chips = 20,
    visible = false,
    above_hand = 'Two Pair',
    example = {
        { 'D_6', true },
        { 'C_9', true },
        { 'S_6', true },
        { 'H_9', true },
    },
    evaluate = function(parts, hand)
        if #hand ~= 4 then return {} end

        local r1, r2, r3, r4 = hand[1].base.id, hand[2].base.id, hand[3].base.id, hand[4].base.id
        if (r1 == 6 and r3 == 6) and (r2 == 9 and r4 == 9) then
            return { hand }
        end
        return {}
    end,
}

SMODS.PokerHand {
    key = "nice",
    mult = 2,
    chips = 15,
    l_mult = 1,
    l_chips = 15,
    visible = false,
    above_hand = 'High Card',
    example = {
        { 'D_6', true },
        { 'C_9', true },
    },
    evaluate = function(parts, hand)
        if #hand ~= 2 then return {} end

        local r1, r2 = hand[1].base.id, hand[2].base.id
        if r1 == 6 and r2 == 9 then
            return { hand }
        end
        return {}
    end,
}