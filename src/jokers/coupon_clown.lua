SMODS.Joker {
    key = "coupon_clown",
    pos = { x = 8, y = 0 },
    atlas = "HamodJokers",
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    cost = 10,
    config = { extra = { odds = 8 }, },
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.v_hamod_chaos
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,'hamod_coupon_clown' .. G.GAME.round_resets.ante)
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            if SMODS.pseudorandom_probability(card, 'hamod_coupon_clown' .. G.GAME.round_resets.ante, 1, card.ability.extra.odds, 'j_hamod_coupon_clown') then
                SMODS.destroy_cards(card, true)
                HAMOD.add_voucher('v_hamod_chaos')
                return {
                    message = "Destroyed!",
                    colour = G.C.RED
                }
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end
} 
      
local card_set_cost_ref = Card.set_cost
function Card:set_cost(reduction)
    card_set_cost_ref(self)
    
    if next(SMODS.find_card("j_hamod_coupon_clown")) then
        if self.ability.set == 'Voucher' then
            self.cost = (self.cost * 0.5)
        end
    end
    
    self.sell_cost = math.max(1, math.floor(self.cost / 2)) + (self.ability.extra_value or 0)
    self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
end
