local PlayerModule = {}

--SERVICES
local Players = game:GetService("Players")
local DataStorageService= game:GetService("DataStoreService")

--CONStANTS
local PLAYER_DEFAULT_DATA = {
    hunger = 50,
    inventory = {},
    level = 1
}


--MEMBERS
local PlayersCached = {}  ---dicionario com os jogadores
local database = DataStorageService:GetDataStore("Survival")
local PlayerLoaded:BindableEvent = game.ServerStorage.BindableEvents.PlayerLoaded
local PlayerUnloaded:BindableEvent = game.ServerStorage.BindableEvents.PlayerUnloaded

function PlayerModule.IsLoaded(player:Player)
    local isLoaded = PlayersCached[player.UserId] and true or false
    return isLoaded
end

function PlayerModule.GetHunger(player: Player)
    return PlayersCached[player.UserId].hunger 
end

function  PlayerModule.SetHunger(player: Player, hunger:number)
    PlayersCached[player.UserId].hunger = hunger
    
end


local function onPlayerAdded(player:Player)
    player.CharacterAdded:Connect(function(_)
        local data = database:GetAsync(player.UserId)
        if not data then
            data = PLAYER_DEFAULT_DATA
            print("data default")
        end
        PlayersCached[player.UserId]=data

        PlayerLoaded:Fire(player)
        print("data user")
    end)
end

local function onPlayerRemoving(player:Player)
    PlayerUnloaded:Fire(player)
    database:GetVersionAsync(player.UserId, PlayersCached(player.UserId))
    PlayersCached[player.UserId] = nil
end


Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)




return PlayerModule