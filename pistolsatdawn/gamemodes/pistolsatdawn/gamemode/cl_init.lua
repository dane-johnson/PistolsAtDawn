include('shared.lua')
include('cl_targetid.lua')
include('player_ext_shd.lua')
include('cl_savior.lua')
include('vgui/team_selection.lua')

function GM:PreDrawHalos()
  for _, p in pairs(player.GetAll()) do 
    if p:IsSavior() or p:IsBeingSaved() then
      halo.Add({p}, team.GetColor(p:Team()), 5, 5, 2)
    end
  end
end

function ShowTeamSelectionMenu()
  ShowTeamSelector()
end
net.Receive( 'PD_OpenTeamSelectionMenu', ShowTeamSelectionMenu)