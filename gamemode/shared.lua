GM.Name = 'Pistols at Dawn'
GM.Author = 'Dane Johnson'
GM.Email = 'dane_johnson@ymail.com'
GM.Website = 'N/A'
GM.Version = '2016-05-16'

--Round status consts
ROUND_WAIT = 0
ROUND_ACTIVE = 1
ROUND_POST = 2

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
DRAW_IS_SAVIOR = 4

HUDMask = bit.bor(DRAW_NAME, DRAW_CLASS, DRAW_IS_SAVIOR)

function GM:CreateTeams()
  team.SetUp(TEAM_RED, "Red", COLOR_RED)
  team.SetUp(TEAM_BLUE, "Blue", COLOR_BLUE)
end

-- All teams use the same model
local pd_playermodels = {
   Model("models/player/phoenix.mdl"),
   Model("models/player/arctic.mdl"),
   Model("models/player/guerilla.mdl"),
   Model("models/player/leet.mdl")
};

function GetRandomPlayerModel()
  return table.Random(pd_playermodels)
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


function GM:Initialize()
  print('Pistols at Dawn initializing...')
end