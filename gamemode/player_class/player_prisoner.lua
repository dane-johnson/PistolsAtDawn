--Prisoner, has no guns, can only be in prison and next to teammates
AddCSLuaFile()

DEFINE_BASECLASS('player_default')

PLAYER = {}

--Possible to redefine abilities here, not neccesary

function PLAYER:Loadout()

  self.Player:RemoveAllAmmo()
  self.Player.isInCell = true
  
end

function PLAYER:Spawn()

  self.Player.cellPos = nil
  
end

player_manager.RegisterClass('player_prisoner', PLAYER, 'player_default')