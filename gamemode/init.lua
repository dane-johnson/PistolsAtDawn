--     Pistols at Dawn         --
--Coded with <3 by Dane Johnson--

local SAVING_RANGE = 350

AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')
AddCSLuaFile('cl_targetid.lua')
AddCSLuaFile('player_ext_shd.lua')
AddCSLuaFile('cl_savior.lua')

include('shared.lua')
include('player_ext.lua')
include('player_ext_shd.lua')

--Pool some network strings
util.AddNetworkString('PD_UpdateSavior')
util.AddNetworkString('PD_ClearSavior')

function GM:PlayerInitialSpawn( ply )
  local bestTeam = team.BestAutoJoinTeam()
  if bestTeam <= 0 then bestTeam = 1 end
  ply:SetTeam( bestTeam )
  ply:ChatPrint( 'Hello ' .. ply:GetName() .. '. You are on team ' .. team.GetName( bestTeam ) )
  player_manager.SetPlayerClass(ply, 'player_posse')
end

function GM:PostPlayerDeath( ply )
  player_manager.SetPlayerClass( ply, 'player_prisoner' )
  CheckForRoundOver( ply:Team() )
end

function ClearSavior( ply )
  ply.savior = nil
  net.Start("PD_ClearSavior")
  net.WriteString( ply:SteamID() )
  net.Broadcast()
end

function CheckForRoundOver( num )
  roundOver = true
  for _, v  in pairs(team.GetPlayers( num )) do 
    if player_manager.GetPlayerClass( v ) == 'player_posse' then
      roundOver = false
    end
  end
  if roundOver then
    timer.Simple( 5, StartRound )
    print( 'Round is over' )
  end
end

function GM:PlayerSetModel(ply)
  ply:SetModel(GetRandomPlayerModel(ply))
end

function StartRound()
  game.CleanUpMap()
  local plys = player.GetAll()
  
  for _, v in pairs(plys) do 
    player_manager.SetPlayerClass( v, 'player_posse' )
    ClearSavior( v )
    v:Spawn()
  end
end

function AreInSavingRange(p1, p2)
  return p1:GetPos():Distance(p2:GetPos()) <= SAVING_RANGE
end

timer.Create( 'SaviorSet', 1, 0, function() hook.Call('SetSaviors', GAMEMODE) end)

