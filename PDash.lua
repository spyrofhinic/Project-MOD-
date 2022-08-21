--@ BeginProperty
--@ SyncDirection=All
string Effectcode = ""00c2afec75cd4f49b1b3b6441de408a1""
--@ EndProperty

--@ BeginProperty
--@ SyncDirection=All
string Soundcode = ""007e81a16e1045809212d86a2954db20""
--@ EndProperty

--@ BeginProperty
--@ SyncDirection=All
number Cooldown = "0.5"
--@ EndProperty

--@ BeginProperty
--@ SyncDirection=All
number AbleAerial = "1"
--@ EndProperty

--@ BeginProperty
--@ SyncDirection=All
boolean Internalcd = "false"
--@ EndProperty

--@ BeginProperty
--@ SyncDirection=All
number Internalaa = "0"
--@ EndProperty

--@ BeginProperty
--@ SyncDirection=All
boolean Dashmover = "false"
--@ EndProperty

--@ BeginProperty
--@ SyncDirection=All
boolean Dashcdreset = "false"
--@ EndProperty

--@ BeginMethod
--@ MethodExecSpace=ServerOnly
void OnBeginPlay()
{
self.Internalcd = true
}
--@ EndMethod

--@ BeginEntityEventHandler
--@ Scope=All
--@ Target=service:InputService
--@ EventName=KeyDownEvent
HandleKeyDownEvent
{
-- Parameters
local Dashmover = event.Dashmover
local Dashcdreset = event.Dashcdreset
local key = event.key
local transform = self.Entity.TransformComponent
local x = transform.Position.x
local y = transform.Position.y
local z = transform.Position.z
local Gravityback = function()
	self.Entity.RigidbodyComponent:SetForce(Vector2(0,0))
	self.Entity.HitComponent.Enable = true
end
--------------------------------------------------------
if key == KeyboardKey.X and self.Internalcd == true then
	if not self.Entity.RigidbodyComponent:IsOnGround() then
		if self.Internalaa == 0 then
			return
		end
		self.Internalaa = self.Internalaa -1
		self.Entity.RigidbodyComponent.Gravity = 1
		_TimerService:SetTimer(self,Gravityback,0.3,false)
	end
	local Xdir=self.Entity.PlayerControllerComponent.LookDirectionX
	self.Entity.MovementComponent.Enable = true
	self.Entity.HitComponent.Enable = true
	self.Internalcd = true
	self.Entity.RigidbodyComponent:SetForce(Vector2(Xdir*10,0))
	_TimerService:SetTimer(self,Dashmover,0.3,false)
	_TimerService:SetTimer(self,Dashcdreset,self.Cooldown,false)
	_SoundService:PlaySound(self.Soundcode,1,_UserService.LocalPlayer)
	_EffectService:PlayEffect(self.Effectcode,self.Entity,Vector3(x,y,z),0,Vector3(Xdir,1,1),false)
end
}
--@ EndEntityEventHandler

--@ BeginEntityEventHandler
--@ Scope=All
--@ Target=self
--@ EventName=FootholdCollisionEvent
HandleFootholdCollisionEvent
{
-- Parameters
local FootholdNormal = event.FootholdNormal
local ImpactDir = event.ImpactDir
local ImpactForce = event.ImpactForce
local ReflectDir = event.ReflectDir
local Rigidbody = event.Rigidbody
--------------------------------------------------------
self.Internalaa = self.AbleAerial

}
--@ EndEntityEventHandler

