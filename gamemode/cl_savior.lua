--For the client to get updates about saviors

function UpdateSavior()
  local ply = player.GetBySteamID( net.ReadString() )
  local savior = player.GetBySteamID( net.ReadString() )
  
  ply.savior = savior
  print(ply:Nick(),'has savior', savior:Nick())
end
net.Receive("PD_UpdateSavior", UpdateSavior)

function ClearSavior()
  local ply = LocalPlayer()
  ply.savior = nil
end
net.Receive("PD_ClearSavior", ClearSavior)