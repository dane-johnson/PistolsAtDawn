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
include('sv_spawn.lua')

--Pool some network strings
util.AddNetworkString('PD_UpdateSavior')
util.AddNetworkString('PD_ClearSavior')
util.AddNetworkString('PD_SetIsSavior')

function GM:PlayerInitialSpawn( ply )
  ply:MakeSpectator()
end

function GM:PlayerButtonDown( ply, button )
  if button == KEY_F2 then
    ply:JoinTeam( TEAM_RED )
  elseif button == KEY_F3 then
    ply:JoinTeam( TEAM_BLUE )
  end
end

function GM:PostPlayerDeath( ply )
  player_manager.SetPlayerClass( ply, 'player_prisoner' )
  CheckForRoundOver( ply:Team() )
end

function GM:PlayerDisconnected( ply )
  CheckForRoundOver ( ply:Team() )
end

function ClearSavior( ply )
  ply.savior = nil
  net.Start("PD_ClearSavior")
  if DEBUG then
    net.WriteString( ply:Nick() )
  else
    net.WriteString( ply:SteamID() )
  end
  net.Broadcast()
end

function CheckForRoundOver( num )
  if GAMEMODE.state == GAME_ACTIVE then
    local roundOver = true
    for _, v  in pairs(team.GetPlayers( num )) do 
      if player_manager.GetPlayerClass( v ) == 'player_posse' then
        roundOver = false
      end
    end
    if roundOver then
      timer.Simple( 5, StartRound )
      GAMEMODE.state = GAME_RESTARTING
      MsgN( 'Round is over' )
    end
  end
end

function GM:PlayerSetModel(ply)
  ply:SetModel(GetRandomPlayerModel(ply))
end
--Entities not to clean up
NOCLEAN = {
  'info_player_red',
  'info_player_blue',
  'info_prisoner_red',
  'info_prisoner_blue',
}

function StartRound()
  local plys = player.GetAll()
  
  for _, v in pairs(plys) do 
    player_manager.SetPlayerClass( v, 'player_posse' )
    ClearSavior( v )
    v:Spawn()
  end
  game.CleanUpMap(false, NOCLEAN)
  GAMEMODE.state = GAME_ACTIVE
end

function AreInSavingRange(p1, p2)
  return p1:GetPos():Distance(p2:GetPos()) <= SAVING_RANGE
end

function GM:Initialize()
  print('Pistols at Dawn initializing...')
  timer.Create( 'SaviorSet', 1, 0, function() hook.Call('SetSaviors', GAMEMODE) end)
  StartRound()
end

