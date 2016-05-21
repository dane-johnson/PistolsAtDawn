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