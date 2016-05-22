--Spectator, fuck this class
AddCSLuaFile()

PLAYER = {}

--Possible to redefine abilities here, not neccesary

function PLAYER:Loadout()

  self.Player:StripWeapons()
  self.Player:Spectate( OBS_MODE_ROAMING )
  
end

player_manager.RegisterClass('player_specator', PLAYER, 'player_default')