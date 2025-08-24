SMODS.Back {
    key = "deck1",
    pos = { x = 0, y = 0 },
    config = { jokers = {'j_hamod_doppelganger',}, consumables = {"c_hamod_planet0711B"}, hands = 20, discards = 100, hand_size = 55, dollars = 1000 },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.discards } }
    end,
}