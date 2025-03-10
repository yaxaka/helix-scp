AddCSLuaFile()

hook.Add("RenderScreenspaceEffects", "035Change", function()
    local lply = LocalPlayer()
    if IsValid(lply) then
        if lply.under_035 then
            local lvl = lply.InsaneColorStage
            if lvl == 1 then
                DrawColorModify(under_035_stage1)
            elseif lvl == 2 then
                DrawColorModify(under_035_stage2)
            elseif lvl == 3 then
                DrawColorModify(under_035_stage3)
            elseif lvl == 4 then
                DrawColorModify(under_035_stage4)
            elseif lvl == 5 then
                DrawColorModify(under_035_stage5)
            elseif lvl == 6 then
                DrawColorModify(under_035_stage6)
            end
        end
    end
end)

function yss_lookat035(ply, scp)
    if IsValid(ply) then
        if ply:Alive() then
            ply:SetEyeAngles((scp:GetPos() - ply:GetShootPos()):Angle())
        end
    end
end


concommand.Add("TestMeta", function()
    print(LocalPlayer():GetPlayersUnder035())
end)


function yss_module_victim035_zombietrick()
    local one_zombie = 0
    local lply = LocalPlayer()
        for k,v in pairs(player.GetAll()) do
            if (v:IsPlayer()) && (v:Alive()) && (v ~= lply) then
            local dist = v:GetPos():Distance(lply:GetPos())
            local vteam = v:Team()
            local teamname = team.GetName(vteam)
            local find = string.find(teamname, "SCP")
            
            if (find == nil) then
                print(dist)
                if dist <= 200 then

                    if one_zombie >= 1 then return end

                    one_zombie = one_zombie + 1
                    local vmdl = v:GetModel()
                    v:SetModel("models/player/zombie_classic.mdl")
                    v:EmitSound("npc/zombie/zombie_alert1.wav")

                    timer.Create("ZombieRoar1", 4, 2, function()
                        v:EmitSound("npc/zombie/zombie_voice_idle1.wav")
                    end)
                    timer.Create("ReturnMdl", 10, 1, function()
                        v:SetModel(vmdl)
                    end)
                end
            end
        end
    end
end

text035 = nil

concommand.Add("enablemasks", function()
    timer.Create("SoundMessage", 1, 1, function()
        surface.PlaySound("insane/new_message.wav")
        timer.Create("Testt11", 1.5, 1, function()
            text035 = "KILL EVERYONE, FREE EVERYONE!"
            LocalPlayer().draw_masks = true
            LocalPlayer().under_035 = true

            yss_module_victim035_message("KILL EVERYONE, FREE EVERYONE!")
        end)
    end)
end)

function yss_module_victim035_message(text)
    local lply = LocalPlayer()
    surface.PlaySound("whisp2.wav")
    timer.Create("DelayWhisp0351", 3, 1, function()
        surface.PlaySound("whisp2.wav")
    end)

    local wave2 = Material("scp_rot/center035.png", "noclamp smooth alphatest 1")
    local wave3 = Material("scp_rot/035high.png", "noclamp smooth alphatest 1")
    local approach = 1
    local approachtarget = 256
    local lastthink = 0
    local rate = 1
    text035 = text


    local task_font = {"DermaLarge", "CloseCaption_Bold", "Trebuchet24", "HudDefault", "Trebuchet18"}

    hook.Add( "Think", "HUDPaint035Task1", function()
        if not lply.draw_masks then return end
        approach = math.Approach(approach, approachtarget, 0.16)
    end)

    hook.Add("HUDPaint", "HUDPaint035Task2", function()
        if not lply.draw_masks then return end

        surface.SetMaterial( wave3 )
        surface.SetDrawColor(color_white)
        surface.DrawTexturedRect( ScrW()/2-approach/2, ScrH()/2-approach/2, approach, approach )

        surface.SetFont(task_font[math.random(1, #task_font)])
        surface.SetTextColor(255, 5, 0)
        local w, h = surface.GetTextSize(text)
        surface.SetTextPos(ScrW()/2-w/2, ScrH()/2-h/2)
        surface.DrawText(text)

        surface.SetTextPos(ScrW()/2, ScrH()/2)

        surface.SetMaterial( wave2 )
        surface.SetDrawColor(255, 0, 0, 55)
        for i=1,190 do
            surface.DrawTexturedRect(math.random(1, ScrW()), math.random(1, ScrH()), math.random(25, 64), math.random(25,64))
        end


        if approach == 256 then
            lply.draw_masks = false
        end
        if not lply.under_035 then return end
        surface.SetFont("DermaLarge")
        local w2, h2 = surface.GetTextSize(text035)
        surface.SetTextPos(ScrW()/2-w2/2, ScrH()-h2*2)
        surface.DrawText(text035)
    end)
end


hook.Add("HUDPaint", "BottomTask", function()
    lply = LocalPlayer()
    if not lply.under_035 then return end
    if text035 == nil then return end
        surface.SetFont("DermaLarge")
        local w2, h2 = surface.GetTextSize(text035)
        surface.SetTextPos(ScrW()/2-w2/2, ScrH()-h2*2)
        surface.DrawText(text035)
end)

hook.Add("Think", "LookatmeHector", function()
    lply = LocalPlayer()
    if not IsValid(lply) then return end
    for k,v in pairs(ents.FindInSphere(lply:GetPos(), 200)) do
        if v:IsPlayer() && v ~= lply then
            local mdl = v:GetModel()
            if mdl == "models/vinrax/props/scp035/035_mask.mdl" then
                yss_lookat035(lply, v)
            end
        end
    end
end)