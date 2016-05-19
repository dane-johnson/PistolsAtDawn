local meta = FindMetaTable ( "Player" )

function meta:IsSavior()
  return player_manager.GetPlayerClass( self ) == 'player_posse'
end