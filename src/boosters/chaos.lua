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
    cost = 9,
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
    cost = 11,
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