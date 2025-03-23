net.Receive("SCP096Bag", function()
    local ent = net.ReadEntity()
    local bool = net.ReadBool()
    if bool then
      print(ent)
      scp096bag = ent
    else
      scp096bag = nil
    end
end)