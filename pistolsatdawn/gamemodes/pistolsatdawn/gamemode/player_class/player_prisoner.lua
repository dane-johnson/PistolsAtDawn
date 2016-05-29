--Prisoner, has no guns, can only be in prison and next to teammates
AddCSLuaFile()

DEFINE_BASECLASS('player_default')

PLAYER = {}

--Possible to redefine abilities here

--Disable sprint
PLAYER.RunSpeed = 200

function PLAYER:Loadout()

  self.Player:RemoveAllAmmo()
  self.Player:SetIsSavior( false )
  
end

player_manager.RegisterClass('player_prisoner', PLAYER, 'player_default')