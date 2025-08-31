function hamod_chaos_voucher(type, pool)
    if HAMOD.has_voucher('v_hamod_chaos') then
        if SMODS.ConsumableTypes[type] then
            pool = G.P_CENTER_POOLS['Consumeables']
        end
    end

    return pool
end

HAMOD = {

    debug = function(msg)
        print("[Hamod] [Debug] " .. tostring(msg))
    end,

    error = function(msg)
        print("[Hamod] [ERROR] " .. tostring(msg))
    end,

    get_visible_hand_types = function()
        local filtered = {}

        for k, v in pairs(SMODS.PokerHands) do
            if v.visible == true then
                filtered[k] = v
            end
        end

        return filtered
    end,

    add_voucher = function(voucher)
        local voucher_card = SMODS.create_card({area = G.play, key = voucher})
        voucher_card:start_materialize()
        voucher_card.cost = 0
        G.play:emplace(voucher_card)

        delay(0.8)

        voucher_card:redeem()
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.5,
            func = function()
                voucher_card:start_dissolve()                
                return true
            end
        }))
    end,

    area_free_slots = function(set)
        if set == 'Joker' then
            return G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer)
        elseif set == 'Consumeable' or set == 'Consumable' then
            return G.consumeables.config.card_limit - (#G.consumeables.cards + G.GAME.consumeable_buffer)
        end
    end,

    create_tag = function(tag, sound)
        if not tag then return false end
        G.E_MANAGER:add_event(Event({
            func = (function()
                add_tag(Tag(tag))
                if sound then
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                end
                return true
            end)
        }))
    end,

    get_keys = function(tbl)
        local keys = {}
        for k, _ in pairs(tbl) do
            table.insert(keys, k)
        end
        return keys
    end,

    poll_tag = function(args)
        args = args or {}
        local key = args.key or 'hamodtag'
        local mod = args.mod or 1
        local guaranteed = args.guaranteed or false
        local options = args.options or get_current_pool("Tag")
        local type_key = args.type_key or key.."type"..G.GAME.round_resets.ante
        key = key..G.GAME.round_resets.ante

        local available_tags = {}
        local total_weight = 0
        for _, v in ipairs(options) do
            if v ~= "UNAVAILABLE" then
                local tag_option = {}
                if type(v) == 'string' then
                    assert(G.P_TAGS[v], ("Could not find tag \"%s\"."):format(v))
                    tag_option = { key = v, weight = G.P_TAGS[v].weight or 5 } -- default weight set to 5 to replicate base game weighting
                elseif type(v) == 'table' then
                    assert(G.P_TAGS[v.key], ("Could not find tag \"%s\"."):format(v.key))
                    tag_option = { key = v.key, weight = v.weight }
                end
                if tag_option.weight > 0 then
                    table.insert(available_tags, tag_option)
                    total_weight = total_weight + tag_option.weight
                end
            end
        end
        total_weight = total_weight + (total_weight / 2 * 98) -- set base rate to 2%

        local type_weight = 0 -- modified weight total
        for _,v in ipairs(available_tags) do
            v.weight = G.P_TAGS[v.key].get_weight and G.P_TAGS[v.key]:get_weight() or v.weight
            type_weight = type_weight + v.weight
        end

        local tag_poll = pseudorandom(pseudoseed(key or 'hamodtag'..G.GAME.round_resets.ante))
        if tag_poll > 1 - (type_weight*mod / total_weight) or guaranteed then -- is a seal generated
            local tag_type_poll = pseudorandom(pseudoseed(type_key)) -- which seal is generated
            local weight_i = 0
            for k, v in ipairs(available_tags) do
                weight_i = weight_i + v.weight
                if tag_type_poll > 1 - (weight_i / type_weight) then
                    return v.key
                end
            end
        end
    end,

    --{table, key, seed, filter}
    poll_table = function(args)
        local table_ = {}
        local seed,key,_table,filter = args.seed,args.key,args.table,args.filter
        if not seed then seed = "hamod_poll_table"..G.GAME.round_resets.ante end

        local filter_table = {}
        if filter then
            for k,v in pairs(filter) do
                filter_table[v] = true
            end
        end

        for k,v in pairs(_table) do
            local key_name = ''
            if type(k) == 'string' then key_name = k
            elseif type(v) == "string" then key_name = v
            elseif type(v) == "table" then key_name = v[args.key]
            end
            if not filter or not filter_table[key_name] then
                table_[key_name] = v
            end
        end

        return pseudorandom_element(table_, pseudoseed(seed))
    end,

    has_voucher = function(key)
        return G.GAME.used_vouchers[key]
    end,

    context = {
        end_of_round = function(context, blueprint)
            return context.end_of_round and context.game_over == false and context.main_eval and (blueprint or not context.blueprint)
        end
    }
}

function contains_flag(card, flag)
    if not card or not flag or not card.config or not card.config.center or not card.config.center.flags then return false end
    return card.config.center.flags[flag]
end

function visualize_hand_type(hand)
    local cardarea = CardArea(
        0,
        0,
        2.85 * G.CARD_W,
        0.75 * G.CARD_H,
        {card_limit = 4, type = 'title', highlight_limit = 0}
    )
    for k, v in ipairs(example) do
        local card = Card(
        0,
        0,
        0.5 * G.CARD_W,
        0.5 * G.CARD_H,
        G.P_CARDS[v[1]],
        G.P_CENTERS.c_base)
        if v[2] then card:juice_up(0.3, 0.2) end
        if k == 1 then play_sound('paper1', 0.95 + math.random() * 0.1, 0.3) end
        ease_value(card.T, 'scale', v[2] and 0.25 or -0.15, nil, 'REAL', true, 0.2)
        cardarea:emplace(card)
    end

    return {n=G.UIT.R, config = {align = "cm", colour = G.C.CLEAR, r = 0.0}, nodes={
        {n=G.UIT.C, config = {align = "cm"}, nodes={
            {n=G.UIT.O, config = {object = cardarea}}
        }}
    }}
end

local include_table = {
    'jokers',
    'decks',
    'boosters',
    'planets',
    'vouchers',
    'seals',
    'tarots',
    'spectrals',
    'handtypes'
}

HAMOD.debug("Mod loaded")

for i, entry in ipairs(include_table) do
    local init, error = SMODS.load_file("src/" .. entry .. "/_main.lua")
    if error then
        HAMOD.error("Error loading module '" .. entry .. "'. Message: "  .. error)
    else
        if init then init() end
        HAMOD.debug("Module '" .. entry .. "' loaded")
    end
end

--[[
G.GAME = { 
    tarot_rate: 4
    pack_size: 2
    round_bonus: table
    tag_tally: 2
    common_mod: 1
    win_ante: 8
    inflation: 0
    MP_joker_overrides: table
    spectral_rate: 0
    banned_keys: table
    joker_rate: 20
    used_vouchers: table
    modifiers: table
    pseudorandom: table
    selected_back_key: table
    shop: table
    uncommon_mod: 1
    STOP_USE: 0
    round_resets: table
    unused_discards: 0
    disabled_suits: table
    ecto_minus: 1
    selected_back: table
    playing_card_rate: 0
    voucher_text:
    starting_params: table
    round_scores: table
    smods_version: 1.0.0~BETA-0711a
    edition_rate: 1
    used_jokers: table
    previous_round: table
    round: 0
    current_round: table
    rental_rate: 3
    consumeable_usage: table
    negative_rate: 1
    planet_rate: 4
    stake: 1
    perscribed_bosses: table
    rare_mod: 1
    perishable_rounds: 5
    orbital_choices: table
    skips: 0
    booster_packs_opened: 0
    blind_on_deck: Small
    last_blind: table
    interest_amount: 1
    chips_text: 0
    blind: table
    hands_played: 0
    max_jokers: 1
    hand_usage: table
    interest_cap: 25
    tags: table
    bankrupt_at: 0
    won: false
    discount_percent: 0
    sort: desc
    base_reroll_cost: 5
    pool_flags: table
    current_boss_streak: 0
    joker_usage: table
    cards_played: table
    legendary_mod: 1
    dollars: 1004
    chips: 0
    consumeable_buffer: 0
    hands: table
    probabilities: table
    starting_deck_size: 52
    bosses_used: table
    joker_buffer: 0
    disabled_ranks: table
}
]]
