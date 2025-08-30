SMODS.Consumable {
    key = 'reflection',
    set = 'Tarot',
    atlas = 'HamodConsumables',
    pos = { x = 1, y = 0 },
    config = {max_highlighted = 1},
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local rank = G.playing_cards and get_most_common_rank_in_deck() or 'None'
        return { vars = { card.ability.max_highlighted,  rank} }
    end,
    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                used_tarot:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                G.hand.highlighted[1]:flip()
                play_sound('card1', percent)
                G.hand.highlighted[1]:juice_up(0.3, 0.3)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            func = function()
                local _card = G.hand.highlighted[1]
                assert(SMODS.change_base(_card, nil, get_most_common_rank_in_deck()))
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                G.hand.highlighted[1]:flip()
                play_sound('tarot2', percent, 0.6)
                G.hand.highlighted[1]:juice_up(0.3, 0.3)
                return true
            end
        }))
    end,
}

function get_most_common_rank_in_deck()

    local rank_counts = {}
    for _, c in ipairs(G.playing_cards) do
        local rank = c.base.value
        rank_counts[rank] = (rank_counts[rank] or 0) + 1
    end

    local max_rank, max_count = nil, 0
    for rank, count in pairs(rank_counts) do
        if count > max_count then
            max_rank = rank
            max_count = count
        end
    end
    return max_rank
end