include("shared.lua")

local paymat = Material("terminal_pay.png", "noclamp smooth")
local scplogo = Material("scp_logo.png", "noclamp smooth")
local loginlogo = Material("terminal_login.png", "noclamp smooth")
local edlogo = Material("terminal_ed.png", "noclamp smooth")
local seclogo = Material("terminal_sec.png", "noclamp smooth")
local exlogo = Material("terminal_ex.png", "noclamp smooth")


surface.CreateFont( "font1", {
    font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer.
    extended = false,
    size = 172,
    weight = 700,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

surface.CreateFont( "font2", {
    font = "Consolas", -- Use the font-name which is shown to you by your operating system Font Viewer.
    extended = false,
    size = 120,
    weight = 600,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

surface.CreateFont( "font2_sub", {
    font = "Consolas", -- Use the font-name which is shown to you by your operating system Font Viewer.
    extended = false,
    size = 60,
    weight = 600,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

surface.CreateFont( "font3", {
    font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer.
    extended = false,
    size = 152,
    weight = 600,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )


ENT.RenderGroup = RENDERGROUP_TRANSLUCENT


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
        surface.SetDrawColor( 0, 98, 190, 255 )
        surface.DrawRect( 0, 0, 565 * res, 318 * res )
        imgui.xCursor(0, 0, 565 * res, 318 * res)

        surface.SetMaterial(scplogo)
        surface.DrawTexturedRect(8 * res, 5 * res, 48 * res, 48 * res)

        surface.SetFont("font2")
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
            surface.SetTextPos(195*res, 25*res)
            surface.DrawText("/MTF_DUTY")

            local nick = LocalPlayer():Nick()

            surface.SetFont("font2")
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
                self:SetPage(0)
                net.Start("yq_request")
                net.WriteInt(1, 11)
                net.SendToServer()
            end

            if expressed then
                self:SetPage(0)
            end

        elseif page == 2 then

            surface.SetFont("font2_sub")
            surface.SetTextPos(178*res, 24*res)
            surface.DrawText("/RESEARCH_JOB")


        elseif page == 405 then

            draw.SimpleText("Loading", "font1", 565 * res / 2, 318 * res / 2 + 400, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            surface.SetMaterial(paymat)
            surface.SetDrawColor(255, 255, 255)
            surface.DrawTexturedRect(201 * res, 70 * res, 164 * res, 110 * res)
        end


        imgui.End3D2D()
    end
end