--     Pistols at Dawn         --
--Coded with <3 by Dane Johnson--

AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')
AddCSLuaFile('cl_targetid.lua')

include('shared.lua')

function GM:PlayerInitialSpawn(ply)
  local bestTeam = team.BestAutoJoinTeam()
  if bestTeam <= 0 then bestTeam = 1 end
  ply:SetTeam(bestTeam)
  ply:ChatPrint('Hello ' .. ply:GetName() .. '. You are on team ' .. team.GetName(bestTeam))
  player_manager.SetPlayerClass(ply, 'player_posse')
end

function GM:PostPlayerDeath(ply)
  player_manager.SetPlayerClass(ply, 'player_prisoner')
end

function GM:PlayerSetModel(ply)
  ply:SetModel(GetRandomPlayerModel())
end

