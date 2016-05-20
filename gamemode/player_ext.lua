AddCSLuaFile()
local meta = FindMetaTable ( "Player" )

--NOTE in final release, use SteamID
function meta:SetSavior( savior )
  self.savior = savior
  net.Start( "PD_UpdateSavior" )
  net.WriteString( self:SteamID() )
  net.WriteString( savior:SteamID() )
  net.Broadcast()
end

function meta:SetIsSavior( truth )
  self.isSavior = truth
  net.Start( "PD_SetIsSavior" )
  net.WriteString( self:SteamID() )
  net.WriteBool( truth )
  net.Broadcast()
end