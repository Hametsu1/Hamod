hamod_siphon_rewards = {
    random_spectral_card = {
        display_name = "Spectral Card",
        multiplier = 2.4,
        rewards = {
            card = {
                {
                    set = 'Spectral',
                }
            }
        },
        requirements = {
            space = {
                area = 'Consumable',
                free_slots = 1
            }
        }
    },
    random_tarot_card = {
        display_name = "Tarot Card",
        multiplier = 1.0,
        rewards = {
            card = {
                {
                    set = 'Tarot',
                }
            }
        },
        requirements = {
            space = {
                area = 'Consumable',
                free_slots = 1
            }
        }
    },
    random_common_joker = {
        display_name = "Common Joker",
        multiplier = 1.2,
        rewards = {
            card = {
                {
                    set = 'Joker',
                    rarity = 'Common'
                }
            }
        },
        requirements = {
            space = {
                area = 'Joker',
                free_slots = 1
            }
        }
    },
    random_uncommon_joker = {
        display_name = "Uncommon Joker",
        multiplier = 2.0,
        rewards = {
            card = {
                {
                    set = 'Joker',
                    rarity = 'Uncommon'
                }
            }
        },
        requirements = {
            space = {
                area = 'Joker',
                free_slots = 1
            }
        }
    },
    random_rare_joker = {
        display_name = "Rare Joker",
        multiplier = 2.8,
        rewards = {
            card = {
                {
                    set = 'Joker',
                    rarity = 'Rare'
                }
            }
        },
        requirements = {
            space = {
                area = 'Joker',
                free_slots = 1
            }
        }
    },
    money_shower_small = {
        display_name = "Small Money",
        multiplier = 1.8,
        rewards = {
            money = {
                amount = 20,
                per_ante_bonus = 5
            }
        }
    },
    money_shower_medium = {
        display_name = "Medium Money",
        multiplier = 2.5,
        rewards = {
            money = {
                amount = 30,
                per_ante_bonus = 8
            }
        }
    },
    money_shower_big = {
        display_name = "Big Money",
        multiplier = 3.3,
        rewards = {
            money = {
                amount = 40,
                per_ante_bonus = 10
            }
        }
    },
    double_tag_singular = {
        display_name = "Double Tag",
        multiplier = 1.5,
        rewards = {
            tag = {
                key = 'tag_double',
            }
        }
    },
    double_tag_double = {
        display_name = "Double Tag x2",
        multiplier = 2.2,
        rewards = {
            tag = {
                key = 'tag_double',
                amount = 2
            }
        }
    },
    random_tag = {
        display_name = "Random Tag",
        multiplier = 1.9,
        rewards = {
            tag = {
                amount = 1
            }
        }
    },
    walmart_blueprint = {
        display_name = "Blueprint?",
        multiplier = 2.4,
        rewards = {
            card = {
                {
                    key = 'j_blueprint',
                    set = 'Joker',
                    stickers = {
                        'perishable'
                    }
                }
            }
        }
    },
}

function hamod_siphon_check_requirements(key)
    local entry = hamod_siphon_rewards[key]
    if not entry.requirements then return true, '' end

    local requirements = entry.requirements

    for k,v in pairs(requirements) do
        if k == 'space' then
            if HAMOD.area_free_slots(v.area) < v.free_slots then
                return false, 'k_siphon_no_free_slots'
            end
        end
    end

    return true, ''
end

function hamod_siphon_redeem_reward(key)
    local requirements_check, error_msg = hamod_siphon_check_requirements(key)

    if not requirements_check then return false, error_msg end

    local rewards = hamod_siphon_rewards[key].rewards

    for k,v in pairs(rewards) do

        if k == 'card' then
            G.E_MANAGER:add_event(Event({
                func = function()
                    for k2,v2 in pairs(v) do
                        SMODS.add_card(v2)
                    end
                    return true
                end
            }))
        end

        if k == 'money' then
            local amount = v.amount
            if v.per_ante_bonus then amount = amount + (v.per_ante_bonus * G.GAME.round_resets.ante) end
            ease_dollars(amount)
        end


        if k == 'tag' then
            for _ = 1, v.amount or 1 do
                local key = v.key or HAMOD.poll_tag({guaranteed = true})
                HAMOD.create_tag(key, true)
            end
        end
    end 
    
    return true, ''
end

SMODS.Joker {
    key = "siphon",
    pos = { x = 9, y = 0 },
    atlas = "HamodJokers",
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    cost = 6,
    config = { extra = { buffer_current = 0, buffer_max = 1000, factor = 0.1, next_reward = nil }, },
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.buffer_current, card.ability.extra.buffer_max, hamod_siphon_reward_string(card) } }
    end,
    calculate = function(self, card, context)
        if context.final_scoring_step and context.cardarea == G.jokers and not context.blueprint then
            local buffer_gain = (hand_chips * mult) * card.ability.extra.factor
            card.ability.extra.buffer_current = card.ability.extra.buffer_current + buffer_gain

            local scale = math.sqrt(1 - card.ability.extra.factor)
            hand_chips = hand_chips * scale
            mult = mult * scale
            
            return true
        end

        if context.after and context.cardarea == G.jokers and not context.blueprint then

            if card.ability.extra.buffer_current >= card.ability.extra.buffer_max and card.ability.extra.next_reward then
                local eval = function(card) return card.ability.extra.buffer_current == 0 and not G.RESET_JIGGLES end
                juice_card_until(card, eval, true)
            end

            return {
                message = localize('k_siphon_siphoned', card, G.C.RED)
            }
        end

        if HAMOD.context.end_of_round(context, false) then

            if card.ability.extra.buffer_current >= card.ability.extra.buffer_max and card.ability.extra.next_reward then
                local reward_claimed, msg = hamod_siphon_redeem_reward(card.ability.extra.next_reward)
                local returnObj
                
                if reward_claimed then
                    hamod_siphon_reset(card)
                    returnObj = localize('k_siphon_levelup', card, G.C.GREEN)
                else
                    returnObj = localize(msg, card, G.C.RED)
                end
                
                return {
                    message = returnObj
                }
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        hamod_siphon_reset(card)
    end
}

function hamod_siphon_calculate_buffer(mult)
    return (get_blind_amount(G.GAME.round_resets.ante)*G.GAME.starting_params.ante_scaling * 0.5) * mult
end

function hamod_siphon_reset(card)
    card.ability.extra.buffer_current = 0
    card.ability.extra.next_reward = pseudorandom_element(HAMOD.get_keys(hamod_siphon_rewards), pseudoseed('hamod_siphon' .. G.GAME.round_resets.ante))
    card.ability.extra.buffer_max = hamod_siphon_calculate_buffer(hamod_siphon_rewards[card.ability.extra.next_reward].multiplier)
end

function hamod_siphon_reward_string(card)
    if not card.ability.extra.next_reward then return '?' end

    local cur = card.ability.extra.buffer_current
    local max = card.ability.extra.buffer_max

    local percent_done
    if cur >= max then percent_done = 100
    elseif cur <= 0 then percent_done = 0
    else percent_done = (cur / max) * 100 end

    return hamod_mask_string(hamod_siphon_rewards[card.ability.extra.next_reward].display_name, percent_done)
end

function hamod_mask_string(str, percent)
    local len = #str
    if len == 0 then return "" end

    local nonspace_len = 0
    for i = 1, len do
        if str:sub(i, i) ~= " " then
            nonspace_len = nonspace_len + 1
        end
    end

    local visible = math.max(1, math.floor(nonspace_len * (percent / 100)))
    if visible > nonspace_len then
        visible = nonspace_len
    end

    math.randomseed(visible)

    local positions = {}
    for i = 1, len do
        local ch = str:sub(i, i)
        if ch ~= " " then
            table.insert(positions, i)
        end
    end

    for i = #positions, 2, -1 do
        local j = math.random(i)
        positions[i], positions[j] = positions[j], positions[i]
    end

    local keep = {}
    for i = 1, visible do
        keep[positions[i]] = true
    end

    local result = {}
    for i = 1, len do
        local ch = str:sub(i, i)
        if ch == " " then
            result[i] = " " 
        elseif keep[i] then
            result[i] = ch
        else
            result[i] = "_"
        end
    end

    return table.concat(result)
end