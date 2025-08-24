SMODS.Atlas{
    key = 'HamodSeals',
    path = 'Seals.png',
    px = 40,
    py = 40
}

SMODS.Seal {
    key = 'catalyst',
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            XMult = 1,
            increase = 0.1,
            XMult_base = 1
        }
    },
    badge_colour = HEX('ffac38'),
    atlas = 'HamodSeals',
    unlocked = true,
    discovered = true,
    no_collection = false,
    loc_vars = function(self, info_queue, card)
        local varObj = {}
        if card then
            varObj = {card.ability.seal.extra.XMult, card.ability.seal.extra.increase}
        else
            varObj = {self.config.extra.XMult, self.config.extra.increase}
        end

        return {vars = varObj}
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            card.ability.seal.extra.XMult = card.ability.seal.extra.XMult + card.ability.seal.extra.increase
            return {
                xmult = card.ability.seal.extra.XMult
            }
        end

        if context.end_of_round and context.cardarea == G.hand and context.other_card == card then
            HAMOD.debug("Resetting")
            card.ability.seal.extra.XMult = card.ability.seal.extra.XMult_base
            return {
                message = localize('k_high_roller_destroy', card, G.C.RED)
            }
        end

        if context.discard and context.other_card == card then
            HAMOD.debug("Resetting")
            card.ability.seal.extra.XMult = card.ability.seal.extra.XMult_base
        end
    end
}