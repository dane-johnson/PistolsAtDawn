include('shared.lua')
include('cl_targetid.lua')
include('player_ext_shd.lua')

function GM:PreDrawHalos()
  for _, p in pairs(player.GetAll()) do 
    if p:IsSavior() then
      halo.Add({p}, team.GetColor(p:Team()), 5, 5, 2)
    end
  end
end