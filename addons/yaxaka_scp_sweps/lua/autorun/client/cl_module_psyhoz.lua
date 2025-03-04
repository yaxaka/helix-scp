AddCSLuaFile()
local function minmax(n1, n2)
  return math.random(n1, n2)
end


concommand.Add("enablepsyhoz1", function()
    yss_module_psyhoz(1)
end)
concommand.Add("enablepsyhoz2", function()
    yss_module_psyhoz(2)
end)
concommand.Add("enablepsyhoz3", function()
    yss_module_psyhoz(3)
end)
concommand.Add("enablepsyhoz4", function()
    yss_module_psyhoz(4)
end)
concommand.Add("enablepsyhoz5", function()
    yss_module_psyhoz(5)
end)
concommand.Add("enablepsyhoz6", function()
    yss_module_psyhoz(6)
end)



function yss_module_psyhoz(stage)
  local lply = LocalPlayer()

  if stage == 1 then
    lply.InsaneColorStage = 1
    lply.InsaneColor = true

    timer.Create("Psyhoz_Stage1", 1, 1, function()
      --Stuff
    end)

    timer.Create("Psyhoz_Stage1_S", minmax(1, 3), 4, function()
      yss_module_playsound(6)
    end) 
  end



  if stage == 2 then
    timer.Create("Psyhoz_Stage2", minmax(1, 3), 1, function()
      yss_module_playsound("trick")
      lply.InsaneColorStage = 2

      timer.Create("Psyhoz_Stage2_S", minmax(3, 6), minmax(1, 2), function()
        yss_module_playsound(6)
      end)

      timer.Create("Psyhoz_Stage2_S2", minmax(6, 9), minmax(1, 2), function()
        yss_module_playsound(3)
      end)
    end)
  end



  if stage == 3 then
    timer.Create("Psyhoz_Stage3", minmax(1, 3), 1, function()
      lply.InsaneColorStage = 3

      timer.Create("Psyhoz_Stage3_S", minmax(3, 6), minmax(1, 2), function()
        yss_module_playsound(1)
      end)

      timer.Create("Psyhoz_Stage3_S2", minmax(6, 9), minmax(1, 2), function()
        yss_module_playsound(4)
      end)

      timer.Create("Psyhoz_Stage3_S3", minmax(1, 1), minmax(1, 1), function()
        yss_module_playsound(6)
      end)
    end)
  end



  if stage == 4 then
    timer.Create("Psyhoz_Stage4", minmax(1, 1), 1, function()
      lply.InsaneColorStage = 4

      timer.Create("Psyhoz_Stage4_S", minmax(1, 4), minmax(1, 2), function()
        yss_module_playsound(2)
      end)

      timer.Create("Psyhoz_Stage4_S2", minmax(1, 3), minmax(1, 2), function()
        yss_module_playsound(3)
      end)

      timer.Create("Psyhoz_Stage4_S3", minmax(1, 3), minmax(1, 2), function()
        yss_module_playsound(6)
      end)
    end)
  end



  if stage == 5 then
    timer.Create("Psyhoz_Stage5", minmax(1, 1), 1, function()
      lply.InsaneColorStage = 5
      yss_module_playsound(5)

      timer.Create("Psyhoz_Stage5_S", minmax(1, 4), minmax(1, 2), function()
        yss_module_playsound(1)
      end)

      timer.Create("Psyhoz_Stage5_S2", minmax(1, 5), minmax(1, 2), function()
        yss_module_playsound(3)
      end)

      timer.Create("Psyhoz_Stage5_S3", minmax(1, 7), minmax(1, 2), function()
        yss_module_playsound(4)
      end)

      timer.Create("Psyhoz_Stage5_S4", minmax(1, 8), minmax(1, 2), function()
        yss_module_playsound(6)
      end)
    end)
  end



  if stage == 6 then
    timer.Create("Psyhoz_Stage6", minmax(1, 1), 1, function()
      lply.InsaneColorStage = 6
      yss_module_playsound(5)

      timer.Create("Psyhoz_Stage6_S", minmax(1, 4), minmax(1, 2), function()
        yss_module_playsound(1)
      end)

      timer.Create("Psyhoz_Stage6_S2", minmax(1, 4), minmax(1, 2), function()
        yss_module_playsound(3)
      end)

      timer.Create("Psyhoz_Stage6_S3", minmax(1, 4), minmax(1, 2), function()
        yss_module_playsound(4)
      end)

      timer.Create("Psyhoz_Stage6_S4", minmax(1, 4), minmax(1, 2), function()
        yss_module_playsound(6)
      end)
    end)
  end
end