hook.Add("WeaponEquip", "EnableIt", function(wep, ply)
    local arccw = string.find(wep:GetClass(), "arccw")
    local scp = string.find(wep:GetClass(), "scp")
    if arccw or scp then
        timer.Create("wepeq1", 0.2, 1, function()
            ply:SetWepRaised(true, wep)
        end)
    end
end)