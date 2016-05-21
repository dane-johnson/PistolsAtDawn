--For help spawning a player

function ReGenSpawns()
  SPAWN_POSSE_RED = ents.FindByClass( 'info_player_red' )
  SPAWN_POSSE_BLUE = ents.FindByClass( 'info_player_blue' )
  SPAWN_PRISONER_RED = ents.FindByClass ( 'info_prisoner_red' )
  SPAWN_PRISONER_BLUE = ents.FindByClass( 'info_prisoner_blue' )
end
ReGenSpawns()

function PrintSpawns()
  PrintTable(SPAWN_POSSE_RED)
  PrintTable(SPAWN_POSSE_BLUE)
  PrintTable(SPAWN_PRISONER_RED)
  PrintTable(SPAWN_PRISONER_BLUE)
  print 'done listing spawns'
end

concommand.Add( 'spawns' , PrintSpawns)

local red_player_lru = 1
local blue_player_lru = 1
local red_prisoner_lru = 1
local blue_prisoner_lru = 1

function GM:PlayerSelectSpawn( ply )
  ReGenSpawns()
  local team = ply:Team()
  if team == TEAM_RED then
    if not ply:IsPrisoner() then
      red_player_lru = ((red_player_lru) % #SPAWN_POSSE_RED) + 1
      return SPAWN_POSSE_RED[red_player_lru]
    else 
      red_prisoner_lru = ((red_prisoner_lru) % #SPAWN_PRISONER_RED) + 1
      return SPAWN_PRISONER_RED[red_prisoner_lru]
    end
  else
    if not ply:IsPrisoner() then
      blue_player_lru = ((blue_player_lru) % #SPAWN_POSSE_BLUE) + 1
      return SPAWN_POSSE_BLUE[blue_player_lru]
    else 
      blue_prisoner_lru = ((blue_prisoner_lru) % #SPAWN_PRISONER_BLUE) + 1
      return SPAWN_PRISONER_BLUE[blue_prisoner_lru]
    end
  end
end