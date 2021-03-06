SWEP.Base = 'weapon_pd_base'
SWEP.PrintName = "Revolver"
SWEP.Slot = 0
SWEP.SlotPos = 1
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true

SWEP.ViewModel = "models/weapons/c_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.ViewModelFlip = false

SWEP.HoldType = "revolver"
SWEP.SequenceDraw = "draw"
SWEP.SequenceIdle = "idle01"
SWEP.SequenceHolster = "holster"


SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Sound = "Weapon_357.Single"
SWEP.Primary.Sequence = "fire"
SWEP.Primary.Damage = 200
SWEP.Primary.Cone = 0
SWEP.Primary.DryFireSequence = "fireempty"
SWEP.Primary.DryFireSound = Sound("Weapon_Pistol.Empty")
SWEP.Primary.Recoil = 9
SWEP.Primary.InfiniteAmmo = true
SWEP.Primary.AutoReload = true


SWEP.ReloadSequence = "reload"
SWEP.ReloadSound = Sound("Weapon_357.Reload")

function SWEP:DoPrimaryAttackEffect(stats)
	local bullet = {}	-- Set up the shot
	bullet.Num = self.Primary.NumShots or 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector(stats.cone or 0, stats.cone or 0, 0)
	bullet.Tracer = 1
	bullet.TracerName = "pd_revolver_shoot"
	bullet.Force = self.Primary.Force or ((self.Primary.Damage or 1) * 3)
	bullet.Damage = stats.damage or 1
	self.Owner:FireBullets(bullet)
	
	local eff = EffectData()
	eff:SetOrigin(self.Owner:GetShootPos())
	eff:SetNormal(self.Owner:GetAimVector())
	eff:SetEntity(self.Owner)
	eff:SetAttachment(1)
  util.Effect("pd_revolver_shoot",eff)
end