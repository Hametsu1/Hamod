SMODS.Booster {
    key = 'voucher_small',
    config = { extra = 2, choose = 1 },
    cost = 9,
    weight = 0.08,
    atlas = "HamodBoosters",
    pos = { x = 4, y = 0 },
    discovered = true,
    kind = 'Voucher',
    group_key = 'k_random_voucher',
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
            set = "Voucher",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "hamod"
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("6ec2b9"))
        ease_background_colour({ new_colour = HEX('6ec2b9'), special_colour = HEX("346494"), contrast = 1 })
    end
}

SMODS.Booster {
    key = 'voucher_medium',
    config = { extra = 4, choose = 1 },
    cost = 15,
    weight = 0.05,
    atlas = "HamodBoosters",
    pos = { x = 4, y = 0 },
    discovered = true,
    kind = 'Voucher',
    group_key = 'k_random_voucher',
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
            set = "Voucher",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "hamod"
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("6ec2b9"))
        ease_background_colour({ new_colour = HEX('6ec2b9'), special_colour = HEX("346494"), contrast = 1 })
    end
}

SMODS.Booster {
    key = 'voucher_large',
    config = { extra = 5, choose = 2 },
    cost = 22,
    weight = 0.03,
    atlas = "HamodBoosters",
    pos = { x = 4, y = 0 },
    discovered = true,
    kind = 'Voucher',
    group_key = 'k_random_voucher',
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
            set = "Voucher",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "hamod"
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("6ec2b9"))
        ease_background_colour({ new_colour = HEX('6ec2b9'), special_colour = HEX("346494"), contrast = 1 })
    end
}