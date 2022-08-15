--@ BeginMethod
--@ MethodExecSpace=All
void SpawnByEntityTemplate()
{
--Sets the parametric value of SpawnByEntityTemplate.
local entityTemplate = _EntityService:GetEntityByPath("/maps/map01/object-49") -- Gets entity placed in map. You can import the path via Workspace > Entity > Right-click > Copy Entity Path.
local name = entityTemplate.Name .. "Copy" -- Sets the name of the entity that will be created.
local spawnPosition = Vector3(2,1,0) -- Sets the location coordinates where it will be created.

local spawnedEntity = _SpawnService:SpawnByEntityTemplate(entityTemplate, name, spawnPosition) --Receiving the spawned entity as variable will allow post-processing of the entity.

if isvalid(spawnedEntity) == false then log("Spawn Failed") end
}
--@ EndMethod

--@ BeginMethod
--@ MethodExecSpace=All
void SpawnByEntityTemplate2()
{
local entityTemplate2 = _EntityService:GetEntityByPath("/maps/map01/object-236") -- Gets entity placed in map. You can import the path via Workspace > Entity > Right-click > Copy Entity Path.
local name2 = entityTemplate2.Name .. "Copy" -- Sets the name of the entity that will be created.
local spawnPosition2 = Vector3(4,2,0) -- Sets the location coordinates where it will be created.

local spawnedEntity2 = _SpawnService:SpawnByEntityTemplate(entityTemplate2, name2, spawnPosition2) 
}
--@ EndMethod

--@ BeginMethod
--@ MethodExecSpace=ServerOnly
void OnBeginPlay()
{
self:SpawnByEntityTemplate()
self:SpawnByEntityTemplate2()
}
--@ EndMethod

