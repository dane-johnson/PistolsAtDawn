--For displaying information above a player

local surface = surface
local pairs = pairs
local band = bit.band
local insert = table.insert

surface.CreateFont("TargetIDSmall2", {font = "TargetID", size = 16, weight = 1000})

-- function DrawLabels(client)

  -- local tgt = nil
  -- local scrpos = nil
  -- local text = nil
  -- local w = nil
  -- for _, ply in pairs(player.GetAll()
-- -- Draw the labels
-- end

function GM:HUDDrawTargetID()
  local client = LocalPlayer()
  
  local trace = client:GetEyeTrace(MASK_SHOT)
  local ent = trace.Entity
  
  if (not IsValid(ent)) or ent.NoTarget then return end
  
  local text = {}
  local color = COLOR_WHITE
  
  if ent:IsPlayer() then 
    color = team.GetColor(ent:Team())
    
    if band(HUDMask, DRAW_NAME) > 0 then insert(text, ent:Nick()) end
    if band(HUDMask, DRAW_CLASS) > 0 then insert(text, player_manager.GetPlayerClass(ent)) end
    
    local x = ScrW() / 2.0
    local y = ScrH() / 2.0
  
    local w, h = 0, 0 
    local font = "TargetID"
    surface.SetFont("TargetID")
    
    for _, v in pairs(text) do 
      w, h = surface.GetTextSize(v)
      draw.SimpleText(v, font, x - w / 2, y, color)
      y = y + h + 4
    end
  end
end
  