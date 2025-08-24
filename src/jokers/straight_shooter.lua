SMODS.Joker {
    key = "straight_shooter",
    pos = { x = 4, y = 0 },
    atlas = "HamodJokers",
    rarity = 2,
    blueprint_compat = true,
    cost = 7,
    config = { extra = { money = 5, money_flush = 10, money_royal = 15 }, },
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money, card.ability.extra.money_flush, card.ability.extra.money_royal } }
    end,
    calculate = function(self, card, context)
        if context.display_name then
            card.ability.extra.played_hand = context.display_name
        end

        if context.joker_main then
            if card.ability.extra.played_hand == "Royal Flush" then
                return {dollars = card.ability.extra.money_royal}
            elseif card.ability.extra.played_hand == "Straight Flush" then
                return {dollars = card.ability.extra.money_flush}
            elseif card.ability.extra.played_hand == "Straight" then
                return {dollars = card.ability.extra.money}
            end
        end
    end
}