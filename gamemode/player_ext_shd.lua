local meta = FindMetaTable ( "Player" )

function meta:IsPrisoner()
  return player_manager.GetPlayerClass ( self ) == 'player_prisoner'
end

-- Test if a player can rescue
function meta:IsSavior()
  return player_manager.GetPlayerClass( self ) == 'player_posse'
end

-- Test if a player is being saved
function meta:IsBeingSaved()
  return not (self.savior == nil)
end

function meta:GetSavior()
  if self.savior then
    return self.savior:Nick()
  end
end

-- Call when a player has rescued a player
function meta:Save( tgt )
  if tgt:IsPrisoner() and self:IsSavior() then
    player_manager.SetPlayerClass( tgt, 'player_posse' )
    tgt:Spawn()
  end
end