local Window = Fluent:CreateWindow({
    Title = "Auto Farm",
    SubTitle = "Match Selection",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark"
})

local Tab = Window:AddTab({ Title = "Match Selection", Icon = "house" })

local selectedAutoFarmMode = "Ranked 1v1"

local Dropdown = Tab:AddDropdown("MatchTypeDropdown", {
    Title = "Select Match Type",
    Values = {"Ranked 1v1", "Casual 1v1", "Ranked 2v2", "Casual 2v2"},
    Multi = false,
    Default = "Ranked 1v1",
    Callback = function(Value)
        selectedAutoFarmMode = Value
    end
})

Tab:AddButton({
    Title = "Teleport to Match",
    Callback = function()
        ExecuteLoadstringInLobby()
    end
})

local function ExecuteLoadstringInLobby()
    if game.PlaceId == 17016840407 then
        local targetPart
        if selectedAutoFarmMode == "Ranked 1v1" then
            targetPart = workspace.Ranked1v1.Insides
        elseif selectedAutoFarmMode == "Casual 1v1" then
            targetPart = workspace.Casual1v1.Insides
        elseif selectedAutoFarmMode == "Ranked 2v2" then
            targetPart = workspace.Ranked2v2.Insides
        elseif selectedAutoFarmMode == "Casual 2v2" then
            targetPart = workspace.Casual2v2.Insides
        end
        
        if targetPart then
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            
            local tweenService = game:GetService("TweenService")
            local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            
            local tween = tweenService:Create(humanoidRootPart, tweenInfo, {CFrame = targetPart.CFrame})
            tween:Play()
        else
            warn("Target part not found for selected mode: " .. tostring(selectedAutoFarmMode))
        end
    end
end

