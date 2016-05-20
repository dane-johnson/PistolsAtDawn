ENT.type = "brush"

ENT.TeamNo = TEAM_RED

function ENT:KeyValue( key, value )
  local key = string.lower(key)
  local value = string.lower(value)
  if key == 'team' then
    if value == 'red' then
      self.TeamNo = TEAM_RED
    elseif value == 'blue' then
      self.TeamNo = TEAM_BLUE
    end
  end
end

function ENT:Touch( ply )
  if ply:IsPlayer() then
    --if they are on the our team team
    if ply:Team() = self.TeamNo then
      --if they are a posse member, give them a gun, they are no longer a savior
      if not ply:IsPrisoner() then
        ply:Give( 'weapon_pd_revolver' )
        ply:SetSavior( false )
      else
      --if they are a returning prisoner, make them a posse member and respawn them
      player_manager.SetPlayerClass( ply, 'player_posse' )
      ply:Spawn()
    else
    --other team member
      --if they are a prisoner
      if ply:IsPrisoner() then
        --Kill them if they have no savior
        if not ply:IsBeingSaved() then ply:Kill() end
      else
      --if they are a posse memer
        --strip their weapons, make them a savior
        ply:StripWeapons()
        ply:SetIsSavior( true )
      end
    end
  end
end