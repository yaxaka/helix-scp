scpgui_mouse_enabled = false

net.Receive("guiMouse", function()
    if scpgui_mouse_enabled then
        scpgui_mouse_enabled = false
        gui.EnableScreenClicker(false)
    else
        scpgui_mouse_enabled = true
        gui.EnableScreenClicker(true)
    end
end)



local tab_stage1 = {
    ["$pp_colour_brightness"] = -0.1,
    ["$pp_colour_contrast"] = 1,
    ["$pp_colour_colour"] = 0.9,
    ["$pp_colour_mulr"] = 0,
    ["$pp_colour_mulg"] = 0,
    ["$pp_colour_mulb"] = 0
}


local tab_stage2 = {
    ["$pp_colour_brightness"] = 0,
    ["$pp_colour_contrast"] = 0.9,
    ["$pp_colour_colour"] = 0.6,
    ["$pp_colour_mulr"] = 1,
    ["$pp_colour_mulg"] = 0,
    ["$pp_colour_mulb"] = 0
}

local tab_stage3 = {
    ["$pp_colour_brightness"] = 0,
    ["$pp_colour_contrast"] = 0.7,
    ["$pp_colour_colour"] = 0.5,
    ["$pp_colour_mulr"] = 1,
    ["$pp_colour_mulg"] = 0,
    ["$pp_colour_mulb"] = 2
}

local tab_stage4 = {
    ["$pp_colour_brightness"] = 0,
    ["$pp_colour_contrast"] = 0.6,
    ["$pp_colour_colour"] = 0.4,
    ["$pp_colour_mulr"] = 1,
    ["$pp_colour_mulg"] = 5,
    ["$pp_colour_mulb"] = 2
}

local tab_stage5 = {
    ["$pp_colour_brightness"] = 0,
    ["$pp_colour_contrast"] = 0.5,
    ["$pp_colour_colour"] = 0.3,
    ["$pp_colour_mulr"] = 1,
    ["$pp_colour_mulg"] = 8,
    ["$pp_colour_mulb"] = 2
}

local tab_stage6 = {
    ["$pp_colour_brightness"] = 0,
    ["$pp_colour_contrast"] = 0.3,
    ["$pp_colour_colour"] = 0,
    ["$pp_colour_mulr"] = 1,
    ["$pp_colour_mulg"] = 8,
    ["$pp_colour_mulb"] = 2
}

hook.Add("RenderScreenspaceEffects", "035Change", function()
    local lply = LocalPlayer()
    if IsValid(lply) then
        if lply.InsaneColor then
            if lply.InsaneColorStage == 1 then
                DrawColorModify(tab_stage1)
            elseif lply.InsaneColorStage == 2 then
                DrawColorModify(tab_stage2)
            elseif lply.InsaneColorStage == 3 then
                DrawColorModify(tab_stage3)
            elseif lply.InsaneColorStage == 4 then
                DrawColorModify(tab_stage4)
            elseif lply.InsaneColorStage == 5 then
                DrawColorModify(tab_stage5)
            elseif lply.InsaneColorStage == 6 then
                DrawColorModify(tab_stage6)
            end
        end
    end
end)