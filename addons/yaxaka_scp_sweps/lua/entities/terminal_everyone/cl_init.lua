include("shared.lua")

local paymat = Material("terminal_pay.png", "noclamp smooth")
local scplogo = Material("scp_logo.png", "noclamp smooth")
local loginlogo = Material("terminal_login.png", "noclamp smooth")
local edlogo = Material("terminal_ed.png", "noclamp smooth")
local seclogo = Material("terminal_sec.png", "noclamp smooth")
local exlogo = Material("terminal_ex.png", "noclamp smooth")

local dnalogo = Material("terminal/dna.png", "noclamp smooth")
local chemlogo = Material("terminal/chem.png", "noclamp smooth")
local probalogo = Material("terminal/proba.png", "noclamp smooth")
local raportlogo = Material("terminal/raport.png", "noclamp smooth")

local injector1_icon = Material("terminal/injector1.png", "noclamp smooth")
local mix_empty_icon = Material("terminal/mix_empty.png", "noclamp smooth")
local other_icon = Material("terminal/other.png", "noclamp smooth")
local sintez_icon = Material("terminal/sintez.png", "noclamp smooth")
local dna_addlogo = Material("terminal/dna_add.png", "noclamp smooth")
local dna_editlogo = Material("terminal/dna_edit.png", "noclamp smooth")

yq_active_task = "Undefined"
yq_progress = 1 -- 53max
yr_bank_ent = nil

local first_obr = 'nil'
local second_obr = 'nil2'

local fobr = nil
local sobr = nil


ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()
    timer.Create("yr_skasearchforents", 3, 0, function()
        if not self:IsValid() then timer.Remove("yr_skasearchforents") return end
        for k,v in pairs(ents.FindInSphere(self:GetPos(), 200)) do
            local clas = v:GetClass()
            if clas == "yr_bank" then
                self:SetBank(true)
                yr_bank_ent = v
            end
        end
    end)
end

function ENT:DrawTranslucent()
    self:DrawModel()
    local ang = self:GetAngles()
    -- Change these numbers to rotate the screen correctly for your model
    ang:RotateAroundAxis( self:GetUp(), 90 )
    ang:RotateAroundAxis( self:GetRight(), -90 )
    ang:RotateAroundAxis( self:GetForward(), 0 )

    local pos = self:GetPos()
    -- Change these numbers to position the screen on your model
    pos = pos + self:GetForward() * 1.72
    pos = pos + self:GetRight() * 14.09
    pos = pos + self:GetUp() * 20.7

    -- Higher the value, the better the res
    local res = 5
    local circle = 0

    if imgui.Start3D2D( pos, ang, 0.05 / res, 200, 150 ) then
        surface.SetDrawColor( 199, 170, 116, 255 )
        surface.DrawRect( 0, 0, 565 * res, 318 * res )
        imgui.xCursor(0, 0, 565 * res, 318 * res)

        local bank_obr = self:GetBank()
        local res_bot = self:GetResearchBot()
        local sintezator = self:GetSintezator()
        local chem_lab = self:GetChemLab()
        local dna_redactor = self:GetDNARedactor()

        local bank_obr_clr = nil
        local res_bot_clr = nil
        local sintezator_clr = nil
        local chem_lab_clr = nil
        local dna_redactor_clr = nil
        local green = Color(0, 255, 0)
        local red = Color(255, 0, 0)

        if self:GetBank() then
            bank_obr_clr = green
        else
            bank_obr_clr = red
        end

        if self:GetResearchBot() then
            res_bot_clr = green
        else
            res_bot_clr = red
        end

        if self:GetSintezator() then
            sintezator_clr = green
        else
            sintezator_clr = red
        end

        if self:GetChemLab() then
            chem_lab_clr = green
        else
            chem_lab_clr = red
        end

        if self:GetDNARedactor() then
            dna_redactor_clr = green
        else
            dna_redactor_clr = red
        end

        surface.SetMaterial(scplogo)
        surface.DrawTexturedRect(8 * res, 5 * res, 48 * res, 48 * res)

        surface.SetFont("font_tektur")
        surface.SetTextColor(0, 0, 0)
        surface.SetTextPos(58 * res, 17 * res)
        surface.DrawText("RAT-Terminal")
        local page = self:GetPage()

        if page == 0 or page == 405 then
            surface.SetDrawColor(255, 0, 0)
        else
            surface.SetDrawColor(0, 255, 0)
        end


        surface.SetMaterial(loginlogo)
        surface.DrawTexturedRect(518 * res, 17 * res, 22 * res, 22 * res)


        if page == 0 then
            circle = 0

            local loginpressed = imgui.xButtonImage(paymat, 201 * res, 70 * res, 164 * res, 110 * res, 1, Color(0,0,0), Color(255,255,255), Color(128,128,128))
            draw.SimpleText("Access Required", "font1", 565 * res / 2, 318 * res / 2 + 400, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

            if loginpressed then
                self:EmitSound("terminal_beep.wav")
                self:SetPage(405)
                timer.Create(self:EntIndex() .. "_beepwait", 1, 1, function()
                    local fact = (ix.faction.Get(LocalPlayer():Team()).name)
                    print(fact)
                    if fact == "МОГ Эпсилон-11" then
                        self:SetPage(1)
                    elseif fact == "Научный персонал" then
                        self:SetPage(2)
                    else
                        self:SetPage(0)
                        self:EmitSound("buttons/combine_button1.wav")
                    end
                end)
            end

        elseif page == 1 then

            surface.SetFont("font2_sub")
            surface.SetTextPos(182*res, 25*res)
            surface.DrawText("/MTF_DUTY")

            local nick = LocalPlayer():Nick()

            surface.SetFont("font_tektur")
            local w, h = surface.GetTextSize(nick)


            surface.SetTextPos(40*res, 79*res)
            surface.SetTextColor(0, 0, 0)
            surface.DrawText(nick)

            surface.SetDrawColor(0, 0, 0)
            surface.DrawOutlinedRect(33*res, 102*res, 500*res, 182*res, 2*res)
            surface.DrawOutlinedRect(33*res, 78*res, w+15*res, 26*res, 2*res)

            local edpressed = imgui.xButtonImage(edlogo, 72 * res, 117 * res, 113 * res, 120 * res, 1, Color(0,0,0), Color(255,255,255), Color(128,128,128))
            local secpressed = imgui.xButtonImage(seclogo, 235 * res, 125 * res, 95 * res, 95 * res, 1, Color(0,0,0), Color(255,255,255), Color(128,128,128))
            local expressed = imgui.xButtonImage(exlogo, 393 * res, 130 * res, 90 * res, 90 * res, 1, Color(0,0,0), Color(255,255,255), Color(128,128,128))

            surface.SetFont("font3")
            surface.SetTextPos(69*res, 229*res)
            surface.DrawText("Обучение")
            surface.SetTextPos(239*res, 229*res)
            surface.DrawText("Охрана")
            surface.SetTextPos(393*res, 229*res)
            surface.DrawText("Выход")

            if edpressed then
                drawedu()
            end

            if secpressed then
                local frame = vgui.Create( "DFrame" )
                frame:SetSize( 100, 60 )
                frame:Center()
                frame:MakePopup()
                frame:SetTitle("")

                local DComboBox = vgui.Create( "DComboBox", frame )
                DComboBox:SetPos( 5, 30 )
                DComboBox:SetSize( 100, 20 )
                DComboBox:SetValue( "Задания" )
                DComboBox:AddChoice( "Охрана одной зоны", "Охрана" )
                DComboBox:AddChoice( "Патрулирование", "Патрулирование" )
                DComboBox.OnSelect = function(index, value, data)
                    self:SetPage(3)
                    yq_active_task = data
                    frame:Close()
                    net.Start("yq_request")
                    net.WriteInt(value, 11)
                    net.SendToServer()
                    yas_bclick()
                end
            end

            if expressed then
                self:SetPage(0)
            end

        elseif page == 2 then

            surface.SetFont("font2_sub")
            surface.SetTextPos(178*res, 24*res)
            surface.DrawText("/RESEARCH_JOB")

            local nick = LocalPlayer():Nick()

            surface.SetFont("font_tektur")
            local w, h = surface.GetTextSize(nick)


            surface.SetTextPos(40*res, 79*res)
            surface.SetTextColor(0, 0, 0)
            surface.DrawText(nick)

            surface.SetDrawColor(0, 0, 0)
            surface.DrawOutlinedRect(33*res, 102*res, 500*res, 182*res, 2*res)
            surface.DrawOutlinedRect(33*res, 78*res, w+15*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+88.65*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+87.65+165*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+87.65+279*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+87.65+305*res, 26*res, 2*res)
            surface.DrawOutlinedRect(507*res, 282*res, 26*res, 26*res, 2*res)
            surface.DrawOutlinedRect(483*res, 282*res, 26*res, 26*res, 2*res)

            surface.SetFont("font_tektur_normal")
            surface.SetTextPos(77*res, 282*res)
            surface.DrawText("ДНК")
            surface.SetTextPos(151*res, 282*res)
            surface.DrawText("Химия")
            surface.SetTextPos(242*res, 282*res)
            surface.DrawText("Образцы")

            surface.SetMaterial(dnalogo)
            surface.DrawTexturedRect(34*res+7*res, 288.8*res, 30*res, 12*res)
            surface.SetMaterial(chemlogo)
            surface.DrawTexturedRect(34*res+res+93*res, 285.5*res, 22*res, 19*res)
            surface.SetMaterial(probalogo)
            surface.DrawTexturedRect(34*res+res+89.5*res+97*res, 286*res, 18*res, 18*res)
            surface.SetMaterial(raportlogo)
            surface.DrawTexturedRect(34*res+res+89.5*res+93*res+118*res, 286*res, 18*res, 18*res)

            surface.SetTextPos(50*res, 119*res)
            surface.SetFont("font_tektur2")
            surface.DrawText("Статус модулей")

            surface.SetTextPos(50*res, 159*res)
            surface.SetFont("font_tektur_normal")
            surface.DrawText("Редактор ДНК:")            

            surface.SetFont("font_tektur2")
            surface.SetTextPos(185*res, 152*res)
            surface.SetTextColor(dna_redactor_clr)
            surface.DrawText("⚫")

            surface.SetTextColor(0, 0, 0)
            surface.SetTextPos(50*res, 179*res)
            surface.SetFont("font_tektur_normal")
            surface.DrawText("Химический синтезатор:")            

            surface.SetFont("font_tektur2")
            surface.SetTextPos(285*res, 173*res)
            surface.SetTextColor(chem_lab_clr)
            surface.DrawText("⚫")

            surface.SetTextColor(0, 0, 0)
            surface.SetTextPos(50*res, 199*res)
            surface.SetFont("font_tektur_normal")
            surface.DrawText("Банк образцов:")            

            surface.SetFont("font_tektur2")
            surface.SetTextPos(195*res, 193*res)
            surface.SetTextColor(bank_obr_clr)
            surface.DrawText("⚫")

            surface.SetTextColor(0, 0, 0)
            surface.SetTextPos(50*res, 219*res)
            surface.SetFont("font_tektur_normal")
            surface.DrawText("Исследователь:")            

            surface.SetFont("font_tektur2")
            surface.SetTextPos(198*res, 213*res)
            surface.SetTextColor(chem_lab_clr)
            surface.DrawText("⚫")

            surface.SetTextColor(0, 0, 0)
            surface.SetTextPos(50*res, 239*res)
            surface.SetFont("font_tektur_normal")
            surface.DrawText("Аппарат приготовления:")            

            surface.SetFont("font_tektur2")
            surface.SetTextPos(282*res, 233*res)
            surface.SetTextColor(chem_lab_clr)
            surface.DrawText("⚫")

            local dna = imgui.xButton(34*res, 283.5*res, 89.5*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))
            local chem = imgui.xButton(34*res+res+89*res, 283.5*res, 93*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))
            local proba = imgui.xButton(34*res+res+89.5*res+93*res, 283.5*res, 113*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))
            local raport = imgui.xButton(34*res+res+89.5*res+93*res+115*res, 283.5*res, 24*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))
            

            if dna then self:SetPage(4) end

            local expressed = imgui.xButtonImage(exlogo, 509.5 * res, 285.5 * res, 21 * res, 21 * res, 1, Color(0,0,0), Color(255,255,255), Color(128,128,128))
            local other = imgui.xButtonImage(other_icon, 487.4 * res, 286.8 * res, 17 * res, 17 * res, 1, Color(0,0,0), Color(255,255,255), Color(128,128,128))

            if expressed then self:SetPage(0) yas_bclick() end
            if chem then self:SetPage(5) yas_bclick() end
            if proba then self:SetPage(6) yas_bclick() end
            if raport then self:SetPage(7) yas_bclick() end

        elseif page == 3 then

            local nick = LocalPlayer():Nick()

            surface.SetFont("font_tektur")
            local w, h = surface.GetTextSize(nick)
            surface.SetTextPos(40*res, 79*res)
            surface.SetTextColor(0, 0, 0)
            surface.DrawText(nick)

            surface.SetDrawColor(0, 0, 0)
            surface.DrawOutlinedRect(33*res, 102*res, 500*res, 182*res, 2*res)
            surface.DrawOutlinedRect(33*res, 78*res, w+15*res, 26*res, 2*res)  


            surface.DrawOutlinedRect(63*res, 212*res, 440*res, 25*res, 2*res) 

            surface.SetMaterial(seclogo)
            surface.DrawTexturedRect(39*res, 110*res, 40*res, 40*res)

            surface.SetFont("font_tektur2")
            local w, h = surface.GetTextSize(yq_active_task)
            surface.SetTextPos(565/2*res-w/2, 162*res)
            surface.DrawText(yq_active_task)

            surface.DrawRect(69*res, 215*res, 5*res, 19*res)

            for i=1,yq_progress do
                surface.DrawRect((69*res)+i*40, 215*res, 5*res, 19*res)
            end

            if yq_active_task == "Undefined" then
                self:SetPage(0)
            end

        elseif page == 4 then -- dna
            surface.SetFont("font2_sub")
            surface.SetTextPos(178*res, 24*res)
            surface.DrawText("/RESEARCH_JOB")

            local nick = LocalPlayer():Nick()

            surface.SetFont("font_tektur")
            local w, h = surface.GetTextSize(nick)


            surface.SetTextPos(40*res, 79*res)
            surface.SetTextColor(0, 0, 0)
            surface.DrawText(nick)

            surface.SetDrawColor(0, 0, 0)
            surface.DrawOutlinedRect(33*res, 102*res, 500*res, 182*res, 2*res)
            surface.DrawOutlinedRect(33*res, 78*res, w+15*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+88.65*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+87.65+165*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+87.65+279*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+87.65+305*res, 26*res, 2*res)
            surface.DrawOutlinedRect(507*res, 282*res, 26*res, 26*res, 2*res)
            surface.DrawOutlinedRect(483*res, 282*res, 26*res, 26*res, 2*res)

            surface.SetFont("font_tektur_normal")
            surface.SetTextPos(77*res, 282*res)
            surface.DrawText("ДНК")
            surface.SetTextPos(151*res, 282*res)
            surface.DrawText("Химия")
            surface.SetTextPos(242*res, 282*res)
            surface.DrawText("Образцы")

            surface.SetMaterial(dnalogo)
            surface.DrawTexturedRect(34*res+7*res, 288.8*res, 30*res, 12*res)
            surface.SetMaterial(chemlogo)
            surface.DrawTexturedRect(34*res+res+93*res, 285.5*res, 22*res, 19*res)
            surface.SetMaterial(probalogo)
            surface.DrawTexturedRect(34*res+res+89.5*res+97*res, 286*res, 18*res, 18*res)
            surface.SetMaterial(raportlogo)
            surface.DrawTexturedRect(34*res+res+89.5*res+93*res+118*res, 286*res, 18*res, 18*res)


            surface.SetDrawColor(color_white)
            surface.DrawOutlinedRect(34*res, 283.5*res, 89.5*res, 23*res, 1*res)
            surface.SetDrawColor(0, 0, 0)
            local chem = imgui.xButton(34*res+res+89*res, 283.5*res, 93*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))
            local proba = imgui.xButton(34*res+res+89.5*res+93*res, 283.5*res, 113*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))
            local raport = imgui.xButton(34*res+res+89.5*res+93*res+115*res, 283.5*res, 24*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))
            

            local dna_add = imgui.xButtonImage(dna_addlogo, 73*res, 149*res, 165*res, 95*res, 6, Color(0, 0, 0), color_white, Color(255, 0, 0))
            local dna_edit = imgui.xButtonImage(dna_addlogo, 315*res, 149*res, 165*res, 95*res, 6, Color(0, 0, 0), color_white, Color(255, 0, 0))
            

            local expressed = imgui.xButtonImage(exlogo, 509.5 * res, 285.5 * res, 21 * res, 21 * res, 1, Color(0,0,0), Color(255,255,255), Color(128,128,128))
            local other = imgui.xButtonImage(other_icon, 487.4 * res, 286.8 * res, 17 * res, 17 * res, 1, Color(0,0,0), Color(255,255,255), Color(128,128,128))



            if dna then self:SetPage(4) yas_bclick() end
            if expressed then self:SetPage(2) yas_bclick() end
            if chem then self:SetPage(5) yas_bclick() end
            if proba then self:SetPage(6) yas_bclick() end
            if raport then self:SetPage(7) yas_bclick() end

        elseif page == 5 then -- chem
            surface.SetFont("font2_sub")
            surface.SetTextPos(178*res, 24*res)
            surface.DrawText("/RESEARCH_JOB")

            local nick = LocalPlayer():Nick()

            surface.SetFont("font_tektur")
            local w, h = surface.GetTextSize(nick)


            surface.SetTextPos(40*res, 79*res)
            surface.SetTextColor(0, 0, 0)
            surface.DrawText(nick)

            surface.SetDrawColor(0, 0, 0)
            surface.DrawOutlinedRect(33*res, 102*res, 500*res, 182*res, 2*res)
            surface.DrawOutlinedRect(33*res, 78*res, w+15*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+88.65*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+87.65+165*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+87.65+279*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+87.65+305*res, 26*res, 2*res)
            surface.DrawOutlinedRect(507*res, 282*res, 26*res, 26*res, 2*res)
            surface.DrawOutlinedRect(483*res, 282*res, 26*res, 26*res, 2*res)

            surface.SetFont("font_tektur_normal")
            surface.SetTextPos(77*res, 282*res)
            surface.DrawText("ДНК")
            surface.SetTextPos(151*res, 282*res)
            surface.DrawText("Химия")
            surface.SetTextPos(242*res, 282*res)
            surface.DrawText("Образцы")

            surface.SetMaterial(dnalogo)
            surface.DrawTexturedRect(34*res+7*res, 288.8*res, 30*res, 12*res)
            surface.SetMaterial(chemlogo)
            surface.DrawTexturedRect(34*res+res+93*res, 285.5*res, 22*res, 19*res)
            surface.SetMaterial(probalogo)
            surface.DrawTexturedRect(34*res+res+89.5*res+97*res, 286*res, 18*res, 18*res)
            surface.SetMaterial(raportlogo)
            surface.DrawTexturedRect(34*res+res+89.5*res+93*res+118*res, 286*res, 18*res, 18*res)


            surface.SetDrawColor(color_white)
            surface.DrawOutlinedRect(34*res+res+89*res, 283.5*res, 93*res, 23*res, 1*res)
            surface.SetDrawColor(0, 0, 0)

            local proba = imgui.xButton(34*res+res+89.5*res+93*res, 283.5*res, 113*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))
            local raport = imgui.xButton(34*res+res+89.5*res+93*res+115*res, 283.5*res, 24*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))
            local dna = imgui.xButton(34*res, 283.5*res, 89.5*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))


            local research = imgui.xButtonImageUnder(0, 0, "Исследовать", "font_tektur", chemlogo, 55 * res, 127 * res, 115 * res, 98 * res, 1, Color(0,0,0), Color(255,255,255), Color(128,128,128))
            local sintez = imgui.xButtonImageUnder(-30*res, 0, "Синтезировать", "font_tektur", sintez_icon, 240 * res, 127 * res, 110 * res, 98 * res, 1, Color(0,0,0), Color(255,255,255), Color(128,128,128))
            local cook = imgui.xButtonImageUnder(-22*res, 0, "Приготовить", "font_tektur", injector1_icon, 410 * res, 127 * res, 95 * res, 98 * res, 1, Color(0,0,0), Color(255,255,255), Color(128,128,128))


            local expressed = imgui.xButtonImage(exlogo, 509.5 * res, 285.5 * res, 21 * res, 21 * res, 1, Color(0,0,0), Color(255,255,255), Color(128,128,128))
            local other = imgui.xButtonImage(other_icon, 487.4 * res, 286.8 * res, 17 * res, 17 * res, 1, Color(0,0,0), Color(255,255,255), Color(128,128,128))

            if sintez then self:SetPage(51) yas_bclick() end

            if dna then self:SetPage(4) yas_bclick() end
            if expressed then self:SetPage(2) yas_bclick() end
            if proba then self:SetPage(6) yas_bclick() end
            if raport then self:SetPage(7) yas_bclick() end
            if research then self:SetPage(8) yas_bclick() end

        elseif page == 6 then -- proba
            surface.SetFont("font2_sub")
            surface.SetTextPos(178*res, 24*res)
            surface.DrawText("/RESEARCH_JOB")

            local nick = LocalPlayer():Nick()

            surface.SetFont("font_tektur")
            local w, h = surface.GetTextSize(nick)


            surface.SetTextPos(40*res, 79*res)
            surface.SetTextColor(0, 0, 0)
            surface.DrawText(nick)

            surface.SetDrawColor(0, 0, 0)
            surface.DrawOutlinedRect(33*res, 102*res, 500*res, 182*res, 2*res)
            surface.DrawOutlinedRect(33*res, 78*res, w+15*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+88.65*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+87.65+165*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+87.65+279*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+87.65+305*res, 26*res, 2*res)
            surface.DrawOutlinedRect(507*res, 282*res, 26*res, 26*res, 2*res)
            surface.DrawOutlinedRect(483*res, 282*res, 26*res, 26*res, 2*res)

            surface.SetFont("font_tektur_normal")
            surface.SetTextPos(77*res, 282*res)
            surface.DrawText("ДНК")
            surface.SetTextPos(151*res, 282*res)
            surface.DrawText("Химия")
            surface.SetTextPos(242*res, 282*res)
            surface.DrawText("Образцы")

            surface.SetMaterial(dnalogo)
            surface.DrawTexturedRect(34*res+7*res, 288.8*res, 30*res, 12*res)
            surface.SetMaterial(chemlogo)
            surface.DrawTexturedRect(34*res+res+93*res, 285.5*res, 22*res, 19*res)
            surface.SetMaterial(probalogo)
            surface.DrawTexturedRect(34*res+res+89.5*res+97*res, 286*res, 18*res, 18*res)
            surface.SetMaterial(raportlogo)
            surface.DrawTexturedRect(34*res+res+89.5*res+93*res+118*res, 286*res, 18*res, 18*res)


            surface.SetDrawColor(color_white)
            surface.DrawOutlinedRect(34*res+res+89.5*res+93*res, 283.5*res, 113*res, 23*res, 1*res)
            surface.SetDrawColor(0, 0, 0)

            local raport = imgui.xButton(34*res+res+89.5*res+93*res+115*res, 283.5*res, 24*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))
            local dna = imgui.xButton(34*res, 283.5*res, 89.5*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))
            local chem = imgui.xButton(34*res+res+89*res, 283.5*res, 93*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))


            local expressed = imgui.xButtonImage(exlogo, 509.5 * res, 285.5 * res, 21 * res, 21 * res, 1, Color(0,0,0), Color(255,255,255), Color(128,128,128))
            local other = imgui.xButtonImage(other_icon, 487.4 * res, 286.8 * res, 17 * res, 17 * res, 1, Color(0,0,0), Color(255,255,255), Color(128,128,128))

            if dna then self:SetPage(4) yas_bclick() end
            if expressed then self:SetPage(2) yas_bclick() end
            if chem then self:SetPage(5) yas_bclick() end
            if raport then self:SetPage(7) yas_bclick() end

        elseif page == 7 then -- raport

            surface.SetFont("font2_sub")
            surface.SetTextPos(178*res, 24*res)
            surface.DrawText("/RESEARCH_JOB")

            local nick = LocalPlayer():Nick()

            surface.SetFont("font_tektur")
            local w, h = surface.GetTextSize(nick)


            surface.SetTextPos(40*res, 79*res)
            surface.SetTextColor(0, 0, 0)
            surface.DrawText(nick)

            surface.SetDrawColor(0, 0, 0)
            surface.DrawOutlinedRect(33*res, 102*res, 500*res, 182*res, 2*res)
            surface.DrawOutlinedRect(33*res, 78*res, w+15*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+88.65*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+87.65+165*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+87.65+279*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+87.65+305*res, 26*res, 2*res)
            surface.DrawOutlinedRect(507*res, 282*res, 26*res, 26*res, 2*res)
            surface.DrawOutlinedRect(483*res, 282*res, 26*res, 26*res, 2*res)

            surface.SetFont("font_tektur_normal")
            surface.SetTextPos(77*res, 282*res)
            surface.DrawText("ДНК")
            surface.SetTextPos(151*res, 282*res)
            surface.DrawText("Химия")
            surface.SetTextPos(242*res, 282*res)
            surface.DrawText("Образцы")

            surface.SetMaterial(dnalogo)
            surface.DrawTexturedRect(34*res+7*res, 288.8*res, 30*res, 12*res)
            surface.SetMaterial(chemlogo)
            surface.DrawTexturedRect(34*res+res+93*res, 285.5*res, 22*res, 19*res)
            surface.SetMaterial(probalogo)
            surface.DrawTexturedRect(34*res+res+89.5*res+97*res, 286*res, 18*res, 18*res)
            surface.SetMaterial(raportlogo)
            surface.DrawTexturedRect(34*res+res+89.5*res+93*res+118*res, 286*res, 18*res, 18*res)


            surface.SetDrawColor(color_white)
            surface.DrawOutlinedRect(34*res+res+89.5*res+93*res+115*res, 283.5*res, 24*res, 23*res, 1*res)
            surface.SetDrawColor(0, 0, 0)

            local dna = imgui.xButton(34*res, 283.5*res, 89.5*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))
            local chem = imgui.xButton(34*res+res+89*res, 283.5*res, 93*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))
            local proba = imgui.xButton(34*res+res+89.5*res+93*res, 283.5*res, 113*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))
            

            if dna then self:SetPage(4) yas_bclick() end

            local expressed = imgui.xButtonImage(exlogo, 509.5 * res, 285.5 * res, 21 * res, 21 * res, 1, Color(0,0,0), Color(255,255,255), Color(128,128,128))
            local other = imgui.xButtonImage(other_icon, 487.4 * res, 286.8 * res, 17 * res, 17 * res, 1, Color(0,0,0), Color(255,255,255), Color(128,128,128))

            if expressed then self:SetPage(0) yas_bclick() end
            if chem then self:SetPage(5) yas_bclick() end
            if proba then self:SetPage(6) yas_bclick() end
            if raport then self:SetPage(7) yas_bclick() end

        elseif page == 8 then -- chem_research
            surface.SetFont("font2_sub")
            surface.SetTextPos(178*res, 24*res)
            surface.DrawText("/RESEARCH_JOB")

            local nick = LocalPlayer():Nick()

            surface.SetFont("font_tektur")
            local w, h = surface.GetTextSize(nick)


            surface.SetTextPos(40*res, 79*res)
            surface.SetTextColor(0, 0, 0)
            surface.DrawText(nick)

            surface.SetDrawColor(0, 0, 0)
            surface.DrawOutlinedRect(33*res, 102*res, 500*res, 182*res, 2*res)
            surface.DrawOutlinedRect(33*res, 78*res, w+15*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+88.65*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+87.65+165*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+87.65+279*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+87.65+305*res, 26*res, 2*res)
            surface.DrawOutlinedRect(507*res, 282*res, 26*res, 26*res, 2*res)
            surface.DrawOutlinedRect(483*res, 282*res, 26*res, 26*res, 2*res)

            surface.SetFont("font_tektur_normal")
            surface.SetTextPos(77*res, 282*res)
            surface.DrawText("ДНК")
            surface.SetTextPos(151*res, 282*res)
            surface.DrawText("Химия")
            surface.SetTextPos(242*res, 282*res)
            surface.DrawText("Образцы")
            surface.SetTextPos(60*res, 108*res)
            surface.DrawText("Статус банка образцов: ")
            surface.SetTextColor(bank_obr_clr)
            surface.SetTextPos(285*res, 107*res)
            surface.DrawText("⚫")

            surface.SetMaterial(dnalogo)
            surface.DrawTexturedRect(34*res+7*res, 288.8*res, 30*res, 12*res)
            surface.SetMaterial(chemlogo)
            surface.DrawTexturedRect(34*res+res+93*res, 285.5*res, 22*res, 19*res)
            surface.SetMaterial(probalogo)
            surface.DrawTexturedRect(34*res+res+89.5*res+97*res, 286*res, 18*res, 18*res)
            surface.SetMaterial(raportlogo)
            surface.DrawTexturedRect(34*res+res+89.5*res+93*res+118*res, 286*res, 18*res, 18*res)




            surface.SetDrawColor(color_white)
            surface.DrawOutlinedRect(34*res+res+89*res, 283.5*res, 93*res, 23*res, 1*res)
            surface.SetDrawColor(0, 0, 0)

            local proba = imgui.xButton(34*res+res+89.5*res+93*res, 283.5*res, 113*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))
            local raport = imgui.xButton(34*res+res+89.5*res+93*res+115*res, 283.5*res, 24*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))
            local dna = imgui.xButton(34*res, 283.5*res, 89.5*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))


            local expressed = imgui.xButtonImage(exlogo, 509.5 * res, 285.5 * res, 21 * res, 21 * res, 1, Color(0,0,0), Color(255,255,255), Color(128,128,128))
            local other = imgui.xButtonImage(other_icon, 487.4 * res, 286.8 * res, 17 * res, 17 * res, 1, Color(0,0,0), Color(255,255,255), Color(128,128,128))

            if dna then self:SetPage(4) yas_bclick() end
            if expressed then self:SetPage(2) yas_bclick() end
            if proba then self:SetPage(6) yas_bclick() end
            if raport then self:SetPage(7) yas_bclick() end

        elseif page == 51 then -- chem_sintez
            surface.SetFont("font2_sub")
            surface.SetTextPos(178*res, 24*res)
            surface.DrawText("/RESEARCH_JOB")

            local nick = LocalPlayer():Nick()

            surface.SetFont("font_tektur")
            local w, h = surface.GetTextSize(nick)


            surface.SetTextPos(40*res, 79*res)
            surface.SetTextColor(0, 0, 0)
            surface.DrawText(nick)

            surface.SetDrawColor(0, 0, 0)
            surface.DrawOutlinedRect(33*res, 102*res, 500*res, 182*res, 2*res)
            surface.DrawOutlinedRect(33*res, 78*res, w+15*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+88.65*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+87.65+165*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+87.65+279*res, 26*res, 2*res)
            surface.DrawOutlinedRect(33*res, 282*res, 15+87.65+305*res, 26*res, 2*res)
            surface.DrawOutlinedRect(507*res, 282*res, 26*res, 26*res, 2*res)
            surface.DrawOutlinedRect(483*res, 282*res, 26*res, 26*res, 2*res)

            surface.SetFont("font_tektur_normal")
            surface.SetTextPos(77*res, 282*res)
            surface.DrawText("ДНК")
            surface.SetTextPos(151*res, 282*res)
            surface.DrawText("Химия")
            surface.SetTextPos(242*res, 282*res)
            surface.DrawText("Образцы")

            surface.SetMaterial(dnalogo)
            surface.DrawTexturedRect(34*res+7*res, 288.8*res, 30*res, 12*res)
            surface.SetMaterial(chemlogo)
            surface.DrawTexturedRect(34*res+res+93*res, 285.5*res, 22*res, 19*res)
            surface.SetMaterial(probalogo)
            surface.DrawTexturedRect(34*res+res+89.5*res+97*res, 286*res, 18*res, 18*res)
            surface.SetMaterial(raportlogo)
            surface.DrawTexturedRect(34*res+res+89.5*res+93*res+118*res, 286*res, 18*res, 18*res)


            surface.SetDrawColor(color_white)
            surface.DrawOutlinedRect(34*res+res+89*res, 283.5*res, 93*res, 23*res, 1*res)
            surface.SetDrawColor(0, 0, 0)

            local proba = imgui.xButton(34*res+res+89.5*res+93*res, 283.5*res, 113*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))
            local raport = imgui.xButton(34*res+res+89.5*res+93*res+115*res, 283.5*res, 24*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))
            local dna = imgui.xButton(34*res, 283.5*res, 89.5*res, 23*res, 6, Color(0, 0, 0, 0), color_white, Color(255, 0, 0))

            local first = imgui.xButtonImageUnder(-100, 5*res, fobr or "Загрузить", "font_tektur_normal", mix_empty_icon, 80*res, 140*res, 60*res, 80*res, 5, Color(0, 0, 0), color_white, Color(128, 128, 128))
            local second = imgui.xButtonImageUnder(-100, 5*res, sobr or "Загрузить", "font_tektur_normal", mix_empty_icon, 220*res, 140*res, 60*res, 80*res, 5, Color(0, 0, 0), color_white, Color(128, 128, 128))
            local start = imgui.xButtonTerminal("Начать синтез", "font_tektur_normal", 340*res, 150*res, 10, Color(0, 0, 0), Color(255, 255, 255), Color(128, 128, 128))
            local reset = imgui.xButtonTerminal("Сбросить", "font_tektur_normal", 340*res, 200*res, 10, Color(0, 0, 0), Color(255, 255, 255), Color(128, 128, 128))

            local expressed = imgui.xButtonImage(exlogo, 509.5 * res, 285.5 * res, 21 * res, 21 * res, 1, Color(0,0,0), Color(255,255,255), Color(128,128,128))
            local other = imgui.xButtonImage(other_icon, 487.4 * res, 286.8 * res, 17 * res, 17 * res, 1, Color(0,0,0), Color(255,255,255), Color(128,128,128))


            if first then
                yas_bclick()
                if not self:GetBank() or not yr_bank_ent:IsValid() or yr_bank_ent:GetItem() == "Не выбрано" then
                    LocalPlayer():Notify("Образец не выбран в банке!")
                else
                    if first_obr == second_obr then
                        LocalPlayer():Notify("Вы выбрали два одинаковых образца!")
                    else
                        first_obr = yr_bank_ent:GetItem()
                        fobr = yr_bank_ent:GetItem()
                        print(first_obr .. fobr)
                        LocalPlayer():Notify("Образец загружен")
                    end
                end
            end

            if second then
                yas_bclick()
                if not self:GetBank() or not yr_bank_ent:IsValid() or yr_bank_ent:GetItem() == "Не выбрано" then
                    LocalPlayer():Notify("Образец не выбран в банке!")
                else
                    if second_obr == first_obr then
                        LocalPlayer():Notify("Вы выбрали два одинаковых образца!")
                    else
                        second_obr = yr_bank_ent:GetItem()
                        sobr = yr_bank_ent:GetItem()
                        print(second_obr .. sobr)
                        LocalPlayer():Notify("Образец загружен")
                    end
                end
            end

            if start then
                yas_bclick()
                print(first_obr)
                print(second_obr)
                if first_obr == 'nil' or second_obr == 'nil2' then
                    LocalPlayer():Notify("Загрузите два образца перед началом работы!")
                else
                    if first_obr ~= second_obr then
                        call_sendnewgui(first_obr, second_obr, self)
                    else
                        LocalPlayer():Notify("Вы выбрали два одинаковых образца!")
                    end
                end
            end

            if reset then
                first_obr = 'nil'
                second_obr = 'nil2'
                fobr = nil
                sobr = nil
            end

            if dna then self:SetPage(4) yas_bclick() end
            if expressed then self:SetPage(2) yas_bclick() end
            if proba then self:SetPage(6) yas_bclick() end
            if raport then self:SetPage(7) yas_bclick() end
            if research then self:SetPage(8) yas_bclick() end

        elseif page == 405 then

            draw.SimpleText("Loading", "font1", 565 * res / 2, 318 * res / 2 + 400, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            surface.SetMaterial(paymat)
            surface.SetDrawColor(255, 255, 255)
            surface.DrawTexturedRect(201 * res, 70 * res, 164 * res, 110 * res)
            first_obr = 'nil'
            second_obr = 'nil2'

            fobr = nil
            sobr = nil
        elseif page == 406 then

            surface.SetMaterial(chemlogo)
            surface.SetDrawColor(0, 255, 0)
            surface.DrawTexturedRect(201 * res, 70 * res, 164 * res, 110 * res)
            first_obr = 'nil'
            second_obr = 'nil2'

            fobr = nil
            sobr = nil

        end


        imgui.End3D2D()
    end
end