AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')

include('shared.lua')

function GM:PlayerInitialSpawn(ply)
  local bestTeam = team.BestAutoJoinTeam()
  if bestTeam <= 0 then bestTeam = 1 end
  ply:SetTeam(bestTeam)
  ply:ChatPrint('Hello ' .. ply:GetName() .. '. You are on team ' .. team.GetName(bestTeam))
end

function GM:PlayerSetModel(ply)
  ply:SetModel(GetRandomPlayerModel())
end

function GM:PlayerLoadout(ply)
  ply:Give('weapon_pd_revolver')
end