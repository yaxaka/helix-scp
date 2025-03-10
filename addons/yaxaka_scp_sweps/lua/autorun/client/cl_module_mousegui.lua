AddCSLuaFile()
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