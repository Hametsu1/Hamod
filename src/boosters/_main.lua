SMODS.Atlas({
    key = "HamodBoosters", 
    path = "Boosters.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Booster {
    key = 'chaos_small',
    config = { extra = 2, choose = 1 },
    cost = 6,
    weight = 0.2,
    atlas = "HamodBoosters",
    pos = { x = 3, y = 0 },
    discovered = true,
    kind = 'Consumable',
    group_key = 'k_chaos',
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    in_pool = function(self, args)
        return not HAMOD.has_voucher('v_hamod_chaos')
    end,
    create_card = function(self, card, i)
        local consumable_type = HAMOD.poll_table{table = SMODS.ConsumableTypes}.key
        return {
            set = consumable_type,
            area = G.pack_cards,
            skip_materialize = true,
            key_append = "hamod"
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("0d0c0c"))
        ease_background_colour({ new_colour = HEX('0d0c0c'), special_colour = HEX("614341"), contrast = 2 })
    end,
}

SMODS.Booster {
    key = 'chaos_medium',
    config = { extra = 4, choose = 1 },
    cost = 10,
    weight = 0.08,
    atlas = "HamodBoosters",
    pos = { x = 3, y = 0 },
    discovered = true,
    kind = 'Consumable',
    group_key = 'k_chaos',
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    in_pool = function(self, args)
        return not HAMOD.has_voucher('v_hamod_chaos')
    end,
    create_card = function(self, card, i)
        local consumable_type = HAMOD.poll_table{table = SMODS.ConsumableTypes}.key
        return {
            set = consumable_type,
            area = G.pack_cards,
            skip_materialize = true,
            key_append = "hamod"
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("0d0c0c"))
        ease_background_colour({ new_colour = HEX('0d0c0c'), special_colour = HEX("614341"), contrast = 2 })
    end,
}

SMODS.Booster {
    key = 'chaos_large',
    config = { extra = 5, choose = 2 },
    cost = 13,
    weight = 0.06,
    atlas = "HamodBoosters",
    pos = { x = 3, y = 0 },
    discovered = true,
    kind = 'Consumable',
    group_key = 'k_chaos',
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
            key
        }
    end,
    in_pool = function(self, args)
        return not HAMOD.has_voucher('v_hamod_chaos')
    end,
    create_card = function(self, card, i)
        local consumable_type = HAMOD.poll_table{table = SMODS.ConsumableTypes}.key
        return {
            set = consumable_type,
            area = G.pack_cards,
            skip_materialize = true,
            key_append = "hamod"
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("0d0c0c"))
        ease_background_colour({ new_colour = HEX('0d0c0c'), special_colour = HEX("614341"), contrast = 2 })
    end,
}

SMODS.Booster {
    key = 'legendary_joker',
    config = { extra = 2, choose = 1 },
    cost = 48,
    weight = 0.05,
    atlas = "HamodBoosters",
    pos = { x = 0, y = 0 },
    discovered = true,
    kind = 'Buffoon',
    group_key = 'k_random_joker',
    select_card = 'consumeables',
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
    cost = 24,
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
    cost = 12,
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