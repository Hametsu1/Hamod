--[[ SMODS.Joker {
    key = "empty_pockets",
    pos = { x = 3, y = 0 },
    atlas = "HamodJokers",
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
    config = { extra = { xmult_base = 1, xmult = 1, increase = 0.5 }, },
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.increase } }
    end,
    calculate = function(self, card, context)

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end

        if context.starting_shop and not context.blueprint then
            card.ability.extra.doChecks = true
            card.ability.extra.failed = false
            local eval = function(card) return card.ability.extra.doChecks == false and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
            return true
        end

        if context.ending_shop and not context.blueprint then
            card.ability.extra.doChecks = false

            if not card.ability.extra.failed then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.increase
                return {
                    message = localize('k_empty_pockets_increase', card, G.C.GREEN)
                }
            end
        end
        
        if (card.ability.extra.doChecks and not context.blueprint) or (context.buying_card and context.card.config.center.key == self.key and context.cardarea == G.jokers) then

            HAMOD.debug(tprint(context))

            card.ability.extra.doChecks = false
            card.ability.extra.failed = true

            return {
                message = localize('k_empty_pockets_reset', card, G.C.RED)
            }
        end
    end
} ]]