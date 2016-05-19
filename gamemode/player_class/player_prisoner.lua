--Prisoner, has no guns, can only be in prison and next to teammates
AddCSLuaFile()

DEFINE_BASECLASS('player_default')

PLAYER = {}

--Possible to redefine abilities here, not neccesary

function PLAYER:Loadout()

  self.Player:RemoveAllAmmo()
  
end

player_manager.RegisterClass('player_prisoner', PLAYER, 'player_default')