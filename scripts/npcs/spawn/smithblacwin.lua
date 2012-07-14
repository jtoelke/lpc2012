-- [[
-- Authors:
-- - Jenalya
--
-- variable use
-- tutorial_equip: saves if got equipment from smith
-- ]]

require "scripts/functions/patrol"

local function smithTalk(npc, ch)
    local function say(message)
        npc_message(npc, ch, message)
    end

    local function getEquipment()
        say("Yes?")
        local ask_equip = { "I need my equipment!",
                            "Nevermind."}
        local res = npc_choice(npc, ch, ask_equip)
        if res == 1 then
            say("Here.")
            chr_inv_change(ch, "Kettle hat", 1)
            chr_inv_change(ch, "Rusty chain armor", 1)
            chr_set_quest(ch, "tutorial_equip", "done")
            local reply_equip = { "You're not very talkative, are you?",
                                "Thanks."}
            local res = npc_choice(npc, ch, reply_equip)
            if res == 1 then
                say("No.")
            else
                say("Hm.")
            end
        else
            say("Hmph.")
        end
    end

    local tutorial_equip = chr_get_quest(ch, "tutorial_equip")
    local tutorial_shop = chr_get_quest(ch, "tutorial_shop")
    if tutorial_equip ~= "done" then
        getEquipment()
    else
        say("Hrm.")
        if tutorial_shop == "done" then
            local ask_shop = { "I heard you could sell me better armor?",
                                "Nevermind."}
            local res = npc_choice(npc, ch, ask_shop)
            if res == 1 then
                say("TODO: shop")
                -- those stuff isn't intended to be sold, but he does that to boost his pay
            else
                say("Hmph.")
            end
        end
    end
end

local function smithWaypointReached(npc)
    gotoNextWaypoint(npc)
end

local smith = create_npc_by_name("Smith Blacwin", smithTalk)
being_set_base_attribute(smith, 16, 1)

local patrol = Patrol:new("Smith Blacwin")
patrol:assignBeing(smith)
schedule_every(10, function() patrol:logic() end)