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