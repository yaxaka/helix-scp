AddCSLuaFile()
net.Receive("SCP035_Psy1", function()
  local psyhoz = net.ReadInt(5)
  yss_module_psyhoz(psyhoz)
end)

net.Receive("SCP035RestoreView", function()
  local lply = LocalPlayer()
  lply.InsaneColor = false
  lply.under_035 = false
end)

net.Receive("SCP035_Psy2", function()
  local task = net.ReadString()
  local lply = LocalPlayer()

  timer.Create("SoundMessage", 1, 1, function()
    surface.PlaySound("insane/new_message.wav")

    timer.Create("NewMessage035", 1.5, 1, function()
      lply.draw_masks = true
      lply.under_035 = true
      yss_module_victim035_message(task)
    end)
  end)
end)

net.Receive("SCP035Remove", function()
    local ply = net.ReadEntity()
    yss_module_remove035list(ply)
end)


net.Receive("SCP035VictimTable", function()
    local ply = net.ReadEntity()
    yss_module_prelist(ply)
end)

net.Receive("SCP035_PsyZombie", function()
    yss_module_victim035_zombietrick()
end)

net.Receive("SCP035Change", function()
    local lply = LocalPlayer()
    local lvl = net.ReadInt(5)
    local bool = net.ReadBool()
    if (lvl ~= nil) then
      lply.InsaneColorStage = lvl
    end
    if (bool ~= nil) then
      lply.under_035 = bool
    end
end)