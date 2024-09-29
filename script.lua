local fovRadius = 70
local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local aimingEnabled = false -- New variable to track aiming state

-- Create the GUI
local screenGui = Instance.new("ScreenGui")
local aimButton = Instance.new("TextButton")

-- Configure the button
aimButton.Size = UDim2.new(0, 100, 0, 50)
aimButton.Position = UDim2.new(0.5, -50, 0.5, -25)
aimButton.Text = "Toggle Aim"
aimButton.Parent = screenGui
screenGui.Parent = player:WaitForChild("PlayerGui")

function isEnemy(player)
    return player.Team ~= game.Players.LocalPlayer.Team
end

function isVisible(target)
    local ray = Ray.new(camera.CFrame.p, (target.Position - camera.CFrame.p).unit * 100)
    local hitPart, hitPosition = workspace:FindPartOnRay(ray, player.Character)
    return hitPart == nil
end

function getClosestEnemy()
    local closestEnemy = nil
    local closestDistance = fovRadius

    for _, enemy in pairs(game.Players:GetPlayers()) do
        if isEnemy(enemy) and enemy.Character and enemy.Character:FindFirstChild("Head") then
            local distance = (camera.CFrame.p - enemy.Character.Head.Position).magnitude
            if distance < closestDistance and isVisible(enemy.Character.Head) then
                closestDistance = distance
                closestEnemy = enemy
            end
        end
    end

    return closestEnemy
end

function aimAt(target)
    if target and target.Character and target.Character:FindFirstChild("Head") then
        local headPosition = target.Character.Head.Position
        local aimDirection = (headPosition - camera.CFrame.p).unit
        camera.CFrame = CFrame.new(camera.CFrame.p, camera.CFrame.p + aimDirection)
    end
end

-- Start/stop aiming on button click
aimButton.MouseButton1Click:Connect(function()
    aimingEnabled = not aimingEnabled
    if aimingEnabled then
        aimButton.Text = "Aiming On"
    else
        aimButton.Text = "Aiming Off"
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if aimingEnabled then
        local target = getClosestEnemy()
        aimAt(target)
    end
end)
