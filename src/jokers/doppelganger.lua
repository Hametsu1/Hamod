SMODS.Joker {
    key = "doppelganger",
    pos = { x = 7, y = 0 },
    atlas = "HamodJokers",
    rarity = 2,
    blueprint_compat = true,
    cost = 10,
    config = { extra = { odds_rare = 3 }, },
    discovered = true,
    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local other_joker = card.ability.extra.joker

            if not other_joker then return end
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize { type = 'name_text', key = other_joker.config.center.key, set = 'Joker' } .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { main_end = main_end }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        local randomRarity = 'Uncommon'

        if SMODS.pseudorandom_probability(card, 'hamod_doppelganger' .. G.GAME.round_resets.ante, 1, card.ability.extra.odds_rare, 'j_hamod_doppelganger') then
            randomRarity = 'Rare'
        end

        local joker_table = hamod_blueprint_compat_jokers(randomRarity)
        local joker_key = HAMOD.poll_table({table = joker_table, key = 'key'}).key
        local joker = SMODS.add_card({ set = 'Joker', edition = 'e_negative', stickers = {'eternal'}, key = joker_key })

        card.ability.extra.joker = joker       
    end,
    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.joker then
            SMODS.destroy_cards(card.ability.extra.joker, true)
        end
    end,
    calculate = function(self, card, context)
        if card.ability.extra.joker then
            if not hamod_joker_still_exists(card.ability.extra.joker) then
                SMODS.destroy_cards(card, true)
                return
            end
            return SMODS.blueprint_effect(card, card.ability.extra.joker, context)
        end
    end
}

function hamod_joker_still_exists(joker)
    for _, joker in ipairs(G.jokers.cards) do
        if joker == joker then return true end
    end

    return false
end

function hamod_blueprint_compat_jokers(rarity)
    
    local filter_table = {}

    for _,joker in ipairs(get_current_pool('Joker', rarity)) do
        local jokerObj = G.P_CENTERS[joker]
        if jokerObj and jokerObj.eternal_compat and jokerObj.blueprint_compat and joker ~= 'UNAVAILABLE' then
            table.insert(filter_table, jokerObj)
        end
    end

    return filter_table
end