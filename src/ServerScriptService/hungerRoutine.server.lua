local Players = game:GetService("Players")
local PlayerModule = require(game.ServerStorage.Modules.PlayerModule)
local PlayerLoaded:BindableEvent = game.ServerStorage.BindableEvents.PlayerLoaded
local PlayerUnloaded:BindableEvent = game.ServerStorage.BindableEvents.PlayerUnloaded
local PlayerHungerUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerHungerUpdated



local CORE_LOOP_TIME =  1
local HUNGER_DECREAMENT = 1

local function coreLoop(player: Player)
    while true do
        local currentHunger = PlayerModule.GetHunger(player)
        PlayerModule.SetHunger(player,currentHunger - HUNGER_DECREAMENT)

        task.wait(CORE_LOOP_TIME)
    end

end

local function onPlayerLoaded(player: Player)
    task.spawn(function()
       coreLoop(player) 
    end)
end

PlayerLoaded.Event:Connect(onPlayerLoaded)


