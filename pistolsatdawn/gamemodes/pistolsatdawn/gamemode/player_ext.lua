AddCSLuaFile()
local meta = FindMetaTable ( "Player" )

--NOTE in final release, use SteamID
function meta:SetSavior( savior )
  self.savior = savior
  net.Start( "PD_UpdateSavior" )
  if DEBUG then
    net.WriteString( self:Nick() )
    net.WriteString( savior:Nick() )
  else
    net.WriteString( self:SteamID() )
    net.WriteString( savior:SteamID() )
  end
  net.Broadcast()
end

function meta:SetIsSavior( truth )
  self.isSavior = truth
  net.Start( "PD_SetIsSavior" )
  if DEBUG then
    net.WriteString( self:Nick() )
  else
    net.WriteString( self:SteamID() )
  end
  net.WriteBool( truth )
  net.Broadcast()
end


function meta:MakeSpectator()
  player_manager.SetPlayerClass( self , 'player_specator' )
  self:SetTeam( TEAM_SPEC )
  self:Spectate( OBS_MODE_ROAMING )
  self:Spawn()
  MsgN(self:Nick(), ' is now spectating.')
end

function meta:JoinTeam( teamNo )
  if self:Team() == TEAM_SPEC then
    self:UnSpectate()
    self:SetTeam ( teamNo )
    player_manager.SetPlayerClass( self, 'player_prisoner')
    self:Spawn()
  elseif teamNo ~= self:Team() then
    self:Kill()
    self:SetTeam( teamNo )
  end
end