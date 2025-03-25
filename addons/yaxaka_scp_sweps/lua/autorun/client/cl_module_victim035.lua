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
            if mdl == "models/scp_035_real/scp_035_real.mdl" then
                yss_lookat035(lply, v)
            end
        end
    end
end)

local modelMask = ClientsideModel( "models/scp_035_real/scp_035_real.mdl" )
modelMask:SetNoDraw( true )

scp035_maskplayer = nil

hook.Add("PostPlayerDraw", "SCP035_DrawMask", function(ply)
    if scp035_maskplayer == nil then return end
    if ply ~= scp035_maskplayer then return end
        local attachments = ply:GetAttachments()
        local keyEye = nil

        for key, value in ipairs(attachments) do
            if (value.name == "eyes") then keyEye = value.id end 
        end

        local offsetvec = keyEye and ply:GetAttachment( keyEye ).Pos or Vector(2.5, -5.6, 0 )
        local offsetang = keyEye and ply:GetAttachment( keyEye ).Ang or Angle( 180, 0, -180 )

        if (keyEye) then --? If player have eye attachment (very precise)
            local UpAng, RightAng, ForwardAng = offsetang:Up(), offsetang:Right(), offsetang:Forward()

            offsetvec = offsetvec + RightAng * 0 + ForwardAng * 1.6 + UpAng * -1.3
            offsetang:RotateAroundAxis(RightAng, 6)
            offsetang:RotateAroundAxis(UpAng, 0)
            offsetang:RotateAroundAxis(ForwardAng, 0)
            modelMask:SetRenderOrigin(offsetvec)
            modelMask:SetRenderAngles(offsetang)
        else --? And if he has not
            local boneid = ply:LookupBone( "ValveBiped.Bip01_Head1" )
        
            if not boneid then
                return
            end
            
            local matrix = ply:GetBoneMatrix( boneid )
            
            if not matrix then 
                return 
            end
            
            local newpos, newang = LocalToWorld( offsetvec, offsetang, matrix:GetTranslation(), matrix:GetAngles() )

            modelMask:SetPos( newpos )
            modelMask:SetAngles( newang )
            modelMask:SetupBones()
        end
        
        modelMask:DrawModel()
end)

--scp096bag = nil

local modelBag = ClientsideModel( "models/props_junk/garbage_bag001a.mdl" )
modelBag:SetNoDraw( true )

hook.Add("PostPlayerDraw", "SCP096_DrawMask", function(ply)
    if scp096bag == nil then return end
    if ply ~= scp096bag then return end
        local attachments = ply:GetAttachments()
        local keyEye = nil

        for key, value in ipairs(attachments) do
            if (value.name == "eyes") then keyEye = value.id end 
        end

        local offsetvec = keyEye and ply:GetAttachment( keyEye ).Pos or Vector(-1, -2, -1)
        local offsetang = keyEye and ply:GetAttachment( keyEye ).Ang or Angle(0, 0, -180)

        if (keyEye) then --? If player have eye attachment (very precise)
            local UpAng, RightAng, ForwardAng = offsetang:Up(), offsetang:Right(), offsetang:Forward()

            offsetvec = offsetvec + RightAng * 0 + ForwardAng * 1.6 + UpAng * -1.3
            offsetang:RotateAroundAxis(RightAng, 6)
            offsetang:RotateAroundAxis(UpAng, 0)
            offsetang:RotateAroundAxis(ForwardAng, 0)
            modelBag:SetRenderOrigin(offsetvec)
            modelBag:SetRenderAngles(offsetang)
        else --? And if he has not
            local boneid = ply:LookupBone( "ValveBiped.Bip01_Head1" ) 
        
            if not boneid then
                return
            end
            
            local matrix = ply:GetBoneMatrix( boneid )

            
            if not matrix then 
                return 
            end
            
            local newpos, newang = LocalToWorld( offsetvec, offsetang, matrix:GetTranslation(), matrix:GetAngles() )

            modelBag:SetPos( newpos )
            modelBag:SetAngles( newang )
            modelBag:SetupBones()
        end
        
        modelBag:DrawModel()
end)


