function yss_module_randomsound(type)
  if type == 1 then
    return tostring("insane/random_insane" .. math.random(1, 18) .. ".wav")
  end

  if type == 2 then
    return tostring("insane/ben" .. math.random(1, 8) .. ".wav")
  end

  if type == 3 then
    return tostring("insane/random_ktoto" .. math.random(1, 8) .. ".wav")
  end

  if type == "trick" then
    return tostring("insane/trick" .. math.random(1, 1) .. ".wav")
  end

  if type == 4 then
    return tostring("insane/male_terrified" .. math.random(1, 5) .. ".wav")
  end

  if type == 5 then
    return tostring("insane/far_insane" .. math.random(1, 2) .. ".wav")
  end  

  if type == 6 then
    return tostring(shiz_table[math.random(1, #shiz_table)])
  end
end

function yss_module_randomsound_pos()
  local lply = LocalPlayer()
  local lpos = lply:GetPos()

  if math.random(1, 2) == 1 then
    lpos = lpos + Vector(math.random(400, 600), 0, 0)
  else
    lpos = lpos - Vector(math.random(400, 600), 0, 0)
  end

  if math.random(1, 2) == 1 then
    lpos = lpos + Vector(0, math.random(400, 600), 0)
  else
    lpos = lpos - Vector(0, math.random(400, 600), 0)
  end

  if math.random(1, 2) == 1 then
    lpos = lpos + Vector(0, 0, math.random(350, 600))
  else
    lpos = lpos - Vector(0, 0, math.random(350, 600))
  end

  return lpos
end


function yss_module_playsound(type)
  local a = yss_module_randomsound_pos()
  local sound2 = yss_module_randomsound(type)
  print(sound2)
  sound.Play(sound2, a)
end