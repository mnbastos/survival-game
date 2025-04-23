local PlayerHungerUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerHungerUpdated

--services
local Players = game:GetService("Players")

--constants
local BAR_FULL_COLOR = Color3.fromRGB(26, 255, 1)
local BAR_LOW_COLOR = Color3.fromRGB(255, 81, 1)

--members
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local hud:ScreenGui = PlayerGui:WaitForChild("HUD")
local leftbar:Frame = hud:WaitForChild("LeftBar")
local hungerUi:Frame = leftbar:WaitForChild("Hunger")
local hungerBar:Frame = hungerUi:WaitForChild("bar")

PlayerHungerUpdated.OnClientEvent:Connect(function(hunger:number)
    hungerBar.Size = UDim2.fromScale(hunger/100, hungerBar.Size.Y.Scale)

    if hungerBar.Size.X.Scale > 0.75 then
        hungerBar.BackgroundColor3 = BAR_FULL_COLOR
    else
        hungerBar.BackgroundColor3 = BAR_LOW_COLOR
    end
end)