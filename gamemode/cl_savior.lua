--For the client to get updates about saviors

function UpdateSavior()
  local ply = player.GetBySteamID( net.ReadString() )
  local savior = player.GetBySteamID( net.ReadString() )
  
  ply.savior = savior
end
net.Receive("PD_UpdateSavior", UpdateSavior)

function ClearSavior()
  local ply = player.GetBySteamID( net.ReadString() )
  ply.savior = nil
end
net.Receive("PD_ClearSavior", ClearSavior)

function SetIsSavior()
  local ply = player.GetBySteamID( net.ReadString() )
  local truth = net.ReadBool()
  
  ply.isSavior = truth
end
net.Receive("PD_SetIsSavior", SetIsSavior)