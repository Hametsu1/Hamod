SMODS.Booster {
    key = 'legendary_joker',
    config = { extra = 2, choose = 1 },
    cost = 44,
    weight = 0.05,
    atlas = "HamodBoosters",
    pos = { x = 0, y = 0 },
    discovered = true,
    kind = 'Buffoon',
    group_key = 'k_random_joker',
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
            set = "Joker",
            rarity = 'Legendary',
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "hamod"
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("563ec8"))
        ease_background_colour({ new_colour = HEX('563ec8'), special_colour = HEX("471dec"), contrast = 2 })
    end
}

SMODS.Booster {
    key = 'rare_joker',
    config = { extra = 2, choose = 1 },
    cost = 22,
    weight = 0.1,
    atlas = "HamodBoosters",
    pos = { x = 1, y = 0 },
    discovered = true,
    kind = 'Buffoon',
    group_key = 'k_random_joker',
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
            set = "Joker",
            rarity = 'Rare',
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "hamod"
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("c72727"))
        ease_background_colour({ new_colour = HEX('c72727'), special_colour = HEX("c57342"), contrast = 2 })
    end
}

SMODS.Booster {
    key = 'uncommon_joker',
    config = { extra = 3, choose = 1 },
    cost = 10,
    weight = 0.5,
    atlas = "HamodBoosters",
    pos = { x = 2, y = 0 },
    discovered = true,
    kind = 'Buffoon',
    group_key = 'k_random_joker',
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
            set = "Joker",
            rarity = 'Uncommon',
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "hamod"
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("80bb64"))
        ease_background_colour({ new_colour = HEX('80bb64'), special_colour = HEX("3baa63"), contrast = 2 })
    end
}