--Posse member, gets gun as long as in own zone or dmz
AddCSLuaFile()

DEFINE_BASECLASS('player_default')

PLAYER = {}

--Possible to redefine abilities here

--Disable sprint
PLAYER.RunSpeed = 400

function PLAYER:Loadout()

  self.Player:RemoveAllAmmo()
  
  self.Player:Give('weapon_pd_revolver')
  self.Player:SetIsSavior( false )
  
end


player_manager.RegisterClass('player_posse', PLAYER, 'player_default')