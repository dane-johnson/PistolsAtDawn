function ShowTeamSelector()
  --Who is calling? Get the player
  local ply = LocalPlayer()

  --Setup the frame
  local frame = vgui.Create( "DFrame" )
  frame:SetPos( ScrW() / 2 - (175 / 2), ScrH() / 2 - (200 / 2) )
  frame:SetSize ( 175, 200)
  frame:SetTitle( "Select Team" )
  frame:SetDraggable( true )
  
  --Add the buttons
  local top = 50
  local texts = { "Spectator", "Red", "Blue" }
  for i = 1, 3 do
    local button = vgui.Create( "DButton" )
    button:SetParent( frame )
    button:SetPos( 50, top )
    button:SetText( texts[i] )
    
    button.DoClick = function()
      net.Start( 'PD_PlayerSelectedTeam' )
      net.WriteString( ply:SteamID() )
      net.WriteFloat( i - 1 ) --Bad future proofing, these are indexed at 0
      net.SendToServer()
      frame:Close()
    end
    
    top = top + 50
  end
  
  --Show the frame
  frame:MakePopup()
  
end