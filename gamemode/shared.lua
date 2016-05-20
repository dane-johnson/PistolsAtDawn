GM.Name = 'Pistols at Dawn'
GM.Author = 'Dane Johnson'
GM.Email = 'dane_johnson@ymail.com'
GM.Website = 'N/A'
GM.Version = '2016-05-16'

local pairs = pairs

--load player classes
include('player_class/player_posse.lua')
include('player_class/player_prisoner.lua')

--Colors
COLOR_WHITE  = Color(255, 255, 255, 255)
COLOR_BLACK  = Color(0, 0, 0, 255)
COLOR_GREEN  = Color(0, 255, 0, 255)
COLOR_DGREEN = Color(0, 100, 0, 255)
COLOR_RED    = Color(255, 0, 0, 255)
COLOR_YELLOW = Color(200, 200, 0, 255)
COLOR_LGRAY  = Color(200, 200, 200, 255)
COLOR_BLUE   = Color(0, 0, 255, 255)
COLOR_NAVY   = Color(0, 0, 100, 255)
COLOR_PINK   = Color(255,0,255, 255)
COLOR_ORANGE = Color(250, 100, 0, 255)
COLOR_OLIVE  = Color(100, 100, 0, 255)

--Create Teams
TEAM_RED  = 1
TEAM_BLUE = 2
TEAM_SPEC = 0

--things to draw
DRAW_NAME  = 1
DRAW_CLASS = 2
DRAW_IS_PRISONER = 4
DRAW_IS_SAVIOR = 8
DRAW_IS_BEING_SAVED = 16
DRAW_SAVIOR = 32

HUDMask = bit.bor(DRAW_NAME, DRAW_CLASS, DRAW_IS_PRISONER, DRAW_IS_SAVIOR, DRAW_IS_BEING_SAVED, DRAW_SAVIOR)

function GM:CreateTeams()
  team.SetUp(TEAM_RED, "Red", COLOR_RED)
  team.SetUp(TEAM_BLUE, "Blue", COLOR_BLUE)
end

-- All teams use the same model
local pd_posse_playermodels = {
   Model("models/player/phoenix.mdl"),
   Model("models/player/arctic.mdl"),
   Model("models/player/guerilla.mdl"),
   Model("models/player/leet.mdl")
}

local pd_prisoner_playermodels = {
  Model("models/player/hostage/hostage_01.mdl"),
  Model("models/player/hostage/hostage_02.mdl"),
  Model("models/player/hostage/hostage_03.mdl"),
  Model("models/player/hostage/hostage_04.mdl"),
}

function GetRandomPlayerModel( ply )
  if ply:IsPrisoner() then 
    return table.Random(pd_prisoner_playermodels)
  else 
    return table.Random(pd_posse_playermodels) 
  end
end

function GM:PlayerShouldTakeDamage(victim, attacker)

  if victim.cellPos ~= victim:GetPos() then victim.isInCell = False end
  if player_manager.GetPlayerClass(victim) == 'player_prisoner' and victim.IsInCell then
    return false
  elseif attacker:IsPlayer() and victim:Team() == attacker:Team() then
    return false
  else
    return true
  end
end

function GM:SetSaviors()
  for _, t in pairs( {TEAM_RED, TEAM_BLUE} ) do 
    for _, prisoner in pairs( team.GetPlayers( t ) ) do 
      if prisoner:IsPrisoner() then
        if not prisoner:IsBeingSaved() then
          for _, s in pairs( team.GetPlayers( t ) ) do
            if (not (s == prisoner)) and AreInSavingRange(s, prisoner) then
              prisoner:SetSavior( s )
            end
          end
        elseif not AreInSavingRange(prisoner, prisoner.savior) then ClearSavior(prisoner) end
      else ClearSavior(prisoner) end
    end
  end
end


function GM:Initialize()
  print('Pistols at Dawn initializing...')
end