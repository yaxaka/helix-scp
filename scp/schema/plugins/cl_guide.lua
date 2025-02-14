net.Receive("GuidanceY", function()
   
end)

concommand.Add( "guidance", function()
    guidancey()
end)

function guidancey()
    local DermaFrame = vgui.Create( "DFrame" )
    DermaFrame:Center()
    DermaFrame:SetPos(ScrW()/2-150, ScrH()/2-150)
    DermaFrame:SetSize( 300, 200 )
    DermaFrame:SetTitle( "" )
    DermaFrame:SetDraggable(false)
    DermaFrame:SetVisible( true )
    DermaFrame:MakePopup()
    DermaFrame.Paint = function()
        draw.RoundedBox( 8, 0, 0, DermaFrame:GetWide(), DermaFrame:GetTall(), Color( 43, 43, 43, 255 ) )
    end

    local DermaButton = vgui.Create( "DButton", DermaFrame ) 
    DermaButton:SetText( "Устав SEAF" )                 
    DermaButton:SetTextColor(Color(255, 255, 255, 255))
    DermaButton:SetPos( 25, 40 )                    
    DermaButton:SetSize( 250, 30 )                
    DermaButton.Paint = function() -- The paint function
        surface.SetDrawColor( 68, 87, 101, 255 ) -- What color do You want to paint the button (R, B, G, A)
        surface.DrawRect( 0, 0, DermaButton:GetWide(), DermaButton:GetTall() ) -- Paint what coords (Used a function to figure that out)
    end
    DermaButton.DoClick = function()
        gui.OpenURL("https://docs.google.com/document/d/1C9LH3OiidiKHVPZVeRHP5LfQlZ9duDsjsdYpKBYAzRk/edit?usp=sharing")                
    end


    local DermaButton2 = vgui.Create( "DButton", DermaFrame ) 
    DermaButton2:SetText( "Лор HELLDIVERS" )                 
    DermaButton2:SetTextColor(Color(255, 255, 255, 255))
    DermaButton2:SetPos( 25, 90 )                    
    DermaButton2:SetSize( 250, 30 )                
    DermaButton2.Paint = function() -- The paint function
        surface.SetDrawColor( 68, 87, 101, 255 ) -- What color do You want to paint the button (R, B, G, A)
        surface.DrawRect( 0, 0, DermaButton2:GetWide(), DermaButton2:GetTall() ) -- Paint what coords (Used a function to figure that out)
    end
    DermaButton2.DoClick = function()
        gui.OpenURL("https://rutube.ru/video/14b3a0bff93f7d8ae84e517600343aba/ ")                
    end

        local DermaButton3 = vgui.Create( "DButton", DermaFrame ) 
    DermaButton3:SetText( "Discord" )                 
    DermaButton3:SetTextColor(Color(255, 255, 255, 255))
    DermaButton3:SetPos( 25, 140 )                    
    DermaButton3:SetSize( 250, 30 )                
    DermaButton3.Paint = function() -- The paint function
        surface.SetDrawColor( 68, 87, 101, 255 ) -- What color do You want to paint the button (R, B, G, A)
        surface.DrawRect( 0, 0, DermaButton3:GetWide(), DermaButton3:GetTall() ) -- Paint what coords (Used a function to figure that out)
    end
    DermaButton3.DoClick = function()
    gui.OpenURL("https://discord.gg/5cfRj3wkUE")                
    end
end