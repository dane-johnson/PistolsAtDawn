--For the client to get updates about saviors

function UpdateSavior()
  local ply
  local savior
  if DEBUG then
    ply = ents.FindByName( net.ReadString() )[1]
    savior = ents.FindByName( net.ReadString() )[1]
  else
    ply = player.GetBySteamID( net.ReadString() )
    savior = player.GetBySteamID( net.ReadString() )
  end
  if ply and savior then
    ply.savior = savior
  end
end
net.Receive("PD_UpdateSavior", UpdateSavior)

function ClearSavior()
  local ply
  if DEBUG then 
    ply = ents.FindByName( net.ReadString() )[1]
  else
    ply = player.GetBySteamID( net.ReadString() )
  end
  if ply then
    ply.savior = nil
  end
end
net.Receive("PD_ClearSavior", ClearSavior)

function SetIsSavior()
  local ply
  if DEBUG then
    ply = ents.FindByName( net.ReadString() )[1]
  else
    ply = player.GetBySteamID( net.ReadString() )
  end
  local truth = net.ReadBool()
  if ply then
    ply.isSavior = truth
  end
end
net.Receive("PD_SetIsSavior", SetIsSavior)