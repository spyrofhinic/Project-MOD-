--@ BeginProperty
--@ SyncDirection=None
Vector2 Dir = "Vector2(0,0)"
--@ EndProperty

--@ BeginProperty
--@ SyncDirection=None
number RemainingJumps = "2"
--@ EndProperty

--@ BeginProperty
--@ SyncDirection=None
number LastJump = "0"
--@ EndProperty

--@ BeginEntityEventHandler
--@ Scope=All
--@ Target=service:InputService
--@ EventName=KeyDownEvent
HandleKeyDownEvent
{
-- Parameters
local key = event.key
--------------------------------------------------------
if self.Entity ~= _UserService.LocalPlayer then
    return
end
if key == KeyboardKey.UpArrow then
    self.Dir.y = self.Dir.y + 1
    self._T.isud = true
end
if key == KeyboardKey.DownArrow then
    self.Dir.y = self.Dir.y - 1
    self._T.isdd = true
end
if key == KeyboardKey.RightArrow then
    self.Dir.x = self.Dir.x + 1
    self._T.isrd = true
end
if key == KeyboardKey.LeftArrow then
    self.Dir.x = self.Dir.x - 1
    self._T.isld = true
end
}
--@ EndEntityEventHandler

--@ BeginEntityEventHandler
--@ Scope=All
--@ Target=service:InputService
--@ EventName=KeyUpEvent
HandleKeyUpEvent
{
-- Parameters
local key = event.key
--------------------------------------------------------
if self.Entity ~= _UserService.LocalPlayer then
    return
end
if key == KeyboardKey.UpArrow and self._T.isud ==  true then
    self.Dir.y = self.Dir.y - 1
    self._T.isud = false
end
if key == KeyboardKey.DownArrow and self._T.isdd ==  true then
    self.Dir.y = self.Dir.y + 1
    self._T.isdd = false
end
if key == KeyboardKey.RightArrow and self._T.isrd ==  true then
    self.Dir.x = self.Dir.x - 1
    self._T.isrd = false
end
if key == KeyboardKey.LeftArrow and self._T.isld ==  true then
    self.Dir.x = self.Dir.x + 1
    self._T.isld = false
end
}
--@ EndEntityEventHandler

--@ BeginEntityEventHandler
--@ Scope=All
--@ Target=service:InputService
--@ EventName=KeyDownEvent
HandleKeyDownEvent2
{
-- Parameters
local key = event.key
--------------------------------------------------------
if self.Entity ~= _UserService.LocalPlayer then
    return
end
if self.Dir == Vector2.zero then
    return
end

local rb = self.Entity.RigidbodyComponent
if key == KeyboardKey.LeftAlt and rb:IsOnGround() == false and self.RemainingJumps > 0 and _UtilLogic.ElapsedSeconds - self.LastJump >= 0.3 then
    rb.Gravity = 0
    rb:SetForce(5 * self.Dir)
    local a = math.atan(self.Dir.y/self.Dir.x) / math.pi * 180
    
    local d = nil
    if math.abs(a) == 90 then
        d = -1
    else
        d = -self.Entity.PlayerControllerComponent.LookDirectionX
    end
    _EffectService:PlayEffectAttached("1ebb7ff85f064bf985dea98d8acf5cfd",self.Entity,Vector3.zero,a,Vector3(d, 1, 1),false)
    _SoundService:PlaySound("023794631c0745d1a7015bdadfe449cb",1)
    self.RemainingJumps = self.RemainingJumps - 1
    self.LastJump = _UtilLogic.ElapsedSeconds
    local gf = function() 
        rb.Gravity = 1    
    end
    _TimerService:SetTimerOnce(gf,0.3)
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
if math.abs(FootholdNormal.x) ~= 1 then
    self.Entity.RigidbodyComponent.Gravity = 1
    self.RemainingJumps = 2
end  
}
--@ EndEntityEventHandler

