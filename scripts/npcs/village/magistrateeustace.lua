-- authors: Jenalya

local function magistrateTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local reputation = read_reputation(ch, "soldier_reputation")

    if reputation >= REPUTATION_NEUTRAL then
        say("This rebels are really annoying. I mean as if there aren't already enough problems with the war.")
        say("And you won't believe it, there are even people swearing they've seen skeletons walking around! "..
            "What a nonsense! But the priest seemed to be rather worried about it. Pah.")
        -- TODO: some more talk, maybe depending on the quest state
    else
        say("Ah. I already heard about your misconducts. Did you come here to recompense for them?")
        local choices = { "Yes, what do I have to pay?",
                        "No!"}
        local res = npc_choice(npc, ch, choices)
        if res == 1 then
            apply_amnesty(npc, ch, "soldier_reputation", "rebel_reputation")
        else
            say("No? Well, we don't have any business with each other then.")
        end
    end
end

local magistrate = create_npc_by_name("Magistrate Eustace", magistrateTalk)
--  TODO: add to map, move to correct folder
