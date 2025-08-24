return {
    descriptions = {
        Planet = {
            c_hamod_planet0711B = {
                name = "Planet O711-B",
                text = {
                    "Upgrade a random {C:tarot,E:2}poker hand{} by {C:attention}#1#{} levels"
                }
            },
            c_hamod_planet_delta = {
                name = "Planet Delta",
                text = {
                    "Upgrade your last played {C:tarot,E:2}poker hand{} by {C:attention}#1#{} levels",
                    "{C:inactive}(#2#){}"
                }
            }
        },
        Back = {
            b_hamod_deck1 = {
                name = "Deck1",
                text = {
                    "Test deck"
                },
                unlock = {
                    "Win a run with",
                    "{C:attention}#1#{}",
                    "on any difficulty",
                }
            }
        },
        Joker = {
            j_hamod_straight_shooter = {
                name = "Straight Shooter",
                text = {
                    "Earn money for every {C:attention}Straight{} played",
                    "Regular = {C:money}$#1#{}",
                    "Flush = {C:money}$#2#{}",
                    "{E:2,C:dark_edition}Royal{} = {C:money}$#3#{}"
                },
            },
            j_hamod_color_rush = {
                name = "Color Rush",
                text = {
                    "Played cards give {C:white,X:mult}X#1#{} Mult",
                    "if played hand is a {C:attention}Straight{}",
                    "and contains a {C:spades}Spade{} card, {C:hearts}Heart{} card",
                    "{C:clubs}Club{} card and {C:diamonds}Diamond{} card"
                },
            },
            j_hamod_fools_arcana = {
                name = "Fool's Arcana",
                text = {
                    "{C:green}#1# in #2#{} chance to create",
                    "a {C:tarot}Tarot{} card when a",
                    "{C:attention}Straight{} is played"
                },
            },
            j_hamod_high_roller = {
                name = "High Roller",
                text = {
                    "After playing a {C:attention}Straight{}:",
                    "Retrigger all played cards",
                    "{C:green}#1# in #2#{} chance to {C:red,E:2}destroy{} all played cards"
                },
            },
            j_hamod_empty_pockets = {
                name = "Empty Pockets",
                text = {
                    "{X:mult,C:white}X#1#{} Mult",
                    "Increases by {X:mult,C:white}X#2#{} Mult before every blind,",
                    "only if {C:red}no{} actions were taken during the {C:attention}Shop{}"
                },
            },
            j_hamod_foil_fanatic = {
                name = "Foil Fanatic",
                text = {
                    "{X:mult,C:white}X#1#{} Mult",
                    "Increases by {X:mult,C:white}X#2#{} for every {C:attention}Joker{} with an {C:enhanced}Edition{}",
                    "{C:inactive,s:0.8}(currently{} {C:white,X:mult,s:0.8}X#3#{}{C:inactive,s:0.8}){}"
                },
            },
            j_hamod_the_usual = {
                name = "The Usual",
                text = {
                    "{C:chips}+#1#{} Chips for every time,",
                    "the most played hand was scored",
                    "{C:inactive,s:0.8}(currently{} {C:chips}+#2#{}{C:inactive,s:0.8}){}"
                },
            },
            j_hamod_doppelganger = {
                name = "Doppelganger",
                text = {
                    "Creates a random {C:green}Uncommon{} or {C:red}Rare{}",
                    "{C:attention}Joker{}, which it then copies.",
                    "{C:inactive,s:0.8}(Random Joker will be{} {C:dark_edition,s:0.8}Negative{} {C:inactive,s:0.8}and{} {C:enhanced,s:0.8}Eternal{}{C:inactive,s:0.8}){}"
                },
            },
            j_hamod_coupon_clown = {
                name = "Coupon Clown",
                text = {
                    "Halves the price of all {C:purple}Vouchers{} in {C:attention}Shop{}",
                    "At end of round, {C:green}#1# in #2#{} chance to break",
                    "If broken, gain the {C:attention,T:v_hamod_chaos}Chaos Voucher{}"
                }
            },
            j_hamod_siphon = {
                name = "Siphon",
                text = {
                    "{C:inactive,s:0.9}#1#{} {s:0.8}/{} {C:enhanced,s:0.9}#2#{}",
                    "{C:inactive,s:0.6}(Next:{} {C:tarot,s:0.8,E:1}#3#{}{C:inactive,s:0.6}){}",
                    "{s:0.75}Every hand,{} {C:attention,s:0.75}10%{} {s:0.75}of the scored chips{}",
                    "{s:0.7}are{} {C:attention,s:0.7}deducted{} {s:0.7}and added to the internal buffer{}",
                }
            }
        },
        Voucher = {
            v_hamod_chaos = {
                name = 'Chaos',
                text = {
                    "All {C:attention}Consumables{} now share",
                    "the same item pool"
                }
            }
        },
        Other = {
            hamod_catalyst_seal = {
                name = 'Catalyst Seal',
                text = {
                    '{X:red,C:white}X#1#{} Mult',
                    'Increases by {X:red,C:white}X#2#{} when scored',
                    'Resets when {C:attention}discarded{} or',
                    '{C:attention}in hand{} at the end of the round'
                }
            },
            p_hamod_legendary_joker = {
                name = "Random Legendary Joker",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:joker} Joker{} cards",
                },
            },
            p_hamod_rare_joker = {
                name = "Random Rare Joker",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:joker} Joker{} cards",
                },
            },
            p_hamod_uncommon_joker = {
                name = "Random Uncommon Joker",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:joker} Joker{} cards",
                },
            },
            p_hamod_chaos_small = {
                name = "Chaos Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:enhanced} Consumable{} cards",
                },
            },
            p_hamod_chaos_medium = {
                name = "Mega Chaos Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:enhanced} Consumable{} cards",
                },
            },
            p_hamod_chaos_large = {
                name = "Jumbo Chaos Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:enhanced} Consumable{} cards",
                },
            },
            p_hamod_voucher_small = {
                name = "Voucher Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:enhanced} Vouchers{}",
                },
            },
            p_hamod_voucher_medium = {
                name = "Mega Voucher Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:enhanced} Vouchers{}",
                },
            },
            p_hamod_voucher_large = {
                name = "Jumbo Voucher Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:enhanced} Vouchers{}",
                },
            }
        },
    },
    misc = {
        labels = {
            hamod_catalyst_seal = 'Catalyst Seal',
        },
        dictionary = {
            k_high_roller_destroy = 'Damn...',
            k_empty_pockets_increase = 'Cheapskate...',
            k_empty_pockets_reset = 'You fool...',
            k_siphon_siphoned = 'Charging...',
            k_siphon_levelup = 'Level up!',
            k_siphon_no_free_slots = 'No free slots!',
            k_chaos = 'Chaos Pack',
            k_random_joker = 'Joker Pack',
            k_random_voucher = 'Voucher Pack'
        }
    }
}